(function () {
    "use strict";
    var module = angular.module("myApp");

    module.component("algorithmModal", {
            templateUrl: "/js/components/control-panel/algorithm.modal.component.html",
            replace: true,
            require: {
                parent: "^controlPanel"
            },
            controllerAs: "model",
            controller: function (ControlPanelService, $q, toastr) {
                var model = this;
                var defer = $q.defer();
                var instance = null;
                model.coord = null;

                model.$onInit = function () {
                    model.coord = model.parent.coordinator;
                    model.coord.autoIrrigFromTime = moment(model.coord.autoIrrigFromTime).format("YYYY-MM-DD HH:mm:ss");
                    model.coord.autoIrrigUntilTime = moment(model.coord.autoIrrigUntilTime).format("YYYY-MM-DD HH:mm:ss");

                    instance = model.parent.modalInstance;

                    instance.result.then(function (returnedData) {
                        console.log("Modal Automatic Irrigation Time");
                    }, function () {
                        console.log("Modal dismissed at: " + new Date());
                    });
                }

                model.cancel = function () {
                    instance.dismiss("cancel");
                }

                model.submit = function () {
                    ControlPanelService.setAutomaticIrrigationTimes(model.coord).then(
                        function (returnedData) {
                            defer.resolve(returnedData);
                            toastr.success("New automatic irrigation times saved succesfully","Algorithm times");
                            instance.close(returnedData);
                        }, function (errResponse) {
                            toastr.error(`New automatic irrigation times failed on save ${errResponse}`,"Error!");
                            instance.close();
                        });
                }
            }
        }
    );
}());
