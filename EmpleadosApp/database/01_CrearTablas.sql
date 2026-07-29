-- 01_CrearTablas.sql
-- Creación de la base de datos y tablas: Empleados, EmpleadosHistorico

IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'EmpleadosDB')
BEGIN
    CREATE DATABASE EmpleadosDB;
END


-- Tabla: Empleados
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.Empleados') AND type = 'U')
    DROP TABLE dbo.Empleados;

CREATE TABLE dbo.Empleados (
    IdEmpleado    INT IDENTITY(1,1)   NOT NULL,
    Documento     BIGINT              NOT NULL,
    Nombres       VARCHAR(100)        NOT NULL,
    Apellidos     VARCHAR(100)        NOT NULL,
    Email         VARCHAR(150)        NOT NULL,
    Cargo         VARCHAR(100)        NULL,
    Departamento  VARCHAR(50)         NULL,
    Salario       DECIMAL(12,2)       NOT NULL,
    FechaIngreso  DATE                NOT NULL,

    CONSTRAINT PK_Empleados PRIMARY KEY CLUSTERED (IdEmpleado),
    CONSTRAINT UQ_Empleados_Documento UNIQUE (Documento),
    CONSTRAINT UQ_Empleados_Email UNIQUE (Email),
    CONSTRAINT CK_Empleados_Salario CHECK (Salario > 0)
);

-- Tabla: EmpleadosHistorico
-- Registra cada operación relevante realizada sobre un empleado
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.EmpleadosHistorico') AND type = 'U')
    DROP TABLE dbo.EmpleadosHistorico;
 
CREATE TABLE dbo.EmpleadosHistorico (
    IdHistorico    INT IDENTITY(1,1)  NOT NULL,
    Documento      BIGINT             NOT NULL,
    Accion         VARCHAR(20)        NOT NULL,
    FechaRegistro  DATETIME           NOT NULL CONSTRAINT DF_EmpleadosHistorico_Fecha DEFAULT (GETDATE()),
    UsuarioCarga   VARCHAR(50)        NULL,
    Observacion    VARCHAR(200)       NULL,
 
    CONSTRAINT PK_EmpleadosHistorico PRIMARY KEY CLUSTERED (IdHistorico)
);
 
-- Índice de apoyo para búsquedas frecuentes por Documento en el histórico
CREATE NONCLUSTERED INDEX IX_EmpleadosHistorico_Documento
    ON dbo.EmpleadosHistorico (Documento);