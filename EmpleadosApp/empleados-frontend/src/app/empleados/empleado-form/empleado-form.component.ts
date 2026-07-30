import { CommonModule } from '@angular/common';
import { Component, EventEmitter, Output, inject, signal } from '@angular/core';
import { FormBuilder, ReactiveFormsModule, Validators } from '@angular/forms';
import { HttpErrorResponse } from '@angular/common/http';
import { finalize } from 'rxjs';
import { EmpleadoService } from '../../core/services/empleado.service';
import { Empleado } from '../../core/models/empleado.model';
import { IconComponent } from '../../shared/icon/icon.component';
import { AlertBannerComponent } from '../../shared/alert-banner/alert-banner.component';

/**
 * Única responsabilidad: capturar y validar los datos de un nuevo
 * empleado, delegar la creación al EmpleadoService y comunicar el
 * resultado. No sabe qué pasa después (refrescar la lista, mostrar
 * un toast global, etc.) — eso lo decide el componente padre a
 * través del evento `creado`.
 */
@Component({
  selector: 'app-empleado-form',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule, IconComponent, AlertBannerComponent],
  templateUrl: './empleado-form.component.html',
  styleUrl: './empleado-form.component.css'
})
export class EmpleadoFormComponent {
  @Output() creado = new EventEmitter<Empleado>();

  private readonly fb = inject(FormBuilder);
  private readonly empleadoService = inject(EmpleadoService);

  // Signals en vez de propiedades planas: garantizan que la vista se
  // actualice de inmediato al llegar la respuesta HTTP (éxito o error),
  // sin depender de que la detección de cambios basada en zone.js
  // decida "cuándo" revisar este componente.
  readonly guardando = signal(false);
  readonly mensajeError = signal<string | null>(null);
  readonly mensajeExito = signal<string | null>(null);

  form = this.fb.group({
    documento: [null as number | null, [Validators.required]],
    nombres: ['', [Validators.required]],
    apellidos: ['', [Validators.required]],
    email: ['', [Validators.required, Validators.email]],
    cargo: [''],
    departamento: [''],
    salario: [null as number | null, [Validators.required, Validators.min(0.01)]],
    fechaIngreso: ['', [Validators.required]]
  });

  guardar(): void {
    this.mensajeError.set(null);
    this.mensajeExito.set(null);

    if (this.form.invalid) {
      this.form.markAllAsTouched();
      return;
    }

    this.guardando.set(true);
    const valores = this.form.getRawValue();

    this.empleadoService
      .crear({
        documento: Number(valores.documento),
        nombres: valores.nombres!,
        apellidos: valores.apellidos!,
        email: valores.email!,
        cargo: valores.cargo || undefined,
        departamento: valores.departamento || undefined,
        salario: Number(valores.salario),
        fechaIngreso: valores.fechaIngreso!
      })
      // finalize() corre siempre al terminar el observable (éxito o
      // error), así el botón nunca puede quedar atascado en "Guardando...".
      .pipe(finalize(() => this.guardando.set(false)))
      .subscribe({
        next: (empleado) => {
          this.form.reset();
          this.mensajeExito.set('El usuario ha sido registrado exitosamente!');
          this.creado.emit(empleado);
        },
        error: (err: HttpErrorResponse) => {
          // El backend responde 409 con { mensaje: '...' } cuando el
          // documento/email ya existe (ver EmpleadosController.Crear).
          this.mensajeError.set(err.error?.mensaje ?? 'No se pudo guardar el empleado. Intenta de nuevo.');
        }
      });
  }

  campoInvalido(nombre: string): boolean {
    const control = this.form.get(nombre);
    return !!control && control.invalid && control.touched;
  }
}
