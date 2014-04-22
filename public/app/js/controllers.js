'use strict';

var gametimeControllers = angular.module('gametimeControllers', []);

gametimeApp.controller('GameListCtrl', ['$scope', '$http',
  function($scope, $http){
    $http.get('/games.json').success(function(data) {
      $scope.games = data;
    });
  }
]);