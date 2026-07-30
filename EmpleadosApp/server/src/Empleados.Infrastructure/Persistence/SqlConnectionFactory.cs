using System.Data;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;

namespace Empleados.Infrastructure.Persistence;

/// <summary>
/// Única responsabilidad: saber cómo abrir una conexión a SQL Server
/// a partir de la cadena de conexión configurada. Ni el Controller ni
/// el Service instancian conexiones directamente (requisito del
/// enunciado: inyección de dependencias para el acceso a datos).
/// </summary>
public interface ISqlConnectionFactory
{
    IDbConnection CrearConexion();
}

public class SqlConnectionFactory : ISqlConnectionFactory
{
    private readonly string _connectionString;

    public SqlConnectionFactory(IConfiguration configuration)
    {
        _connectionString = configuration.GetConnectionString("EmpleadosDb")
            ?? throw new InvalidOperationException("No se encontró la cadena de conexión 'EmpleadosDb'.");
    }

    public IDbConnection CrearConexion() => new SqlConnection(_connectionString);
}
