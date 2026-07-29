using Empleados.Application.DTOs;
using Empleados.Application.Interfaces;
using Empleados.Domain.Entities;

namespace Empleados.Application.Services;

/// <summary>
/// Orquesta el caso de uso "gestión de empleados". No sabe nada de SQL
/// (eso es responsabilidad del Repository) ni de HTTP (responsabilidad
/// del Controller). Su única responsabilidad es mapear DTOs <-> entidad
/// y aplicar el flujo de negocio.
/// </summary>
public class EmpleadoService : IEmpleadoService
{
    private readonly IEmpleadoRepository _empleadoRepository;

    public EmpleadoService(IEmpleadoRepository empleadoRepository)
    {
        _empleadoRepository = empleadoRepository;
    }

    public async Task<IEnumerable<EmpleadoDto>> ListarEmpleadosAsync()
    {
        var empleados = await _empleadoRepository.ObtenerTodosAsync();
        return empleados.Select(MapearADto);
    }

    public async Task<EmpleadoDto?> ObtenerPorDocumentoAsync(long documento)
    {
        var empleado = await _empleadoRepository.ObtenerPorDocumentoAsync(documento);
        return empleado is null ? null : MapearADto(empleado);
    }

    public async Task<EmpleadoDto> CrearEmpleadoAsync(CrearEmpleadoDto dto)
    {
        var empleado = new Empleado
        {
            Documento = dto.Documento,
            Nombres = dto.Nombres,
            Apellidos = dto.Apellidos,
            Email = dto.Email,
            Cargo = dto.Cargo,
            Departamento = dto.Departamento,
            Salario = dto.Salario,
            FechaIngreso = dto.FechaIngreso
        };

        // Si el SP determina que el documento/email ya existe, el
        // repositorio lanza EmpleadoDuplicadoException. El controller
        // la traduce a un HTTP 409, no hay try/catch "silencioso" aquí.
        var idGenerado = await _empleadoRepository.InsertarEmpleadoAsync(empleado);
        empleado.IdEmpleado = idGenerado;

        return MapearADto(empleado);
    }

    private static EmpleadoDto MapearADto(Empleado empleado) => new()
    {
        IdEmpleado = empleado.IdEmpleado,
        Documento = empleado.Documento,
        Nombres = empleado.Nombres,
        Apellidos = empleado.Apellidos,
        Email = empleado.Email,
        Cargo = empleado.Cargo,
        Departamento = empleado.Departamento,
        Salario = empleado.Salario,
        FechaIngreso = empleado.FechaIngreso
    };
}
