import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { CrearEmpleado, Empleado } from '../models/empleado.model';

/**
 * Única responsabilidad: hablar HTTP con la API de empleados.
 * Ningún componente hace HttpClient.get/post directamente
 * (requisito del enunciado: "el consumo HTTP debe estar en un servicio").
 */
@Injectable({ providedIn: 'root' })
export class EmpleadoService {
  private readonly baseUrl = 'http://localhost:5000/api/empleados';

  constructor(private readonly http: HttpClient) {}

  listar(): Observable<Empleado[]> {
    return this.http.get<Empleado[]>(this.baseUrl);
  }

  obtenerPorDocumento(documento: number): Observable<Empleado> {
    return this.http.get<Empleado>(`${this.baseUrl}/${documento}`);
  }

  crear(empleado: CrearEmpleado): Observable<Empleado> {
    return this.http.post<Empleado>(this.baseUrl, empleado);
  }
}
