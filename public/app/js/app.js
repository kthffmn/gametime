'use strict';

var gameApp = angular.module('gameApp', [
  'ngRoute',
  'gameControllers'
]);

gameApp.config(['$routeProvider',
  function($routeProvider) {
    $routeProvider.
    when('/games', {
      templateUrl: 'partials/game-list.html',
      controller: 'GameListCtrl'
    }).
    otherwise({
      templateUrl: 'partials/404.html',
      controller: 'GameListCtrl'
    });
  }
]);