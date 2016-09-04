(function () {
    'use strict';
    var module = angular.module("myApp");

    module.component('firstPage', {

        templateUrl: 'static/js/components/home/first-page.component.html',
        controllerAs: "model",
        controller: function (firstPageDevices, $log, $q) {
            var model = this;
            model.devices = {enddevices: [{identifier: ""}]};

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
                        model.myDevice = model.devices.enddevices[0].identifier;
                    },
                    function (errResponse) {
                        console.error('Error while fetching devices for firstpage');
                    }
                );

                firstPageDevices.getStationCoords(2).then(
                    function (d) {
                        model.center = {
                            lon: d[0],
                            lat: d[1],
                            zoom: 12
                        }
                    },
                    function (errResponse) {
                        console.error('Error while fetching devices for firstpage');
                    }
                );

                //window.onmousemove = function (e) {
                //    var x = e.clientX,
                //        y = e.clientY;
                //    var tooltipSpan = $('.nvtooltip');
                //    if(tooltipSpan != 'undefined' && tooltipSpan != null && tooltipSpan != '') {
                //        $('.nvtooltip')[0].style.top = (y + 10) + 'px';
                //        $('.nvtooltip')[0].style.left = (x + 10) + 'px';
                //        $('.nvtooltip')[1].style.top = (y + 10) + 'px';
                //        $('.nvtooltip')[1].style.left = (x + 10) + 'px';
                //    }
                //};


            }


        }
    });
}());
