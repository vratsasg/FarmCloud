(function () {
    'use strict';

    var module = angular.module("myApp", ['openlayers-directive', 'ngComponentRouter', 'ui.bootstrap']);

    module.value("$routerRootComponent", "cropApp");
}());