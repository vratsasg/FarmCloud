(function () {
    'use strict';
    var module = angular.module("myApp", ['nvd3', 'openlayers-directive', 'ngComponentRouter', 'ui.bootstrap', 'ngTable', 'ui.bootstrap.datetimepicker', 'ngAnimate', 'toastr', 'angularMoment']);
    module.value("$routerRootComponent", "cropApp");
}());