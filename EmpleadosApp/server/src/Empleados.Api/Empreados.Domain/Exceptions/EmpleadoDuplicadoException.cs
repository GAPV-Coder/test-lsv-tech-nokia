namespace Empleados.Domain.Exceptions;

/// <summary>
/// Se lanza cuando el SP sp_InsertarEmpleado rechaza la inserción
/// porque el documento (o email) ya existe. Permite que la capa API
/// traduzca esto a un HTTP 409 Conflict sin conocer detalles de SQL.
/// </summary>
public class EmpleadoDuplicadoException : Exception
{
    public EmpleadoDuplicadoException(string message) : base(message)
    {
    }
}