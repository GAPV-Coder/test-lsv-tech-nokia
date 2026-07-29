using Empleados.Application.DTOs;

namespace Empleados.Application.Interfaces;

/// <summary>
/// Contrato de la capa de orquestación de negocio que consume el
/// controller. El controller solo conoce esta interfaz (SRP: el
/// controller se encarga únicamente de HTTP, no de lógica ni de datos).
/// </summary>
public interface IEmpleadoService
{
    Task<IEnumerable<EmpleadoDto>> ListarEmpleadosAsync();

    Task<EmpleadoDto?> ObtenerPorDocumentoAsync(long documento);

    Task<EmpleadoDto> CrearEmpleadoAsync(CrearEmpleadoDto dto);
}
