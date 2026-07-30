using System.Data;
using Dapper;
using Empleados.Application.Interfaces;
using Empleados.Domain.Entities;
using Empleados.Domain.Exceptions;
using Empleados.Infrastructure.Persistence;

namespace Empleados.Infrastructure.Repositories;

/// <summary>
/// Única responsabilidad: traducir las operaciones del contrato
/// IEmpleadoRepository a instrucciones SQL/Dapper concretas contra
/// SQL Server. Nada de reglas de negocio ni de HTTP aquí.
/// </summary>
public class EmpleadoRepository : IEmpleadoRepository
{
    private readonly ISqlConnectionFactory _connectionFactory;

    public EmpleadoRepository(ISqlConnectionFactory connectionFactory)
    {
        _connectionFactory = connectionFactory;
    }

    public async Task<IEnumerable<Empleado>> ObtenerTodosAsync()
    {
        const string sql = @"
            SELECT IdEmpleado, Documento, Nombres, Apellidos, Email,
                   Cargo, Departamento, Salario, FechaIngreso
            FROM dbo.Empleados
            ORDER BY Apellidos, Nombres;";

        using var conexion = _connectionFactory.CrearConexion();
        return await conexion.QueryAsync<Empleado>(sql);
    }

    public async Task<Empleado?> ObtenerPorDocumentoAsync(long documento)
    {
        const string sql = @"
            SELECT IdEmpleado, Documento, Nombres, Apellidos, Email,
                   Cargo, Departamento, Salario, FechaIngreso
            FROM dbo.Empleados
            WHERE Documento = @Documento;";

        using var conexion = _connectionFactory.CrearConexion();
        return await conexion.QuerySingleOrDefaultAsync<Empleado>(sql, new { Documento = documento });
    }

    public async Task<int> InsertarEmpleadoAsync(Empleado empleado)
    {
        using var conexion = _connectionFactory.CrearConexion();

        var parametros = new
        {
            empleado.Documento,
            empleado.Nombres,
            empleado.Apellidos,
            empleado.Email,
            empleado.Cargo,
            empleado.Departamento,
            empleado.Salario,
            empleado.FechaIngreso
        };

        // sp_InsertarEmpleado retorna un result set con
        // (CodigoResultado, Mensaje, IdEmpleado) en lugar de lanzar un
        // error SQL crudo, así que aquí se interpreta ese contrato.
        var resultado = await conexion.QuerySingleAsync<ResultadoInsercion>(
            "dbo.sp_InsertarEmpleado",
            parametros,
            commandType: CommandType.StoredProcedure);

        if (resultado.CodigoResultado != 0)
        {
            throw new EmpleadoDuplicadoException(resultado.Mensaje);
        }

        return resultado.IdEmpleado ?? 0;
    }

    private class ResultadoInsercion
    {
        public int CodigoResultado { get; set; }
        public string Mensaje { get; set; } = string.Empty;
        public int? IdEmpleado { get; set; }
    }
}
