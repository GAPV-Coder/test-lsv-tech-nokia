using System.ComponentModel.DataAnnotations;

namespace Empleados.Application.DTOs;

/// <summary>
/// Datos que el frontend envía para crear un empleado.
/// Las validaciones básicas de formato viven aquí; las reglas de
/// negocio (duplicados) viven en el SP y se traducen en el Service.
/// </summary>
public class CrearEmpleadoDto
{
    [Required(ErrorMessage = "El documento es obligatorio.")]
    public long Documento { get; set; }

    [Required(ErrorMessage = "Los nombres son obligatorios.")]
    [MaxLength(100)]
    public string Nombres { get; set; } = string.Empty;

    [Required(ErrorMessage = "Los apellidos son obligatorios.")]
    [MaxLength(100)]
    public string Apellidos { get; set; } = string.Empty;

    [Required(ErrorMessage = "El email es obligatorio.")]
    [EmailAddress(ErrorMessage = "El email no tiene un formato válido.")]
    [MaxLength(150)]
    public string Email { get; set; } = string.Empty;

    [MaxLength(100)]
    public string? Cargo { get; set; }

    [MaxLength(50)]
    public string? Departamento { get; set; }

    [Required(ErrorMessage = "El salario es obligatorio.")]
    [Range(0.01, double.MaxValue, ErrorMessage = "El salario debe ser mayor a 0.")]
    public decimal Salario { get; set; }

    [Required(ErrorMessage = "La fecha de ingreso es obligatoria.")]
    public DateTime FechaIngreso { get; set; }
}
