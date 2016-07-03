(function () {
    'use strict';
    var module = angular.module("myApp");

    module.component('observableProperty', {
        templateUrl: 'static/js/components/observable-property/observable-property.component.html',
        controllerAs: "model",
        controller: function (ObservablePropertyService, $log, $q, DTOptionsBuilder, DTColumnBuilder, $scope) {
            var model = this;

            model.$routerOnActivate = function (next) {

                console.log(next);
                model.id = next.params.id;
            };

            model.$onInit = function () {

                var deferDev = $q.defer();
                ObservablePropertyService.getDevices().then(
                    function (da) {
                        model.devices = da;
                        deferDev.resolve(model.devices);
                        model.myDevice = model.devices.enddevices[0].identifier;


                        model.dtOptions = DTOptionsBuilder.fromFnPromise(function () {
                            var defer = $q.defer();


                            ObservablePropertyService.getMeasuresByProperty(model.id, model.myDevice).then(
                                function (d) {
                                    defer.resolve(d.measuredata);

                                    console.log('Something in the way!');
                                },
                                function (errResponse) {
                                    console.error('Error while fetching MeasuresByProperty!!!');
                                }
                            );

                            return defer.promise;
                        }).withPaginationType('full_numbers');

                        model.dtColumns = [
                            DTColumnBuilder.newColumn('phenomenonTime').withTitle('DateTime'),
                            DTColumnBuilder.newColumn('value').withTitle('Value')
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

