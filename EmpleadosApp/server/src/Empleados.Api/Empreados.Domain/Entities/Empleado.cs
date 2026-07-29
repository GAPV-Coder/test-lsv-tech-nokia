namespace Empleados.Domain.Entities;

/// <summary>
/// Entidad de dominio pura: solo representa los datos del empleado,
/// sin conocer nada de SQL, HTTP ni JSON (Single Responsibility).
/// </summary>
public class Empleado
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