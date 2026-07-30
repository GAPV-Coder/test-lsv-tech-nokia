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

// CORS abierto para que el frontend Angular (localhost:4200) consuma la API.
builder.Services.AddCors(options =>
{
    options.AddPolicy("FrontendAngular", policy =>
    {
        policy.WithOrigins("http://localhost:4200")
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
