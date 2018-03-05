(function () {
    'use strict';
    var module = angular.module("myApp");

    module.component('myProfile', {
        templateUrl: 'static/js/components/my-profile/my-profile.component.html',
        controllerAs: "model",
        controller: function ($uibModal, $document, ProfileService, $log, $q, toastr) {
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
                        toastr.error('Error while fetching Profile: ' + errResponse, 'Error');
                    }
                );

                ProfileService.getStationCoords().then(
                    function (d) {
                        model.center = {
                            lon: d[0],
                            lat: d[1],
                            zoom: 12
                        }

                        model.markers = [
                            {
                                name: "Station",
                                lon: d[0],
                                lat: d[1],
                                label: {
                                    message: "Station",
                                    show: true,
                                    showOnMouseOver: true
                                }
                            }
                        ];
                    },
                    function (errResponse) {
                        toastr.error(`Save profile error: ${errResponse}`, 'Error');
                    }
                );
            };

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
                        toastr.success(`You have successfully saved your crop's information!`, 'Success!');
                    }, function (errResponse) {
                        toastr.error(`Save profile error: ${errResponse}`, 'Error');
                    }
                );

            };

            model.showModalStationLocation = function (stationId) {
                model.modalInstance = $uibModal.open({
                    animation: model.animationsEnabled,
                    template: '<stationcoords-modal></stationcoords-modal>',
                    appendTo: $document.find('my-Profile')
                });
            };

        }
    });
}());
