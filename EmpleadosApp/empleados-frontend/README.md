# Frontend — Instrucciones de integración

Este código está pensado para copiarse **encima** de un proyecto creado
con Angular CLI (ver comando abajo), no para correrse tal cual —
le faltan `angular.json`, `package.json`, `tsconfig.json`, etc., que
genera el propio CLI.

## 1. Crear el proyecto base

```bash
ng new empleados-frontend --standalone --routing=false --style=css --skip-tests
cd empleados-frontend
```

## 2. Reemplazar/agregar archivos

Copia el contenido de esta carpeta (`frontend/`) sobre la carpeta
generada por `ng new`, respetando las rutas:

| Archivo de aquí | Va a parar a |
|---|---|
| `src/styles.css` | `empleados-frontend/src/styles.css` (reemplaza) |
| `src/index.html` | `empleados-frontend/src/index.html` (reemplaza) |
| `src/app/**` | `empleados-frontend/src/app/**` (reemplaza `app.component.ts`, `app.config.ts`, y agrega las carpetas `core/`, `empleados/`, `shared/`) |

Puedes borrar `app.component.html`, `app.component.css` y
`app.component.spec.ts` que trae el scaffold por defecto — el
`app.component.ts` que te entrego usa `template` inline y no los necesita.

## 3. Verificar la URL del backend

En `src/app/core/services/empleado.service.ts`, confirma que `baseUrl`
apunte a donde corre tu API (`http://localhost:5000/api/empleados` por
defecto, según lo que ya validamos juntos con Postman).

## 4. Ejecutar

```bash
ng serve
```

Abre `http://localhost:4200`.

## 5. Sobre los íconos

Se usa **Material Symbols** (fuente de Google, cargada vía `<link>` en
`index.html`) solo como fuente de glifos — no trae componentes visuales
ni sistema de diseño, así que no cuenta como "librería de estilos". Cada
ícono se referencia por nombre (ej. `save`, `groups`, `error`) a través
de `<app-icon name="...">`, el componente reutilizable en
`shared/icon/`. Puedes buscar más nombres de íconos disponibles en
https://fonts.google.com/icons.

## 6. Estructura y por qué (SRP)

```
src/app/
├── core/
│   ├── models/empleado.model.ts       # Contratos (Empleado, CrearEmpleado)
│   └── services/empleado.service.ts   # Único punto de consumo HTTP
├── shared/
│   ├── icon/                          # Ícono reutilizable
│   └── alert-banner/                  # Banner de éxito/error reutilizable
├── empleados/
│   ├── empleados-list/                # "Dumb": solo muestra la tabla
│   ├── empleado-form/                 # "Dumb": solo captura y valida
│   └── empleados-page.*               # "Smart": orquesta HTTP + hijos
├── app.component.ts
└── app.config.ts                      # provideHttpClient()
```

- **`shared/`** contiene piezas de UI sin lógica de negocio, reusadas
  por más de un componente (`icon`, `alert-banner`). Si mañana cambia
  el proveedor de íconos, solo se toca `icon.component.ts`.
- **`empleados-list` y `empleado-form`** no inyectan `EmpleadoService`
  — reciben datos por `@Input` y notifican por `@Output`. Esto los hace
  fáciles de probar de forma aislada (no requieren mockear HTTP).
- **`empleados-page`** es el único componente con lógica de
  orquestación: pide el listado al iniciar, y cuando el formulario
  emite `creado`, refresca la lista y muestra el banner de éxito.
