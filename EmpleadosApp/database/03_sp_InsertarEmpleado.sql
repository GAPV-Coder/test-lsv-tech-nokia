-- 03_sp_InsertarEmpleado.sql
-- Procedimiento almacenado para insertar un empleado de forma segura,
-- validando duplicados y registrando el histórico en una transacción.

CREATE PROCEDURE dbo.sp_InsertarEmpleado
(
    @Documento     BIGINT,
    @Nombres       VARCHAR(100),
    @Apellidos     VARCHAR(100),
    @Email         VARCHAR(150),
    @Cargo         VARCHAR(100)  = NULL,
    @Departamento  VARCHAR(50)   = NULL,
    @Salario       DECIMAL(12,2),
    @FechaIngreso  DATE,
    @UsuarioCarga  VARCHAR(50)   = 'api'
)
AS
BEGIN
    SET NOCOUNT ON;
 
    -- Validación de negocio: el documento no debe existir previamente.
    -- Se valida ANTES de abrir la transacción para poder salir rápido
    -- con un mensaje claro sin necesidad de hacer rollback.
    IF EXISTS (SELECT 1 FROM dbo.Empleados WHERE Documento = @Documento)
    BEGIN
        RAISERROR('Ya existe un empleado registrado con el documento %I64d.', 16, 1, @Documento);
        RETURN -1;
    END
 
    IF EXISTS (SELECT 1 FROM dbo.Empleados WHERE Email = @Email)
    BEGIN
        RAISERROR('Ya existe un empleado registrado con el email %s.', 16, 1, @Email);
        RETURN -1;
    END
 
    BEGIN TRANSACTION;
 
    BEGIN TRY
 
        INSERT INTO dbo.Empleados
            (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
        VALUES
            (@Documento, @Nombres, @Apellidos, @Email, @Cargo, @Departamento, @Salario, @FechaIngreso);
 
        INSERT INTO dbo.EmpleadosHistorico
            (Documento, Accion, UsuarioCarga, Observacion)
        VALUES
            (@Documento, 'INSERT', @UsuarioCarga, 'Alta de empleado vía sp_InsertarEmpleado');
 
        COMMIT TRANSACTION;
 
        SELECT
            0                                    AS CodigoResultado,
            'Empleado insertado correctamente.'   AS Mensaje,
            SCOPE_IDENTITY()                      AS IdEmpleado;
 
    END TRY
    BEGIN CATCH
 
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
 
        -- No queda registro en Empleados ni en EmpleadosHistorico:
        -- ambos INSERT están dentro de la misma transacción.
        SELECT
            -1                    AS CodigoResultado,
            ERROR_MESSAGE()       AS Mensaje,
            NULL                  AS IdEmpleado;
 
    END CATCH
 
END