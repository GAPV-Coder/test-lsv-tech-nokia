import { Component, Input, OnChanges, SimpleChanges } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Empleado } from '../../core/models/empleado.model';
import { IconComponent } from '../../shared/icon/icon.component';

const EMPLEADOS_POR_PAGINA = 8;

/**
 * "Dumb component": únicamente muestra los empleados que recibe por
 * @Input. No conoce el EmpleadoService ni hace peticiones HTTP —
 * eso es responsabilidad exclusiva de EmpleadosPageComponent. La
 * paginación y la búsqueda por email son puramente de presentación
 * (filtran/recortan datos ya cargados), así que viven aquí.
 */
@Component({
  selector: 'app-empleados-list',
  standalone: true,
  imports: [CommonModule, IconComponent],
  templateUrl: './empleados-list.component.html',
  styleUrl: './empleados-list.component.css'
})
export class EmpleadosListComponent implements OnChanges {
  @Input() empleados: Empleado[] = [];
  @Input() cargando = false;

  paginaActual = 1;
  terminoBusqueda = '';
  readonly empleadosPorPagina = EMPLEADOS_POR_PAGINA;

  ngOnChanges(changes: SimpleChanges): void {
    if (changes['empleados']) {
      this.paginaActual = 1;
    }
  }

  get empleadosFiltrados(): Empleado[] {
    const termino = this.terminoBusqueda.trim().toLowerCase();
    if (!termino) {
      return this.empleados;
    }
    return this.empleados.filter((emp) => emp.email.toLowerCase().includes(termino));
  }

  get totalPaginas(): number {
    return Math.max(1, Math.ceil(this.empleadosFiltrados.length / this.empleadosPorPagina));
  }

  get empleadosPagina(): Empleado[] {
    const inicio = (this.paginaActual - 1) * this.empleadosPorPagina;
    return this.empleadosFiltrados.slice(inicio, inicio + this.empleadosPorPagina);
  }

  buscar(termino: string): void {
    this.terminoBusqueda = termino;
    this.paginaActual = 1;
  }

  irAPagina(pagina: number): void {
    this.paginaActual = Math.min(Math.max(pagina, 1), this.totalPaginas);
  }

  formatearSalario(valor: number): string {
    return new Intl.NumberFormat('es-CO', {
      style: 'currency',
      currency: 'COP',
      maximumFractionDigits: 0
    }).format(valor);
  }
}
