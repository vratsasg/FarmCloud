(function () {
    'use strict';
    var module = angular.module("myApp");

    module.component('wateringProfile', {
        templateUrl: 'static/js/components/watering-profile/watering-profile.component.html',
        controllerAs: "model",
        controller: function (WateringProfileService, $log, $q, $scope) {
            var model = this;
            model.obspropminmax = {};

            model.$onInit = function () {
                var defer = $q.defer();

                WateringProfileService.getMinMaxValues().then(
                    function (responsedata) {
                        model.obspropminmax = responsedata;
                        defer.resolve(model.obspropminmax);
                        console.log(model.obspropminmax)
                    });
            }
        }
    });

}());