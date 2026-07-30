angular.module('empleadosApp').controller('EmpleadosCtrl', function ($scope, EmpleadoService) {

  $scope.empleados = [];
  $scope.cargando = true;
  $scope.nuevo = {};
  $scope.busqueda = '';

  // BUG 1 corregido: "cargando" se apaga dentro de .finally(), una vez
  // la promesa se resuelve (o falla), no inmediatamente después de
  // disparar la petición. Así el usuario ve "Cargando..." mientras
  // los datos realmente están en camino.
  EmpleadoService.listar()
    .then(function (data) {
      $scope.empleados = data;
    })
    .finally(function () {
      $scope.cargando = false;
    });

  $scope.guardar = function () {
    EmpleadoService.crear($scope.nuevo).then(function (emp) {
      $scope.empleados.push(emp);
      $scope.nuevo = {};
    });
  };

  $scope.eliminar = function (documento) {
    EmpleadoService.eliminar(documento).then(function () {
      for (var i = 0; i < $scope.empleados.length; i++) {
        if ($scope.empleados[i].documento == documento) {
          // BUG 3 corregido: splice(i, 1) elimina SOLO el elemento en
          // la posición i. Sin el segundo argumento, splice(i) borra
          // ese elemento y TODOS los que están después.
          $scope.empleados.splice(i, 1);
          break; // fue encontrado y eliminado, no hace falta seguir iterando
        }
      }
    });
  };
});
