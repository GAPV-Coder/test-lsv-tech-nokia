# Documentación Test Full Stack (SQL Server + C#/.NET + Angular)


## 0. Estructura general de carpetas

```
EmpleadosFullStack/
├── database/                          # Parte 1 — SQL Server
│   ├── 01_CrearTablas.sql             # Crea Empleados y EmpleadosHistorico
│   ├── 02_InsertarDatosEmpleados.sql  # Carga masiva de los 110 registros (transacción)
│   └── 03_sp_InsertarEmpleado.sql     # SP + 2 ejecuciones de prueba (éxito / duplicado)
│
├── backend/                           # Parte 2 — API REST en C#/.NET 8
│   ├── Empleados.sln
│   └── src/
│       ├── Empleados.Domain/          # Entidades puras, sin dependencias
│       ├── Empleados.Application/     # DTOs, interfaces, lógica de negocio (Services)
│       ├── Empleados.Infrastructure/  # Acceso a datos real (Dapper + SQL Server)
│       └── Empleados.Api/             # Controllers, Program.cs, configuración HTTP
│
├── frontend/                          # Parte 3 — Angular (moderno, standalone)
│   └── src/app/
│       ├── core/
│       │   ├── models/empleado.model.ts
│       │   └── services/empleado.service.ts   # único punto de consumo HTTP
│       └── empleados/
│           ├── empleados-list/        # "dumb component": solo muestra datos
│           ├── empleado-form/         # "dumb component": solo captura/valida
│           └── empleados-page.*       # "smart component": orquesta ambos
│
└── docs/
    └── README.md            # este archivo
```

**Por qué esta organización (Single Responsibility Principle):**

| Capa / Carpeta            | Responsabilidad única                                              |
|----------------------------|----------------------------------------------------------------------|
| `Empleados.Domain`         | Representar el concepto "Empleado". No sabe qué es HTTP ni SQL.     |
| `Empleados.Application`    | Reglas de negocio y contratos (interfaces). No sabe cómo se guarda. |
| `Empleados.Infrastructure` | Cómo se guarda/consulta en SQL Server concretamente (Dapper).       |
| `Empleados.Api`            | Traducir HTTP <-> llamadas al Service. No sabe de SQL.               |
| `empleado.service.ts`      | Hablar HTTP con el backend. Ningún componente lo hace directamente. |
| `empleados-list` / `-form` | Presentación y captura. No conocen el Service directamente.         |
| `empleados-page`           | Único que conoce el Service y coordina lista + formulario.          |

Este orden de dependencias es clave: `Api → Application → Domain` y
`Infrastructure → Application → Domain`. **Domain no depende de nadie.**
Esto es lo que en Clean Architecture se llama "regla de dependencia":
las capas externas dependen de las internas, nunca al revés.

---

## 1. Parte 1 — Base de datos (SQL Server)

### 1.1 Ejecutar los scripts en orden

Con SQL Server Management Studio (SSMS) o `sqlcmd`, ejecuta en este orden:

```sql
1) database/01_CrearTablas.sql             -- crea la BD EmpleadosDB y las tablas
2) database/02_InsertarDatosEmpleados.sql  -- carga los 110 empleados reales
3) database/03_sp_InsertarEmpleado.sql     -- crea el SP y corre 2 pruebas
```

### 1.2 Qué hace cada script

- **`01_CrearTablas.sql`**: crea `EmpleadosDB` (si no existe) y las tablas
  `Empleados` y `EmpleadosHistorico` con las restricciones pedidas
  (PK, UNIQUE en Documento y Email, CHECK de salario > 0, DEFAULT de fecha).

- **`02_InsertarDatosEmpleados.sql`**: los 110 INSERT se generaron con un
  script Python (`openpyxl`) que leyó `datos-db.xlsx` fila por fila. Todo
  el bloque corre dentro de **una sola transacción** con `TRY...CATCH`:
  si cualquier fila falla, se hace `ROLLBACK` y no queda **ningún**
  registro insertado ni en `Empleados` ni en `EmpleadosHistorico`
  (requisito "todo o nada"). Al final imprime cuántos registros quedaron
  en cada tabla.

- **`03_sp_InsertarEmpleado.sql`**: el procedimiento `sp_InsertarEmpleado`
  primero valida que el `Documento`/`Email` no existan (si existen, usa
  `RAISERROR` y retorna sin tocar las tablas). Si pasa la validación,
  abre una transacción, inserta en `Empleados` **y** en
  `EmpleadosHistorico`, y hace `COMMIT`. Si algo falla dentro del
  `TRY...CATCH`, hace `ROLLBACK` — nunca queda un INSERT "a medias".
  Al final el script deja 2 ejecuciones de prueba: una exitosa (documento
  nuevo) y una que falla a propósito (documento `1000100`, que ya existe
  tras el script 02).

---

## 2. Parte 2 — Backend (.NET 8 Web API)

### 2.1 Requisitos

- .NET 8 SDK instalado.
- SQL Server accesible (local o remoto) con la base `EmpleadosDB` ya creada.

### 2.2 Configurar la cadena de conexión

Edita `backend/src/Empleados.Api/appsettings.json` y ajusta:

```json
"ConnectionStrings": {
  "EmpleadosDb": "Server=TU_SERVIDOR;Database=EmpleadosDB;Trusted_Connection=True;TrustServerCertificate=True;"
}
```

### 2.3 Restaurar, compilar y ejecutar

```bash
cd backend
dotnet restore
dotnet build
dotnet run --project src/Empleados.Api
```

La API queda disponible (por defecto) en `http://localhost:5000` y con
Swagger en `http://localhost:5000/swagger` para probar los endpoints
sin necesidad del frontend.

### 2.4 Endpoints implementados

| Método | Ruta                        | Descripción                                  |
|--------|------------------------------|-----------------------------------------------|
| GET    | `/api/empleados`             | Lista todos los empleados.                    |
| GET    | `/api/empleados/{documento}` | Obtiene un empleado; `404` si no existe.      |
| POST   | `/api/empleados`             | Crea un empleado invocando `sp_InsertarEmpleado`. `409` si el documento/email ya existe. |

### 2.5 Cómo se cumplen los requisitos técnicos

- **`async/await`**: todos los métodos del Controller, Service y
  Repository son asíncronos de punta a punta (`Task<...>` + `await`).
- **Inyección de dependencias**: `Program.cs` registra
  `ISqlConnectionFactory`, `IEmpleadoRepository` e `IEmpleadoService`.
  El Controller solo recibe `IEmpleadoService` por constructor — nunca
  instancia una `SqlConnection` directamente.
- **Manejo de errores controlado**: el Controller tiene un `try/catch`
  específico para `EmpleadoDuplicadoException` (→ `409 Conflict`) y un
  `catch` genérico para cualquier otra falla (→ `500`, con log, sin
  filtrar el detalle interno ni dejar la excepción "sin controlar").

---

## 3. Parte 3 — Frontend (Angular)

### 3.1 Crear el proyecto Angular real

Para tener un proyecto Angular ejecutable con su tooling completo
(`angular.json`, `package.json`, etc.):

```bash
npm install -g @angular/cli
ng new empleados-frontend --standalone --routing=false --style=css
cd empleados-frontend
```

### 3.2 Ejecutar

```bash
ng serve
```

La app queda en `http://localhost:4200` y consume la API en
`http://localhost:5000/api/empleados` (ajustable en `empleado.service.ts`).

### 3.3 Cómo se cumplen los requisitos

- **Listado en tabla**: `empleados-list.component` muestra documento,
  nombre completo, cargo, departamento y salario.
- **Formulario reactivo con validaciones**: `empleado-form.component`
  usa `FormBuilder` con `Validators.required`, `Validators.email` y
  `Validators.min(0.01)` para el salario.
- **Manejo de error del backend**: si la API responde `409` (documento
  duplicado), el componente toma `err.error.mensaje` y lo muestra en
  pantalla; si la creación es exitosa, emite un evento que hace que
  `empleados-page.component` vuelva a pedir el listado (`cargarEmpleados()`).
- **Consumo HTTP en un servicio**: ningún componente inyecta
  `HttpClient` directamente; todos usan `EmpleadoService`.

---

## 4. Buenas prácticas aplicadas (resumen)

- **SRP en cada capa/clase**: cada archivo tiene un motivo de cambio.
  Si cambia una regla de negocio, se toca `EmpleadoService`. Si cambia
  el motor de base de datos, se toca `EmpleadoRepository`. Si cambia el
  contrato HTTP, se toca el Controller o los DTOs — nunca los tres a la vez.
- **Inversión de dependencias**: `Application` define interfaces
  (`IEmpleadoRepository`), `Infrastructure` las implementa. Esto permite
  cambiar de Dapper a Entity Framework sin tocar el Service ni el Controller.
- **DTOs separados de entidades**: el frontend nunca ve la entidad de
  dominio directamente, solo el contrato (`EmpleadoDto`), evitando
  acoplar la API a cambios internos del modelo.
- **"Todo o nada" real**: tanto el script de carga masiva como el SP
  usan `TRY...CATCH` + `ROLLBACK` explícito, no solo buenas intenciones.
- **Componentes Angular "smart/dumb"**: separa quién *sabe* pedir datos
  (`empleados-page`) de quién solo *muestra* o *captura* datos
  (`empleados-list`, `empleado-form`), facilitando pruebas unitarias.

---

## 5. Siguiente paso: Parte 4 (AngularJS — corrección de bugs)

Este documento cubre el **proyecto Full Stack** (Partes 1–3). La
corrección de los 3 bugs reportados en la app AngularJS 1.8
(`app.js`, `empleado.service.js`, `empleados.controller.js`,
`index.html`) es un proyecto aparte.