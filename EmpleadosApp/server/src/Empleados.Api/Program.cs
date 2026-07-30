using Empleados.Application.Interfaces;
using Empleados.Application.Services;
using Empleados.Infrastructure.Persistence;
using Empleados.Infrastructure.Repositories;

var builder = WebApplication.CreateBuilder(args);

// ---------------------------------------------------------------------
// Inyección de dependencias
// El controller depende de IEmpleadoService, el service depende de
// IEmpleadoRepository: nadie instancia una SqlConnection directamente.
// ---------------------------------------------------------------------
builder.Services.AddSingleton<ISqlConnectionFactory, SqlConnectionFactory>();
builder.Services.AddScoped<IEmpleadoRepository, EmpleadoRepository>();
builder.Services.AddScoped<IEmpleadoService, EmpleadoService>();

builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

// CORS abierto para que el frontend Angular consuma la API. Se permite
// cualquier puerto de localhost/127.0.0.1 (no solo 4200) porque en dev
// herramientas como el reenvío de puertos de VS Code exponen "ng serve"
// a través de un puerto distinto que cambia en cada sesión.
builder.Services.AddCors(options =>
{
    options.AddPolicy("FrontendAngular", policy =>
    {
        policy.SetIsOriginAllowed(origin =>
              {
                  var uri = new Uri(origin);
                  return uri.Host is "localhost" or "127.0.0.1";
              })
              .AllowAnyHeader()
              .AllowAnyMethod();
    });
});

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseCors("FrontendAngular");
app.UseAuthorization();
app.MapControllers();

app.Run();
