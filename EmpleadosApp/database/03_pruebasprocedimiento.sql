-- 03c_PruebasProcedimiento.sql
-- PASO 3: ejecuta este archivo completo con "Execute SQL Script"
-- (Alt+X). Base de datos activa debe ser EmpleadosDB.

-- 1) Caso exitoso: documento nuevo, no existe en la tabla.
EXEC dbo.sp_InsertarEmpleado
    @Documento    = 9999999,
    @Nombres      = 'Prueba',
    @Apellidos    = 'Exitosa Uno',
    @Email        = 'prueba.exitosa1@empresa.com',
    @Cargo        = 'QA Tester',
    @Departamento = 'Calidad',
    @Salario      = 3000000,
    @FechaIngreso = '2024-01-15';

-- 2) Caso fallido: documento duplicado (usa uno que ya insertó el script 02).
EXEC dbo.sp_InsertarEmpleado
    @Documento    = 1000100,
    @Nombres      = 'Fabian',
    @Apellidos    = 'Duplicado',
    @Email        = 'otro.email@empresa.com',
    @Cargo        = 'Lider Tecnico',
    @Departamento = 'Calidad',
    @Salario      = 8400000,
    @FechaIngreso = '2024-01-15';