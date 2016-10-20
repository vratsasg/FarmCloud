(function () {
    'use strict';
    var module = angular.module("myApp");

    module.component('controlPanel', {

        templateUrl: 'static/js/components/control-panel/control-panel.component.html',
        controllerAs: "model",
        controller: function ($uibModal, $document, ControlPanelService, $log, $q) {
            var model = this;
            model.devices = {enddevices: [{identifier: ""}]};
            model.myDevice = "";
            model.irrigationDtStart = null;
            model.irrigationDtEnd = null;
            model.irrigationCosnume = null;
            model.disableIrrigbtn = true;
            model.disableMeasurebtn = false;
            model.coordinator = null;

            model.$onInit = function () {
                var defer = $q.defer();

                ControlPanelService.getDevices().then(
                    function (devicesdata) {
                        console.log(devicesdata);

                        model.devices = devicesdata;
                        model.myDevice = model.devices.enddevices[0].identifier;

                        //Get Last measures by last date
                        ControlPanelService.getMeasuresByLastDate(devicesdata.enddevices[0].identifier).then(
                            function (lastDateMeasures) {
                                console.log(lastDateMeasures);

                                for (var i = 0; i < lastDateMeasures.length; i++) {
                                    lastDateMeasures[i].phenomenonTime = moment(parseInt(lastDateMeasures[i].phenomenonTime * 1000)).format("dddd, MMMM Do h:mma");
                                }

                                model.lastmeasuresData = lastDateMeasures;
                                model.lastDate = lastDateMeasures[0].phenomenonTime;

                            },
                            function (errResponse) {
                                console.error('Error while fetching devices for firstpage');
                            }
                        );

                        ControlPanelService.getCoordinatorData(devicesdata.enddevices[0].identifier).then(
                            function (coordData) {
                                console.log(coordData);
                                model.coordinator = new Object();
                                model.coordinator.autoIrrigFromTime = moment(coordData.autoIrrigFromTime).format("HH:mm:ss");
                                model.coordinator.autoIrrigUntilTime = moment(coordData.autoIrrigUntilTime).format("HH:mm:ss");
                                model.coordinator.waterConsumption = coordData.waterConsumption;
                                model.coordinator.identifier = coordData.identifier;
                            },
                            function (errResponse) {
                                console.error('Error while fetching devices for firstpage');
                            }
                        );

                        ControlPanelService.getWateringMeasuresByLastDate(devicesdata.enddevices[0].identifier).then(
                            function (waterMeasureData) {
                                console.log(waterMeasureData);
                                model.wateringIrrigationDateFrom = waterMeasureData.autoIrrigFromTime;
                                model.wateringIrrigationDateTo = waterMeasureData.autoIrrigUntilTime;
                                model.wateringConsumption = waterMeasureData.waterConsumption;
                            },
                            function (errResponse) {
                                console.error('Error while fetching devices for firstpage');
                            }
                        );


                    },
                    function (errResponse) {
                        console.error('Error while fetching devices for firstpage');
                    }
                );
                //ControlPanelService.getLastMeasureDate().then(
                //    function (lastdate) {
                //        model.lastDate = moment(parseInt(lastdate)).format("dddd, MMMM Do, YYYY h:mma");
                //        console.log(lastdate);
                //    },
                //    function (errResponse) {
                //        console.error('Error while fetching devices for firstpage');
                //    }
                //);
            }

            model.updateMyDevice = function (myD) {
                console.log(myD);
                //var newValue = myD.enddev.currentValue;
                var newValue = myD;
                var defer = $q.defer();

                ControlPanelService.getMeasuresByLastDate(newValue).then(
                    function (lastDateMeasures) {
                        console.log(lastDateMeasures);
                        for (var i = 0; i < lastDateMeasures.length; i++) {
                            lastDateMeasures[i].phenomenonTime = moment(parseInt(lastDateMeasures[i].phenomenonTime * 1000)).format("dddd, MMMM Do h:mma");
                        }
                        model.lastmeasuresData = lastDateMeasures;
                    },
                    function (errResponse) {
                        console.error('Error while fetching devices for firstpage');
                    }
                );

                ControlPanelService.getWateringMeasuresByLastDate(myD).then(
                    function (waterMeasureData) {
                        console.log(waterMeasureData);
                        model.wateringIrrigationDateFrom = moment(waterMeasureData.autoIrrigFromTime).format('dddd, MMMM Do, YYYY h:mma');
                        model.wateringIrrigationDateTo = moment(waterMeasureData.autoIrrigUntilTime).format('dddd, MMMM Do, YYYY h:mma');
                        model.wateringConsumption = waterMeasureData.waterConsumption;
                    },
                    function (errResponse) {
                        console.error('Error while fetching devices for firstpage');
                    }
                );
            };

            model.showModal = function () {
                model.modalInstance = $uibModal.open({
                    animation: model.animationsEnabled,
                    template: '<irrigation-modal></irrigation-modal>',
                    appendTo: $document.find('control-panel')
                });
            };

            model.showModalMeasuring = function () {
                model.modalInstance = $uibModal.open({
                    animation: model.animationsEnabled,
                    template: '<measuring-modal></measuring-modal>',
                    appendTo: $document.find('control-panel')
                });

                model.modalInstance.result.then(function (selectedItem) {
                    console.log(selectedItem);
                }, function () {
                    $log.info('Modal dismissed at: ' + new Date());
                });
            };

            model.showModalSaveCoordData = function () {
                model.modalInstance = $uibModal.open({
                    animation: model.animationsEnabled,
                    template: '<algorithm-modal></algorithm-modal>',
                    appendTo: $document.find('control-panel')
                });
            }

            model.updateCoordDateFrom = function ($view, $dates, $leftDate, $upDate, $rightDate) {
                var now = moment();
                for (var i = 0; i < $dates.length; i++) {
                    if ($dates[i].localDateValue() < now.valueOf()) {
                        $dates[i].selectable = false;
                    }
                }

                if (model.dateto) {
                    var activeDate = moment(model.dateto);
                    for (var i = 0; i < $dates.length; i++) {
                        if ($dates[i].localDateValue() >= activeDate.valueOf()) {
                            $dates[i].selectable = false;
                        }
                    }
                }
            }

            model.updateCoordDateTo = function ($view, $dates, $leftDate, $upDate, $rightDate) {
                if (model.coordinator.autoIrrigFromTime) {
                    var activeDate = moment(model.coordinator.autoIrrigFromTime).subtract(1, $view).add(1, 'minute');
                    for (var i = 0; i < $dates.length; i++) {
                        if ($dates[i].localDateValue() <= activeDate.valueOf()) {
                            $dates[i].selectable = false;
                        }
                    }
                }
            }

            model.toggleAnimation = function () {
                model.animationsEnabled = !model.animationsEnabled;
            };


        }
    });
}());


