using Empleados.Application.DTOs;
using Empleados.Application.Interfaces;
using Empleados.Domain.Exceptions;
using Microsoft.AspNetCore.Mvc;

namespace Empleados.Api.Controllers;

/// <summary>
/// Única responsabilidad: traducir peticiones HTTP a llamadas del
/// IEmpleadoService y traducir sus resultados/errores a códigos HTTP.
/// No contiene SQL, no contiene reglas de negocio.
/// </summary>
[ApiController]
[Route("api/empleados")]
public class EmpleadosController : ControllerBase
{
    private readonly IEmpleadoService _empleadoService;
    private readonly ILogger<EmpleadosController> _logger;

    public EmpleadosController(IEmpleadoService empleadoService, ILogger<EmpleadosController> logger)
    {
        _empleadoService = empleadoService;
        _logger = logger;
    }

    // GET /api/empleados
    [HttpGet]
    public async Task<ActionResult<IEnumerable<EmpleadoDto>>> ObtenerTodos()
    {
        var empleados = await _empleadoService.ListarEmpleadosAsync();
        return Ok(empleados);
    }

    // GET /api/empleados/{documento}
    [HttpGet("{documento:long}")]
    public async Task<ActionResult<EmpleadoDto>> ObtenerPorDocumento(long documento)
    {
        var empleado = await _empleadoService.ObtenerPorDocumentoAsync(documento);

        if (empleado is null)
        {
            return NotFound(new { mensaje = $"No existe un empleado con documento {documento}." });
        }

        return Ok(empleado);
    }

    // POST /api/empleados
    [HttpPost]
    public async Task<ActionResult<EmpleadoDto>> Crear([FromBody] CrearEmpleadoDto dto)
    {
        // Las validaciones de formato (Required, EmailAddress, Range)
        // ya fueron aplicadas automáticamente por [ApiController] antes
        // de llegar aquí; si fallan, ASP.NET responde 400 solo.
        try
        {
            var creado = await _empleadoService.CrearEmpleadoAsync(dto);
            return CreatedAtAction(nameof(ObtenerPorDocumento), new { documento = creado.Documento }, creado);
        }
        catch (EmpleadoDuplicadoException ex)
        {
            // Regla de negocio violada (documento/email duplicado) - 409 Conflict.
            return Conflict(new { mensaje = ex.Message });
        }
        catch (Exception ex)
        {
            // Cualquier otro error inesperado - 500, pero sin filtrar
            // detalles internos ni dejar la excepción sin controlar.
            _logger.LogError(ex, "Error inesperado creando empleado con documento {Documento}", dto.Documento);
            return StatusCode(500, new { mensaje = "Ocurrió un error inesperado al crear el empleado." });
        }
    }
}
