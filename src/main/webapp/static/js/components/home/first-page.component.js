(function () {
    'use strict';
    var module = angular.module("myApp");

    module.component('firstPage', {

        templateUrl: 'static/js/components/home/first-page.component.html',
        controllerAs: "model",
        controller: function (firstPageDevices, $log, $q) {
            var model = this;
            //model.devices = {enddevices: [{identifier: ""}]};

            //openlayers controls            
            // model.mapcontrols = [
            //             { name: 'zoom', active: true },
            //             { name: 'rotate', active: true },
            //             { name: 'attribution', active: true }
            //         ];

            model.defaults = {
                interactions: {
                    mouseWheelZoom: true,
                    KeyboardZoom: true,
                    KeyboardPan: true

                },
                controls: {
                    zoom: true,
                    rotate: false,
                    attribution: false,
                    ZoomSlider: true
                }
                // ,view: {
                //     projection: '4326'
                //     //resolutions: apphelper.getResolutions()
                // }
                // ,events: {
                //     map: ['pointermove']
                // }
            };
                    
                    
            model.$onInit = function () {
                var defer = $q.defer();
                firstPageDevices.getDevices().then(
                    function (d) {
                        model.devices = d;
                        defer.resolve(model.devices);
                        model.myDevice = model.devices[0];
                    },
                    function (errResponse) {
                        console.error('Error while fetching devices for firstpage');
                    }
                );

                firstPageDevices.getStationCoords().then(
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
                        console.error('Error while fetching devices for firstpage');
                    }
                );

            }


        }
    });
}());
