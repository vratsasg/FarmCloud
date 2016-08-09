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

            model.$onInit = function () {
                var defer = $q.defer();

                ControlPanelService.getDevices().then(
                    function (devicesdata) {
                        console.log(devicesdata);

                        model.devices = devicesdata;
                        model.myDevice = model.devices.enddevices[0].identifier;

                        ControlPanelService.getMeasuresByLastDate(devicesdata.enddevices[0].identifier).then(
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
                    },
                    function (errResponse) {
                        console.error('Error while fetching devices for firstpage');
                    }
                );
                ControlPanelService.getLastMeasureDate().then(
                    function (lastdate) {
                        model.lastDate = moment(parseInt(lastdate)).format("dddd, MMMM Do, YYYY h:mma");
                        console.log(lastdate);
                    },
                    function (errResponse) {
                        console.error('Error while fetching devices for firstpage');
                    }
                );
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

            model.toggleAnimation = function () {
                model.animationsEnabled = !model.animationsEnabled;
            };


        }
    });
}());


