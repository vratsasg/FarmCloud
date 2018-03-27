(function () {
    "use strict";
    var module = angular.module("myApp");

    module.component("controlPanel", {

        templateUrl: "/js/components/control-panel/control-panel.component.html",
        controllerAs: "model",
        controller: function ($uibModal, $document, ControlPanelService, $log, $q,toastr) {
            var model = this;
            var defer = $q.defer();
            //model.devices = {enddevices: [{identifier: ""}]};
            model.myDevice = {};
            model.irrigationDtStart = null;
            model.irrigationDtEnd = null;
            model.irrigationCosnume = null;
            model.disableIrrigbtn = true;
            model.disableMeasurebtn = false;
            model.coordinator = null;


            model.$onInit = function () {
                ControlPanelService.getDevices().then(
                    function (devicesdata) {
                        model.devices = devicesdata;
                        model.myDevice = model.devices[0];

                        //Get Last measures by last date
                        ControlPanelService.getMeasuresByLastDate(devicesdata[0].identifier).then(
                            function (lastDateMeasures) {
                                lastDateMeasures.forEach(function(measure){
                                    measure.phenomenonTime = moment(parseInt(measure.phenomenonTime * 1000)).format("dddd, MMMM Do h:mma");
                                });

                                model.lastmeasuresData = lastDateMeasures;
                                model.lastDate = lastDateMeasures[0].phenomenonTime;
                            },
                            function (errResponse) {
                                toastr.error("Error while fetching devices for firstpage " + errResponse, "Error!");
                            }
                        );

                        ControlPanelService.getCoordinatorData(devicesdata[0].identifier).then(
                            function (coordData) {
                                var datefrom = moment(coordData.autoIrrigFromTime);
                                var dateto = moment(coordData.autoIrrigUntilTime);

                                if (datefrom.isValid() && dateto.isValid()) {
                                    model.AutomaticTimeDiff = getTimeDiff(datefrom, dateto);
                                }

                                model.coordinator = {};
                                model.coordinator.autoIrrigFromTime = new Date(1970, 0, 1, datefrom.hours(), datefrom.minutes(), 0);//moment(coordData.autoIrrigFromTime).format("HH:mm:ss");
                                model.coordinator.autoIrrigUntilTime = new Date(1970, 0, 1, dateto.hours(), dateto.minutes(), 0);
                                model.coordinator.waterConsumption = coordData.waterConsumption;
                                model.coordinator.identifier = coordData.identifier;
                            },
                            function (errResponse) {
                                toastr.error("Error while fetching devices for firstpage " + errResponse, "Error!");
                            }
                        );

                        ControlPanelService.getWateringMeasuresByLastDate(devicesdata[0].identifier).then(
                            function (waterMeasureData) {
                                if (waterMeasureData === null || waterMeasureData === undefined) {
                                    return;
                                }
                                //
                                model.wateringIrrigationDateFrom = waterMeasureData.autoIrrigFromTime;
                                model.wateringIrrigationDateTo = waterMeasureData.autoIrrigUntilTime;
                                model.wateringConsumption = waterMeasureData.waterConsumption;
                            },
                            function (errResponse) {
                                toastr.error("Error while fetching devices for firstpage " + errResponse, "Error!");
                            }
                        );
                    },
                    function (errResponse) {
                        toastr.error("Error while fetching devices for firstpage " + errResponse, "Error!");
                    }
                );
            };

            model.updateTotalAlgorithmTime = function () {
                var timefrom = moment(model.coordinator.autoIrrigFromTime);
                var timeto = moment(model.coordinator.autoIrrigUntilTime);

                if (timefrom.isValid() && timeto.isValid()) {
                    model.AutomaticTimeDiff = getTimeDiff(timefrom, timeto);
                }
            };

            model.updateMyDevice = function (myD) {
                ControlPanelService.getMeasuresByLastDate(myD.identifier).then(
                    function (lastDateMeasures) {
                        lastDateMeasures.forEach(function(measure) {
                            measure.phenomenonTime = moment(parseInt(measure.phenomenonTime * 1000)).format("dddd, MMMM Do h:mma");
                        });
                        model.lastmeasuresData = lastDateMeasures;
                    },
                    function (errResponse) {
                        toastr.error("Error while fetching devices for firstpage " + errResponse, "Error!");
                    }
                );

                ControlPanelService.getWateringMeasuresByLastDate(myD.identifier).then(
                    function (waterMeasureData) {
                        model.wateringIrrigationDateFrom = moment(waterMeasureData.autoIrrigFromTime).format("dddd, MMMM Do, YYYY h:mma");
                        model.wateringIrrigationDateTo = moment(waterMeasureData.autoIrrigUntilTime).format("dddd, MMMM Do, YYYY h:mma");
                        model.wateringConsumption = waterMeasureData.waterConsumption;
                    },
                    function (errResponse) {
                        toastr.error("Error while fetching last watering measure data " + errResponse, "Error!");
                    }
                );
            }

            model.showModal = function () {
                model.modalInstance = $uibModal.open({
                    animation: model.animationsEnabled,
                    template: "<irrigation-modal></irrigation-modal>",
                    appendTo: $document.find("control-panel")
                });
            }

            model.showModalMeasuring = function () {
                model.modalInstance = $uibModal.open({
                    animation: model.animationsEnabled,
                    template: "<measuring-modal></measuring-modal>",
                    appendTo: $document.find("control-panel")
                });

                model.modalInstance.result.then(function (selectedItem) {
                    $log.info("Modal dismissed at: " + new Date());
                    $log.info(selectedItem);
                }, function () {
                    $log.info("Modal dismissed at: " + new Date());
                });
            }

            model.showModalSaveCoordData = function () {
                model.modalInstance = $uibModal.open({
                    animation: model.animationsEnabled,
                    template: "<algorithm-modal></algorithm-modal>",
                    appendTo: $document.find("control-panel")
                });
            }

            model.toggleAnimation = function () {
                model.animationsEnabled = !model.animationsEnabled;
            }
        }
    });
}());

function getTimeDiff(timefrom, timeto) {
    var totalHours = parseInt(timeto.diff(timefrom, "hours"));
    var totalMinutes = parseInt(timeto.diff(timefrom, "minutes")) % 60;

    if (totalHours === 0) {
        if (totalMinutes < 0) {
            totalHours = 23;
            totalMinutes = 60 + totalMinutes;
        }
    } else if (totalHours < 0) {
        if (totalMinutes < 0) {
            totalHours = 24 + totalHours - 1;
            totalMinutes = 60 + totalMinutes;
        } else if (totalMinutes === 0) {
            totalHours = 24 + totalHours;
        }
    }

    return (totalHours + " hours and " + totalMinutes + " minutes");
}
