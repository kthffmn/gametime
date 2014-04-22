'use strict';

var gametimeControllers = angular.module('gametimeControllers', []);

gametimeApp.controller('GameListCtrl', ['$scope', '$http',
  function($scope, $http){
    $http.get('http://localhost:3000/games.json').success(function(data) {
      $scope.games = data;
    });
    $scope.orderProp = 'likes';
  }
]);