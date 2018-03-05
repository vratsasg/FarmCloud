(function () {
    'use strict';
    var module = angular.module("myApp");

    module.component('wateringProfile', {
        templateUrl: 'static/js/components/watering-profile/watering-profile.component.html',
        controllerAs: "model",
        controller: function (WateringProfileService, $log, $q, $scope, toastr) {
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

            model.saveAllData = function () {
                console.log(angular.toJson(model.obspropminmax));
                WateringProfileService.saveWateringProfile(model.obspropminmax).then(
                    function (response) {
                        if (response === true || response == "true") {
                            toastr.success('Watering profile saved succesfully', 'Success');
                        } else {
                            toastr.error('Error on save watering profile data', 'Error');
                        }
                    },
                    function (errResponse) {
                        toastr.error(errResponse, 'Error!');
                    }
                );
            };


        }
    });

}());