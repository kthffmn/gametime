'use strict';

var gametimeControllers = angular.module('gametimeControllers', []);

gametimeControllers.controller('GameListCtrl', ['$scope', '$http',
  function($scope, $http){
    $http.get('/games.json').success(function(data) {
      $scope.games = data.games;
      $scope.user = data.user;
    });
  $scope.orderProp = 'most_popular_name.content';
  }
]);