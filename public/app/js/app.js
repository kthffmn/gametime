'use strict';

var gametimeApp = angular.module('gametimeApp', [
  'ngRoute',
  'gametimeControllers'
]);

gametimeApp.config(['$routeProvider',
  function($routeProvider) {
    $routeProvider.
      when('/games', {
        templateUrl: 'partials/game-list.html',
        controller: 'GameListCtrl'
      }).
      otherwise({
        redirectTo: '/games'
      });
  }
]);