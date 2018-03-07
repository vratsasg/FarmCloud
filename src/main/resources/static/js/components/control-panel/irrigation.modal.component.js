(function () {
    "use strict";
    var module = angular.module("myApp");

    module.component("irrigationModal", {
            templateUrl: "/js/components/control-panel/irrigation.modal.component.html",
            replace: true,
            require: {
                parent: "^controlPanel"
            },
            controllerAs: "model",
            controller: function (ControlPanelService, $q, $scope, toastr) {
                var model = this;
                var defer = $q.defer();
                var instance = null;

                model.$onInit = function () {
                    model.datefrom = moment();
                    model.irrigationDuration = "0 hours and 0 minutes";
                    model.modWaterConsume = 0;
                    instance = model.parent.modalInstance;
                }

                model.cancel = function () {
                    instance.dismiss("cancel");
                }

                model.submit = function () {
                    if (model.datefrom && model.dateto) {
                        // setIrrigationDates
                        ControlPanelService.setFeatureDates(model.parent.myDevice.identifier, model.datefrom.format("YYYY-MM-DD HH:mm:ss"), model.dateto.format("YYYY-MM-DD HH:mm:ss")).then(
                            function (returnedData) {
                                defer.resolve(returnedData);
                                toastr.success(`New irrigation event for enddevice: ${model.parent.myDevice.identifier} from ${model.datefrom} until ${model.dateto}`,"Success!");
                                instance.close(returnedData);
                            }, function (errResponse) {
                                toastr.error(`Error while sending request for starting measuring: ${errResponse}`,"Error!");
                                instance.close(errResponse);
                            });
                    }
                }

                model.updateDateFrom = function (newstarttime) {
                    var newendtime = model.dateto;

                    if (newstarttime && newendtime) {
                        var totalHours = (newendtime.diff(newstarttime, "hours"));
                        if (totalHours > 12) { //12 hours of irrigation is too much???
                            model.dateto = "";
                            return;
                        }

                        var totalMinutes = newendtime.diff(newstarttime, "minutes");
                        var clearMinutes = totalMinutes % 60;
                        model.irrigationDuration = totalHours + " hours and " + clearMinutes + " minutes";
                        model.modWaterConsume = (totalHours + clearMinutes / 60) * model.parent.coordinator.waterConsumption;
                        toastr.info(`${totalHours} hours and ${clearMinutes} minutes`,"Information");
                    }
                }

                model.updateDateTo = function (newendtime) {
                    var newstarttime = model.datefrom;

                    if (newstarttime && newendtime) {
                        var totalHours = (newendtime.diff(newstarttime, "hours"));
                        if (totalHours > 12) { //12 hours of irrigation is too much???
                            model.dateto = "";
                            return;
                        }

                        var totalMinutes = newendtime.diff(newstarttime, "minutes");
                        var clearMinutes = totalMinutes % 60;
                        model.irrigationDuration = totalHours + " hours and " + clearMinutes + " minutes";
                        model.modWaterConsume = (totalHours + clearMinutes / 60) * model.parent.coordinator.waterConsumption;
                        toastr.info(`${totalHours} hours and ${clearMinutes} minutes`,"Information");
                    }
                }

                model.beforeRenderStartDate = function ($view, $dates, $leftDate, $upDate, $rightDate) {
                    var now = moment();
                    $dates.forEach(function(dt) {
                        if (dt.localDateValue() < now.valueOf()) {
                            dt.selectable = false;
                        }
                    });

                    if (model.dateto) {
                        var activeDate = moment(model.dateto);
                        $dates.forEach(function(dt) {
                            if (dt.localDateValue() >= activeDate.valueOf()) {
                                dt.selectable = false;
                            }
                        });
                    }
                }

                model.beforeRenderEndDate = function ($view, $dates, $leftDate, $upDate, $rightDate) {
                    if (model.datefrom) {
                        var activeDate = moment(model.datefrom).subtract(1, $view).add(1, "minute");
                        $dates.forEach(function(dt) {
                            if (dt.localDateValue() <= activeDate.valueOf()) {
                                dt.selectable = false;
                            }
                        });
                    }
                };
            }
        }
    );
}());
