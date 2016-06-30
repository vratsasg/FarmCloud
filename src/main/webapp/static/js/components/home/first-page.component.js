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

                        console.log(model.myDevice);

                    },
                    function (errResponse) {
                        console.error('Error while fetching devices for firstpage');
                    }
                );


            }


        }
    });
}());
