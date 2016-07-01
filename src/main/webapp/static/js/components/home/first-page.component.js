(function () {
    'use strict';
    var module = angular.module("myApp");

    module.component('firstPage', {

        templateUrl: 'static/js/components/home/first-page.component.html',
        controllerAs: "model",
        controller: function (firstPageDevices, $log, $q) {
            var model = this;
            model.devices = {enddevices: [{identifier: ""}]};


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
                        //TODO set model.center now bitch
                        console.log(d);
                        model.center = {
                            lon: d[1],
                            lat: d[0],
                            zoom: 10
                        }
                    },
                    function (errResponse) {
                        console.error('Error while fetching devices for firstpage');
                    }
                );


            }


        }
    });
}());
