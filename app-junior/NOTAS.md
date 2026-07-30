# NOTAS.md — Corrección de bugs

Se encontraron y corrigieron **3 bugs**, todos en la capa de
presentación/controller (no en `EmpleadoService`, que estaba correcto).

---

## Bug 1 — El indicador "Cargando empleados..." no refleja la realidad

**Archivo:** `js/empleados.controller.js`

**Código original:**
```js
$scope.cargando = true;

EmpleadoService.listar().then(function(data) {
  $scope.empleados = data;
});

$scope.cargando = false;
```

**Por qué ocurría:**
`EmpleadoService.listar()` es asíncrono, devuelve una promesa que se
resuelve ~600ms después (simulando la latencia de un backend real, ver
`$timeout` en `empleado.service.js`). La línea `$scope.cargando = false` está **fuera** del `.then()`, en el flujo síncrono del controller, así que se ejecuta de inmediato, apenas se dispara la petición, no cuando esta termina. El resultado visible: el mensaje "Cargando..." desaparece al instante y, como `$scope.empleados` todavía está vacío en ese momento, se ve la tabla vacía por una fracción de segundo hasta que Angular vuelve a re-renderizar cuando la promesa sí se resuelve.

**Cómo se corrigió:**
Mover `$scope.cargando = false` dentro de un `.finally()` encadenado a
la promesa, para que se ejecute únicamente cuando la petición
efectivamente termina (haya tenido éxito o fallado):

```js
EmpleadoService.listar()
  .then(function(data) {
    $scope.empleados = data;
  })
  .finally(function() {
    $scope.cargando = false;
  });
```

---

## Bug 2 — El buscador no filtra nada, escriba lo que se escriba

**Archivo:** `index.html`

**Código original:**
```html
<input type="text" ng-model="busqueda" placeholder="Buscar por nombre...">
...
<tr ng-repeat="emp in empleados | filter: textoBusqueda">
```

**Por qué ocurría:**
El campo de texto está enlazado a la variable de scope `busqueda`
(vía `ng-model="busqueda"`), pero el filtro de la tabla usa
`textoBusqueda`, una variable que **nunca se definió** en ningún
lado del controller. AngularJS no lanza ningún error por esto (es
simplemente una expresión que evalúa a `undefined`), así que el
`filter` recibe `undefined` como criterio y, al no tener nada que
filtrar, deja pasar todos los registros sin importar lo que el
usuario escriba.

**Cómo se corrigió:**
Cambiar el filtro para que apunte a la variable real:

```html
<tr ng-repeat="emp in empleados | filter: busqueda">
```

---

## Bug 3 — Al eliminar un empleado, desaparecen también todos los que están debajo

**Archivo:** `js/empleados.controller.js`

**Código original:**
```js
for (var i = 0; i < $scope.empleados.length; i++) {
  if ($scope.empleados[i].documento == documento) {
    $scope.empleados.splice(i);
  }
}
```

**Por qué ocurría:**
`Array.prototype.splice(start)`, **sin** un segundo argumento
(`deleteCount`), elimina el elemento en la posición `start` **y todos
los elementos posteriores hasta el final del arreglo**. El código
buscaba correctamente el índice del empleado a eliminar, pero al
llamar `splice(i)` en vez de `splice(i, 1)`, terminaba borrando ese
empleado y absolutamente todos los que estaban después de él en la
lista.

**Cómo se corrigió:**
Agregar el segundo argumento `1` para eliminar exactamente un
elemento, y cortar el `for` con `break` apenas se encuentra (ya no
tiene sentido seguir iterando):

```js
for (var i = 0; i < $scope.empleados.length; i++) {
  if ($scope.empleados[i].documento == documento) {
    $scope.empleados.splice(i, 1);
    break;
  }
}
```

---

## Resumen

| # | Bug | Archivo | Causa raíz | Corrección |
|---|---|---|---|---|
| 1 | Indicador de carga engañoso | `empleados.controller.js` | `cargando = false` fuera del `.then()` | Mover a `.finally()` |
| 2 | Buscador no filtra | `index.html` | Filtro usaba variable inexistente (`textoBusqueda`) | Usar la variable real (`busqueda`) |
| 3 | Eliminar borra de más | `empleados.controller.js` | `splice(i)` sin `deleteCount` | Usar `splice(i, 1)` |

`empleado.service.js` y `app.js` no presentaban bugs y se dejaron sin
modificaciones.

## Preguntas de cierre

### ¿Qué es `$scope`?

`$scope` es el objeto que **conecta el controller con la vista (HTML)**
en AngularJS. Todo lo que se le asigna como propiedad (`$scope.empleados`,
`$scope.cargando`, `$scope.busqueda`) queda automáticamente
disponible para leerse y escribirse desde el template a través de
directivas como `{{ }}`, `ng-model`, `ng-repeat` o `ng-if`.

En este proyecto, `$scope` es literalmente el "puente" que usa
`EmpleadosCtrl` para exponerle a `index.html` la lista de empleados,
el estado de carga, el texto de búsqueda y las funciones `guardar()` /
`eliminar()`.

### ¿Qué diferencia hay entre un servicio con `.factory()` y `.service()`?

Ambos sirven para lo mismo, registrar un servicio inyectable (singleton compartido en toda la app), pero difieren en **cómo se construye el objeto que finalmente se inyecta**:

- **`.factory(nombre, funcion)`**: la función que se le pasa se ejecuta y **lo que retorna** (un objeto, un array, una función) es
  literalmente el servicio. Tienes control total sobre la forma del
  objeto final. Así está construido `EmpleadoService` en este proyecto:

  ```js
  angular.module('empleadosApp').factory('EmpleadoService', function($q, $timeout) {
    // ...
    return {
      listar: function() { /* ... */ },
      crear: function(emp) { /* ... */ },
      eliminar: function(documento) { /* ... */ }
    };
  });
  ```

- **`.service(nombre, Constructor)`**: la función que se le pasa se
  invoca con `new`, es decir, se trata como un **constructor de
  clase**. Angular hace internamente algo como
  `new MiConstructor()`, y el servicio resultante es esa instancia.
  Lo que quieras exponer se asigna a `this`:

  ```js
  angular.module('empleadosApp').service('EmpleadoService', function($q, $timeout) {
    this.listar = function() { /* ... */ };
    this.crear = function(emp) { /* ... */ };
    this.eliminar = function(documento) { /* ... */ };
  });
  ```

### ¿Cómo harías una petición HTTP real en AngularJS?

Usando el servicio `$http`, que AngularJS inyecta y que en el fondo
envuelve al `XMLHttpRequest`/`fetch` del navegador, retornando una
promesa (`$q`), el mismo patrón `.then()` que ya usa este proyecto,
solo que en vez de `$timeout` simulando latencia, sería una petición
real a una API.

Por ejemplo, para reemplazar los datos simulados de
`EmpleadoService.listar()` por una llamada real a la API de este mismo
proyecto (la del backend en .NET que construimos):

```js
angular.module('empleadosApp').factory('EmpleadoService', function($http) {

  var baseUrl = 'http://localhost:5000/api/empleados';

  return {
    listar: function() {
      return $http.get(baseUrl)
        .then(function(response) {
          return response.data; // Aquí $http envuelve la respuesta en un objeto {data, status, headers, ...}
        });
    },
    crear: function(emp) {
      return $http.post(baseUrl, emp)
        .then(function(response) {
          return response.data;
        });
    },
    eliminar: function(documento) {
      return $http.delete(baseUrl + '/' + documento)
        .then(function(response) {
          return response.data;
        });
    }
  };
});
```

Puntos clave:
- `$http.get/post/put/delete(...)` retorna una promesa, así que el
  resto del código (`EmpleadosCtrl` usando `.then()`) **no necesita
  cambiar nada** — la interfaz del servicio (`listar()`, `crear()`,
  `eliminar()`) sigue siendo la misma, solo cambia su implementación
  interna. Esto es justamente el beneficio de tener el consumo HTTP
  aislado en un servicio y no disperso en el controller.
- La respuesta de `$http` viene envuelta en un objeto con `.data`,
  `.status`, `.headers`, etc. — hay que extraer `.data` para obtener
  el cuerpo real de la respuesta (a diferencia de `fetch` o de
  Angular moderno con `HttpClient`, donde `.data` no es necesario).
- Para manejar errores (ej. el 409 de "documento duplicado" que ya
  implementamos en el backend), se encadena un segundo callback o
  `.catch()`:

  ```js
  $http.post(baseUrl, emp).then(function(response) {
    // éxito
  }, function(error) {
    // error.data.mensaje trae el mensaje del backend
  });
  ```
