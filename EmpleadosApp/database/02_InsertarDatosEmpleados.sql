-- 02_InsertarDatosEmpleados.sql
-- Carga masiva de 110 empleados desde datos-db.xlsx (hoja Datos_Jr)
--
-- COMO SE GENERARON ESTOS INSERT:
-- Se leyo el archivo datos-db.xlsx con un script,
-- se recorrio cada fila (110 registros, sin encabezado) y se generaron
-- sentencias INSERT parametrizadas por fila, convirtiendo la fecha
-- serial de Excel (numero de dias desde 1899-12-30) a formato DATE.
-- El proceso corre dentro de UNA transaccion: si un solo INSERT
-- falla (ej. Documento o Email duplicado), se hace ROLLBACK completo
-- y no queda NINGUN registro insertado en Empleados ni en
-- EmpleadosHistorico (requisito 'todo o nada').

SET NOCOUNT ON;
BEGIN TRANSACTION InsercionMasivaEmpleados;

BEGIN TRY

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000100, 'Fabian', 'Lopez Gomez', 'fabian.lopez0@empresa.com', 'Lider Tecnico', 'Calidad', 8400000, '2022-09-30');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000100, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000101, 'Tatiana', 'Lopez Mendoza', 'tatiana.lopez1@empresa.com', 'Desarrollador Junior', 'Tecnologia', 2950000, '2024-09-24');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000101, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000102, 'Luis', 'Sanchez Ramirez', 'luis.sanchez2@empresa.com', 'Analista Funcional', 'Calidad', 7250000, '2020-04-18');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000102, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000103, 'Hernan', 'Mendoza Rojas', 'hernan.mendoza3@empresa.com', 'Desarrollador Junior', 'Calidad', 3550000, '2023-02-13');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000103, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000104, 'Hernan', 'Rojas Vargas', 'hernan.rojas4@empresa.com', 'Soporte TI', 'Tecnologia', 4200000, '2022-05-31');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000104, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000105, 'Luis', 'Jimenez Lopez', 'luis.jimenez5@empresa.com', 'Desarrollador Junior', 'Datos', 4350000, '2022-12-19');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000105, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000106, 'Daniela', 'Lopez Jimenez', 'daniela.lopez6@empresa.com', 'Disenador UX', 'Infraestructura', 2900000, '2023-04-15');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000106, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000107, 'Sergio', 'Sanchez Martinez', 'sergio.sanchez7@empresa.com', 'Desarrollador Senior', 'Calidad', 2650000, '2023-03-31');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000107, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000108, 'Monica', 'Lopez Jimenez', 'monica.lopez8@empresa.com', 'Analista QA', 'Infraestructura', 4450000, '2024-02-03');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000108, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000109, 'Valentina', 'Sanchez Torres', 'valentina.sanchez9@empresa.com', 'Analista Funcional', 'Calidad', 8250000, '2021-12-01');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000109, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000110, 'Paula', 'Diaz Jimenez', 'paula.diaz10@empresa.com', 'Soporte TI', 'Tecnologia', 4500000, '2022-06-18');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000110, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000111, 'Camila', 'Rodriguez Vargas', 'camila.rodriguez11@empresa.com', 'Lider Tecnico', 'Producto', 5700000, '2020-09-28');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000111, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000112, 'Cristian', 'Vargas Sanchez', 'cristian.vargas12@empresa.com', 'Ingeniero DevOps', 'Calidad', 8550000, '2024-06-08');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000112, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000113, 'Felipe', 'Hernandez Ramirez', 'felipe.hernandez13@empresa.com', 'Analista de Datos', 'Producto', 8600000, '2026-01-16');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000113, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000114, 'Natalia', 'Silva Jimenez', 'natalia.silva14@empresa.com', 'Analista Funcional', 'Datos', 4250000, '2021-07-20');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000114, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000115, 'Luis', 'Rodriguez Lopez', 'luis.rodriguez15@empresa.com', 'Disenador UX', 'Tecnologia', 3300000, '2024-09-25');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000115, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000116, 'Oscar', 'Jimenez Rincon', 'oscar.jimenez16@empresa.com', 'Analista Funcional', 'Tecnologia', 5900000, '2022-10-26');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000116, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000117, 'Angela', 'Lopez Mendoza', 'angela.lopez17@empresa.com', 'Desarrollador Senior', 'Infraestructura', 9700000, '2023-10-25');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000117, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000118, 'Natalia', 'Perez Diaz', 'natalia.perez18@empresa.com', 'Analista QA', 'Producto', 2700000, '2025-08-12');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000118, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000119, 'Diana', 'Lopez Castro', 'diana.lopez19@empresa.com', 'Analista QA', 'Infraestructura', 9900000, '2022-03-25');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000119, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000120, 'Julian', 'Perez Mendoza', 'julian.perez20@empresa.com', 'Disenador UX', 'Infraestructura', 9900000, '2020-01-03');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000120, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000121, 'Juliana', 'Gomez Lopez', 'juliana.gomez21@empresa.com', 'Desarrollador Junior', 'Calidad', 4300000, '2022-09-07');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000121, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000122, 'Cristian', 'Silva Martinez', 'cristian.silva22@empresa.com', 'Analista Funcional', 'Calidad', 2850000, '2020-10-10');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000122, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000123, 'Jorge', 'Suarez Mendoza', 'jorge.suarez23@empresa.com', 'Disenador UX', 'Datos', 3400000, '2025-12-01');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000123, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000124, 'Andres', 'Mendoza Sanchez', 'andres.mendoza24@empresa.com', 'Soporte TI', 'Datos', 8400000, '2024-06-22');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000124, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000125, 'Cristian', 'Ortiz Diaz', 'cristian.ortiz25@empresa.com', 'Desarrollador Senior', 'Infraestructura', 2650000, '2022-07-09');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000125, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000126, 'Carlos', 'Silva Mendoza', 'carlos.silva26@empresa.com', 'Desarrollador Junior', 'Tecnologia', 3650000, '2022-06-21');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000126, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000127, 'Hernan', 'Rodriguez Ramirez', 'hernan.rodriguez27@empresa.com', 'Desarrollador Senior', 'Producto', 2500000, '2023-09-15');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000127, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000128, 'Camila', 'Torres Suarez', 'camila.torres28@empresa.com', 'Disenador UX', 'Producto', 3600000, '2021-06-25');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000128, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000129, 'Juliana', 'Ramirez Suarez', 'juliana.ramirez29@empresa.com', 'Desarrollador Senior', 'Tecnologia', 9800000, '2022-02-18');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000129, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000130, 'Angela', 'Rojas Moreno', 'angela.rojas30@empresa.com', 'Desarrollador Junior', 'Tecnologia', 5800000, '2025-03-27');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000130, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000131, 'Andrea', 'Jimenez Vargas', 'andrea.jimenez31@empresa.com', 'Lider Tecnico', 'Calidad', 9550000, '2022-10-15');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000131, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000132, 'Daniela', 'Diaz Hernandez', 'daniela.diaz32@empresa.com', 'Ingeniero DevOps', 'Calidad', 5600000, '2023-02-14');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000132, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000133, 'Monica', 'Martinez Diaz', 'monica.martinez33@empresa.com', 'Desarrollador Junior', 'Producto', 9900000, '2021-02-05');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000133, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000134, 'Esteban', 'Gomez Martinez', 'esteban.gomez34@empresa.com', 'DBA', 'Datos', 9650000, '2021-11-12');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000134, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000135, 'Juliana', 'Sanchez Jimenez', 'juliana.sanchez35@empresa.com', 'Desarrollador Junior', 'Datos', 2600000, '2024-04-01');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000135, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000136, 'Felipe', 'Diaz Castro', 'felipe.diaz36@empresa.com', 'Analista QA', 'Calidad', 5900000, '2025-06-16');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000136, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000137, 'Laura', 'Sanchez Rodriguez', 'laura.sanchez37@empresa.com', 'Soporte TI', 'Tecnologia', 7200000, '2020-09-06');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000137, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000138, 'Andrea', 'Silva Suarez', 'andrea.silva38@empresa.com', 'Desarrollador Junior', 'Producto', 7200000, '2021-10-06');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000138, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000139, 'Luis', 'Perez Martinez', 'luis.perez39@empresa.com', 'DBA', 'Tecnologia', 6850000, '2022-08-21');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000139, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000140, 'Cristian', 'Silva Ramirez', 'cristian.silva40@empresa.com', 'Disenador UX', 'Tecnologia', 7250000, '2020-06-11');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000140, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000141, 'Natalia', 'Silva Silva', 'natalia.silva41@empresa.com', 'Lider Tecnico', 'Infraestructura', 7050000, '2022-12-04');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000141, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000142, 'Camila', 'Torres Jimenez', 'camila.torres42@empresa.com', 'Soporte TI', 'Tecnologia', 3400000, '2025-02-15');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000142, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000143, 'Carlos', 'Diaz Rincon', 'carlos.diaz43@empresa.com', 'Analista Funcional', 'Calidad', 6850000, '2020-10-27');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000143, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000144, 'Mauricio', 'Torres Hernandez', 'mauricio.torres44@empresa.com', 'Soporte TI', 'Infraestructura', 4150000, '2022-09-27');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000144, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000145, 'Paula', 'Diaz Mendoza', 'paula.diaz45@empresa.com', 'Desarrollador Junior', 'Producto', 8400000, '2025-12-06');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000145, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000146, 'Laura', 'Lopez Hernandez', 'laura.lopez46@empresa.com', 'Analista Funcional', 'Calidad', 4150000, '2021-03-14');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000146, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000147, 'Felipe', 'Castro Rincon', 'felipe.castro47@empresa.com', 'Analista de Datos', 'Producto', 3450000, '2022-04-13');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000147, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000148, 'Juliana', 'Torres Rodriguez', 'juliana.torres48@empresa.com', 'Desarrollador Junior', 'Tecnologia', 2800000, '2023-02-07');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000148, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000149, 'Diego', 'Hernandez Torres', 'diego.hernandez49@empresa.com', 'DBA', 'Producto', 3550000, '2026-03-09');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000149, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000150, 'Carlos', 'Lopez Martinez', 'carlos.lopez50@empresa.com', 'Desarrollador Junior', 'Infraestructura', 8300000, '2026-02-12');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000150, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000151, 'Sergio', 'Mendoza Hernandez', 'sergio.mendoza51@empresa.com', 'Analista de Datos', 'Infraestructura', 5600000, '2020-06-20');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000151, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000152, 'Cristian', 'Rodriguez Moreno', 'cristian.rodriguez52@empresa.com', 'Soporte TI', 'Producto', 3350000, '2021-02-25');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000152, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000153, 'Cristian', 'Rojas Rincon', 'cristian.rojas53@empresa.com', 'Analista QA', 'Calidad', 8300000, '2022-08-27');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000153, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000154, 'Cristian', 'Rojas Gomez', 'cristian.rojas54@empresa.com', 'Lider Tecnico', 'Infraestructura', 3450000, '2024-08-13');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000154, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000155, 'Paula', 'Lopez Jimenez', 'paula.lopez55@empresa.com', 'Lider Tecnico', 'Calidad', 9500000, '2025-04-11');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000155, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000156, 'Esteban', 'Diaz Moreno', 'esteban.diaz56@empresa.com', 'Desarrollador Junior', 'Calidad', 4250000, '2022-07-02');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000156, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000157, 'Oscar', 'Vargas Torres', 'oscar.vargas57@empresa.com', 'Soporte TI', 'Producto', 9550000, '2023-02-17');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000157, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000158, 'Oscar', 'Mendoza Vargas', 'oscar.mendoza58@empresa.com', 'Analista QA', 'Producto', 2550000, '2022-12-05');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000158, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000159, 'Felipe', 'Rodriguez Lopez', 'felipe.rodriguez59@empresa.com', 'Soporte TI', 'Datos', 7100000, '2023-11-16');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000159, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000160, 'Carolina', 'Ortiz Lopez', 'carolina.ortiz60@empresa.com', 'Analista de Datos', 'Tecnologia', 5950000, '2022-02-17');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000160, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000161, 'Hernan', 'Rojas Gomez', 'hernan.rojas61@empresa.com', 'Soporte TI', 'Datos', 7200000, '2022-03-18');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000161, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000162, 'Luis', 'Vargas Rincon', 'luis.vargas62@empresa.com', 'Analista Funcional', 'Infraestructura', 4150000, '2023-05-15');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000162, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000163, 'Angela', 'Rojas Vargas', 'angela.rojas63@empresa.com', 'Analista QA', 'Calidad', 5700000, '2026-03-20');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000163, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000164, 'Natalia', 'Jimenez Perez', 'natalia.jimenez64@empresa.com', 'DBA', 'Producto', 7250000, '2023-05-17');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000164, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000165, 'Esteban', 'Gomez Castro', 'esteban.gomez65@empresa.com', 'Disenador UX', 'Producto', 4250000, '2024-10-26');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000165, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000166, 'Fabian', 'Vargas Diaz', 'fabian.vargas66@empresa.com', 'Analista Funcional', 'Datos', 5850000, '2022-05-25');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000166, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000167, 'Sandra', 'Perez Martinez', 'sandra.perez67@empresa.com', 'Desarrollador Senior', 'Calidad', 4500000, '2023-10-04');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000167, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000168, 'Angela', 'Castro Ramirez', 'angela.castro68@empresa.com', 'Desarrollador Junior', 'Tecnologia', 9650000, '2021-08-26');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000168, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000169, 'Camila', 'Suarez Rincon', 'camila.suarez69@empresa.com', 'DBA', 'Producto', 9550000, '2025-02-08');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000169, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000170, 'Andres', 'Jimenez Suarez', 'andres.jimenez70@empresa.com', 'Desarrollador Junior', 'Tecnologia', 5650000, '2021-08-27');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000170, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000171, 'Julian', 'Rojas Ramirez', 'julian.rojas71@empresa.com', 'Desarrollador Junior', 'Producto', 3600000, '2025-03-17');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000171, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000172, 'Camila', 'Lopez Diaz', 'camila.lopez72@empresa.com', 'Analista Funcional', 'Producto', 3550000, '2025-12-15');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000172, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000173, 'Diego', 'Diaz Rincon', 'diego.diaz73@empresa.com', 'Analista Funcional', 'Datos', 9900000, '2024-10-13');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000173, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000174, 'Cristian', 'Perez Suarez', 'cristian.perez74@empresa.com', 'Analista de Datos', 'Producto', 5700000, '2022-10-09');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000174, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000175, 'Juliana', 'Ramirez Torres', 'juliana.ramirez75@empresa.com', 'Lider Tecnico', 'Infraestructura', 5550000, '2023-03-16');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000175, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000176, 'Diego', 'Vargas Mendoza', 'diego.vargas76@empresa.com', 'Lider Tecnico', 'Datos', 2600000, '2021-09-09');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000176, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000177, 'Hernan', 'Hernandez Sanchez', 'hernan.hernandez77@empresa.com', 'Soporte TI', 'Producto', 2800000, '2024-07-27');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000177, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000178, 'Ricardo', 'Rojas Rodriguez', 'ricardo.rojas78@empresa.com', 'Disenador UX', 'Tecnologia', 3500000, '2024-05-14');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000178, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000179, 'Monica', 'Silva Jimenez', 'monica.silva79@empresa.com', 'Analista de Datos', 'Datos', 5500000, '2023-12-11');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000179, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000180, 'Monica', 'Rojas Mendoza', 'monica.rojas80@empresa.com', 'Ingeniero DevOps', 'Calidad', 8600000, '2022-06-22');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000180, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000181, 'Felipe', 'Rojas Suarez', 'felipe.rojas81@empresa.com', 'DBA', 'Calidad', 2800000, '2023-10-08');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000181, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000182, 'Esteban', 'Diaz Hernandez', 'esteban.diaz82@empresa.com', 'DBA', 'Producto', 7200000, '2020-04-20');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000182, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000183, 'Sergio', 'Gomez Martinez', 'sergio.gomez83@empresa.com', 'Ingeniero DevOps', 'Calidad', 8500000, '2021-07-09');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000183, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000184, 'Andrea', 'Torres Jimenez', 'andrea.torres84@empresa.com', 'Soporte TI', 'Infraestructura', 4250000, '2025-02-05');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000184, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000185, 'Julian', 'Jimenez Torres', 'julian.jimenez85@empresa.com', 'Desarrollador Senior', 'Datos', 9800000, '2022-10-30');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000185, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000186, 'Carlos', 'Mendoza Rodriguez', 'carlos.mendoza86@empresa.com', 'Desarrollador Junior', 'Tecnologia', 4250000, '2020-10-08');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000186, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000187, 'Camila', 'Sanchez Gomez', 'camila.sanchez87@empresa.com', 'Analista QA', 'Datos', 6900000, '2022-09-04');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000187, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000188, 'Angela', 'Lopez Silva', 'angela.lopez88@empresa.com', 'Soporte TI', 'Calidad', 3550000, '2022-11-15');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000188, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000189, 'Carolina', 'Rincon Lopez', 'carolina.rincon89@empresa.com', 'Desarrollador Senior', 'Producto', 9600000, '2023-06-28');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000189, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000190, 'Carlos', 'Castro Silva', 'carlos.castro90@empresa.com', 'Lider Tecnico', 'Tecnologia', 8500000, '2024-06-12');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000190, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000191, 'Sergio', 'Ramirez Lopez', 'sergio.ramirez91@empresa.com', 'Disenador UX', 'Tecnologia', 8400000, '2021-05-10');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000191, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000192, 'Valentina', 'Mendoza Rojas', 'valentina.mendoza92@empresa.com', 'Analista Funcional', 'Infraestructura', 8450000, '2020-10-09');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000192, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000193, 'Carlos', 'Rojas Suarez', 'carlos.rojas93@empresa.com', 'Ingeniero DevOps', 'Calidad', 2800000, '2024-01-23');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000193, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000194, 'Natalia', 'Perez Ortiz', 'natalia.perez94@empresa.com', 'Ingeniero DevOps', 'Datos', 8400000, '2026-01-13');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000194, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000195, 'Natalia', 'Silva Torres', 'natalia.silva95@empresa.com', 'Analista de Datos', 'Datos', 4250000, '2020-12-20');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000195, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000196, 'Camila', 'Diaz Silva', 'camila.diaz96@empresa.com', 'Desarrollador Junior', 'Datos', 7100000, '2023-10-09');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000196, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000197, 'Monica', 'Vargas Perez', 'monica.vargas97@empresa.com', 'Analista de Datos', 'Infraestructura', 5650000, '2023-12-24');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000197, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000198, 'Felipe', 'Rincon Torres', 'felipe.rincon98@empresa.com', 'Lider Tecnico', 'Tecnologia', 6800000, '2025-10-17');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000198, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000199, 'Camila', 'Rojas Suarez', 'camila.rojas99@empresa.com', 'Ingeniero DevOps', 'Datos', 6950000, '2025-05-04');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000199, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000200, 'Sandra', 'Gomez Martinez', 'sandra.gomez0@empresa.com', 'Lider Tecnico', 'Infraestructura', 4250000, '2024-07-14');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000200, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000201, 'Angela', 'Silva Moreno', 'angela.silva1@empresa.com', 'Soporte TI', 'Datos', 5900000, '2025-12-14');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000201, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000202, 'Tatiana', 'Mendoza Vargas', 'tatiana.mendoza2@empresa.com', 'Analista de Datos', 'Infraestructura', 4450000, '2023-01-14');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000202, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000203, 'Camila', 'Lopez Sanchez', 'camila.lopez3@empresa.com', 'Analista QA', 'Calidad', 4150000, '2026-01-03');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000203, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000204, 'Andres', 'Suarez Torres', 'andres.suarez4@empresa.com', 'Disenador UX', 'Infraestructura', 8650000, '2025-11-18');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000204, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000205, 'Maria', 'Sanchez Castro', 'maria.sanchez5@empresa.com', 'Analista de Datos', 'Tecnologia', 3450000, '2022-01-04');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000205, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000206, 'Hernan', 'Mendoza Hernandez', 'hernan.mendoza6@empresa.com', 'Analista Funcional', 'Infraestructura', 4100000, '2020-08-11');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000206, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000207, 'Hernan', 'Hernandez Suarez', 'hernan.hernandez7@empresa.com', 'Ingeniero DevOps', 'Datos', 2500000, '2023-03-10');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000207, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000208, 'Ricardo', 'Vargas Perez', 'ricardo.vargas8@empresa.com', 'Desarrollador Senior', 'Tecnologia', 2700000, '2025-05-10');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000208, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    INSERT INTO Empleados (Documento, Nombres, Apellidos, Email, Cargo, Departamento, Salario, FechaIngreso)
    VALUES (1000209, 'Oscar', 'Suarez Martinez', 'oscar.suarez9@empresa.com', 'Analista QA', 'Producto', 6800000, '2021-09-13');

    INSERT INTO EmpleadosHistorico (Documento, Accion, UsuarioCarga, Observacion)
    VALUES (1000209, 'INSERT', 'script_carga_masiva', 'Carga inicial desde datos-db.xlsx');

    COMMIT TRANSACTION InsercionMasivaEmpleados;

    PRINT 'Carga masiva completada exitosamente.';
    PRINT 'Registros en Empleados: ' + CAST((SELECT COUNT(*) FROM Empleados) AS VARCHAR(10));
    PRINT 'Registros en EmpleadosHistorico: ' + CAST((SELECT COUNT(*) FROM EmpleadosHistorico) AS VARCHAR(10));

END TRY
BEGIN CATCH

    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION InsercionMasivaEmpleados;

    PRINT 'ERROR durante la carga masiva. No se inserto ningun registro (ROLLBACK ejecutado).';
    PRINT 'Mensaje de error: ' + ERROR_MESSAGE();

END CATCH
GO