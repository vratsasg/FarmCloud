(function () {
    'use strict';
    var module = angular.module("myApp");

    module.component('stationcoordsModal', {
            templateUrl: 'static/js/components/my-profile/stationcoords.modal.component.html',
            replace: true,
            require: {
                parent: '^myProfile'
            },
            controllerAs: "model",
            controller: function (ProfileService, $q) {
                var model = this;
                var defer = $q.defer();

                model.$onInit = function () {
                    var instance = model.parent.modalInstance;

                    model.defaults = {
                        // layers: {
                        //     main: {
                        //         source: {
                        //             type: 'OSM',
                        //             url: 'http://{a-c}.tile.opencyclemap.org/cycle/{z}/{x}/{y}.png'
                        //         }
                        //     }
                        // },
                        interactions: {
                            mouseWheelZoom: true
                        },
                        controls: {
                            zoom: true,
                            rotate: false,
                            attribution: false
                        }
                    };

                    model.cancel = function () {
                        instance.dismiss('cancel');
                    };

                    model.submit = function () {
                        console.log('You hit me!');
                        //ControlPanelService.setMeasuringFlags(model.coordinator).then(
                        //    function (returnedData) {
                        //        defer.resolve(returnedData);
                        //        instance.close(returnedData);
                        //    }, function (errResponse) {
                        //        console.error('Error while sending request for starting measuring');
                        //    });
                    };

                    instance.result.then(function (returnedData) {
                        console.log('testModal Measure');
                    }, function () {
                        console.log('Modal dismissed at: ' + new Date());
                    });
                };
            }
        }
    );
}());
