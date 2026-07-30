angular.module('empleadosApp').factory('EmpleadoService', function($q, $timeout) {

  var datos = [
    { documento: 1000101, nombres: 'Carlos',    apellidos: 'Gomez Rojas',     cargo: 'Desarrollador Junior', salario: 3200000 },
    { documento: 1000102, nombres: 'Andrea',    apellidos: 'Martinez Diaz',   cargo: 'Analista QA',          salario: 3500000 },
    { documento: 1000103, nombres: 'Luis',      apellidos: 'Perez Castro',    cargo: 'Desarrollador Senior', salario: 6800000 },
    { documento: 1000104, nombres: 'Maria',     apellidos: 'Lopez Vargas',    cargo: 'Lider Tecnico',        salario: 8200000 },
    { documento: 1000105, nombres: 'Jorge',     apellidos: 'Hernandez Silva', cargo: 'Soporte TI',           salario: 2800000 },
    { documento: 1000106, nombres: 'Paula',     apellidos: 'Sanchez Moreno',  cargo: 'Analista de Datos',    salario: 4100000 },
    { documento: 1000107, nombres: 'Felipe',    apellidos: 'Ramirez Ortiz',   cargo: 'Desarrollador Junior', salario: 3100000 },
    { documento: 1000108, nombres: 'Camila',    apellidos: 'Torres Rincon',   cargo: 'DBA',                  salario: 5500000 }
  ];

  // Simula la latencia de un backend real
  function conLatencia(resultado) {
    var deferred = $q.defer();
    $timeout(function() { deferred.resolve(angular.copy(resultado)); }, 600);
    return deferred.promise;
  }

  return {
    listar: function() {
      return conLatencia(datos);
    },
    crear: function(emp) {
      datos.push(angular.copy(emp));
      return conLatencia(emp);
    },
    eliminar: function(documento) {
      datos = datos.filter(function(e) { return e.documento != documento; });
      return conLatencia({ ok: true });
    }
  };
});
