(function () {
    'use strict';

    var module = angular.module("myApp", ['openlayers-directive', 'ngComponentRouter', 'ui.bootstrap']);
    //module.constant('moment', require('moment-timezone'));
    module.value("$routerRootComponent", "cropApp");
}());