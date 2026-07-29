namespace Empleados.Application.DTOs;

/// <summary>
/// Representa lo que la API expone al frontend. Separado de la entidad
/// de dominio para no acoplar el contrato HTTP con el modelo interno.
/// </summary>
public class EmpleadoDto
{
    public int IdEmpleado { get; set; }
    public long Documento { get; set; }
    public string Nombres { get; set; } = string.Empty;
    public string Apellidos { get; set; } = string.Empty;
    public string Email { get; set; } = string.Empty;
    public string? Cargo { get; set; }
    public string? Departamento { get; set; }
    public decimal Salario { get; set; }
    public DateTime FechaIngreso { get; set; }
}
