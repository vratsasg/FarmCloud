(function () {
    'use strict';
    var module = angular.module("myApp");

    module.component('wateringProfile', {
        templateUrl: 'static/js/components/watering-profile/watering-profile.component.html',
        controllerAs: "model",
        controller: function ($log, $q, ngTableParams, $filter, $scope) {
            var model = this;
        }
    });

}());