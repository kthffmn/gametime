'use strict';

var gameControllers = angular.module('gameControllers', []);

gameControllers.controller('GameListCtrl', ['$scope','$http',
  function($scope, $http){
    $http.get('/games.json').success(function(data) {
      $scope.games = data;
    });
    $scope.orderProp = 'likes';
  }
]);