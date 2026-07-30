import { Component, OnInit, inject, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { finalize } from 'rxjs';
import { EmpleadoService } from '../core/services/empleado.service';
import { Empleado } from '../core/models/empleado.model';
import { EmpleadosListComponent } from './empleados-list/empleados-list.component';
import { EmpleadoFormComponent } from './empleado-form/empleado-form.component';
import { AlertBannerComponent } from '../shared/alert-banner/alert-banner.component';
import { IconComponent } from '../shared/icon/icon.component';

/**
 * "Smart component": es el único que conoce el EmpleadoService y
 * coordina el listado con el formulario. EmpleadosListComponent y
 * EmpleadoFormComponent son "dumb components" que solo reciben datos
 * o emiten eventos — no saben nada de HTTP.
 */
@Component({
  selector: 'app-empleados-page',
  standalone: true,
  imports: [CommonModule, EmpleadosListComponent, EmpleadoFormComponent, AlertBannerComponent, IconComponent],
  templateUrl: './empleados-page.component.html',
  styleUrl: './empleados-page.component.css'
})
export class EmpleadosPageComponent implements OnInit {
  private readonly empleadoService = inject(EmpleadoService);

  // Signals: la vista se refresca de inmediato al llegar la respuesta
  // HTTP, sin depender de que zone.js dispare la detección de cambios.
  readonly empleados = signal<Empleado[]>([]);
  readonly cargando = signal(true);
  readonly mensajeExito = signal<string | null>(null);

  private timeoutMensajeExito?: ReturnType<typeof setTimeout>;

  ngOnInit(): void {
    this.cargarEmpleados();
  }

  cargarEmpleados(): void {
    this.cargando.set(true);
    this.empleadoService
      .listar()
      .pipe(finalize(() => this.cargando.set(false)))
      .subscribe({
        next: (empleados) => this.empleados.set(empleados)
      });
  }

  onEmpleadoCreado(empleado: Empleado): void {
    this.mensajeExito.set(`Empleado "${empleado.nombres} ${empleado.apellidos}" creado correctamente.`);
    this.cargarEmpleados();

    // El mensaje de éxito se oculta solo después de unos segundos.
    clearTimeout(this.timeoutMensajeExito);
    this.timeoutMensajeExito = setTimeout(() => this.mensajeExito.set(null), 4000);
  }
}
