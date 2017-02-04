(function () {
    'use strict';
    var module = angular.module("myApp");

    $("#body").on(
        "transitionend MSTransitionEnd webkitTransitionEnd oTransitionEnd",
        function () {
            $("#alertAreaid").html("");
        }
    );

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
                var arr = [];
                arr.push(model.myprofile.crop);

                for (var i = 0; i < model.myprofile.stations.length; i++) {
                    arr.push(model.myprofile.stations[i]);
                }

                for (var i = 0; i < model.myprofile.devices.length; i++) {
                    arr.push(model.myprofile.devices[i]);
                }

                ProfileService.saveProfile(angular.toJson(arr)).then(
                    function (response) {
                        if (response === true || response == "true") {
                            var myEl = angular.element(document.querySelector('#alertAreaid'));
                            var appenddiv = '<div class="alert alert-success alert_successSave">' +
                                '   <strong>Success!</strong>You have succesfully saved your profile!' +
                                '</div>';
                            myEl.html(appenddiv);
                        }
                    }
                );

            };

        }
    });
}());
