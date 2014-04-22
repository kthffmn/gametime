'use strict';

//this used to be in our controllers 
// but now that we have more than one
// controller, it's going in here!

//the empty array argument also now holds
//2 items, these are the modules that the
//app depends on
// ngRoutes - allows us to use angular-route.js
// gametimeControllers - al
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
  }]);