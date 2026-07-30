/**
 * Representa el contrato que expone la API (EmpleadoDto en el backend).
 * Vive en /core/models porque lo usan tanto el listado como el
 * formulario: es un modelo transversal, no propio de un componente.
 */
export interface Empleado {
  idEmpleado: number;
  documento: number;
  nombres: string;
  apellidos: string;
  email: string;
  cargo?: string;
  departamento?: string;
  salario: number;
  fechaIngreso: string; // ISO string
}

/**
 * Datos que se envían al crear un empleado (sin idEmpleado, que lo
 * asigna la base de datos).
 */
export interface CrearEmpleado {
  documento: number;
  nombres: string;
  apellidos: string;
  email: string;
  cargo?: string;
  departamento?: string;
  salario: number;
  fechaIngreso: string;
}
