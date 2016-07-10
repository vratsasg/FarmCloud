(function () {
    'use strict';
    var module = angular.module("myApp");

    module.component('observableProperty', {
        templateUrl: 'static/js/components/observable-property/observable-property.component.html',
        controllerAs: "model",
        controller: function (ObservablePropertyService, $log, $q) {
            var model = this;


            model.$routerOnActivate = function (next) {
                console.log(next);
                model.id = next.params.id;
                var StrDescr = next.params.description;
                model.descr = StrDescr.replace(/%20/g, " ");

            };

            model.myDevice = "";
            model.datefrom = "11/1/2013";
            model.dateto = "12/1/2013";

            $("#datetimepickerfrom").on("dp.change", function () {
                model.datefrom = $("#datetimepickerfrom :input").val();
                console.log("selected date is " + model.datefrom);
                $(this).trigger('change');
            });
            $("#datetimepickerto").on("dp.change", function () {
                model.dateto = $("#datetimepickerto :input").val();
                console.log("selected date is " + model.dateto);
                $(this).trigger('change');
            });

            model.$onInit = function () {
                var deferDev = $q.defer();

                ObservablePropertyService.getDevices().then(
                    function (da) {
                        model.devices = da;
                        deferDev.resolve(model.devices);
                        model.myDevice = model.devices.enddevices[0].identifier;
                    },
                    function (errResponse) {
                        console.error('Error while fetching devices for firstpage');
                    }
                );
            }
        }
    });
}());

