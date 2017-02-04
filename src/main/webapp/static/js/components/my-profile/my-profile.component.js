(function () {
    'use strict';
    var module = angular.module("myApp");

    module.component('myProfile', {
        templateUrl: 'static/js/components/my-profile/my-profile.component.html',
        controllerAs: "model",
        controller: function (ProfileService, $log, $q) {
            var model = this;

            model.myprofile = {};


            model.$onInit = function () {
                var defer = $q.defer();
                ProfileService.getProfile().then(
                    function (d) {
                        model.myprofile = d;
                        defer.resolve(model.myprofile);
                        $log.info('Crop name: ' + model.myprofile.crop.identifier);
                    },
                    function (errResponse) {
                        console.error('Error while fetching Profile');
                    }
                );
            }

            model.saveAllData = function () {
                console.log(angular.toJson(model.myprofile));
                //WateringProfileService.saveWateringProfile(model.obspropminmax).then(/*Do nithing*/);
            };

        }
    });
}());
