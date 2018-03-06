(function () {
    'use strict';
    var module = angular.module("myApp");

    $("#body").on(
        "transitionend MSTransitionEnd webkitTransitionEnd oTransitionEnd",
        function () {
            $("#alertAreaid").html("");
        }
    );

    module.component('wateringProfile', {
        templateUrl: '/js/components/watering-profile/watering-profile.component.html',
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

            model.saveAllData = function () {
                console.log(angular.toJson(model.obspropminmax));
                WateringProfileService.saveWateringProfile(model.obspropminmax).then(
                    function (response) {
                        if (response === true || response == "true") {
                            var myElement = angular.element(document.querySelector('#alertAreaid'));
                            var appenddiv =
                                '<div class="alert alert-success alert_successSave">' +
                                '   <strong>Success!</strong>You have succesfully saved your profile!' +
                                '</div>';
                            myElement.html(appenddiv);
                        }
                    }
                );
            };


        }
    });

}());