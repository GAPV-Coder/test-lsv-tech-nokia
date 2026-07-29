using Empleados.Domain.Entities;

namespace Empleados.Application.Interfaces;

/// <summary>
/// Contrato de acceso a datos. La capa Application depende de esta
/// interfaz, nunca de una implementación concreta de ADO.NET/Dapper.
/// Esto permite inyectar dependencias y hacer mocking en pruebas.
/// </summary>
public interface IEmpleadoRepository
{
    Task<IEnumerable<Empleado>> ObtenerTodosAsync();

    Task<Empleado?> ObtenerPorDocumentoAsync(long documento);

    /// <summary>
    /// Invoca sp_InsertarEmpleado. Retorna el Id generado si tuvo éxito.
    /// Si el SP reporta error de negocio (un duplicado por ejemplo), la implementación
    /// debe lanzar EmpleadoDuplicadoException.
    /// </summary>
    Task<int> InsertarEmpleadoAsync(Empleado empleado);
}
