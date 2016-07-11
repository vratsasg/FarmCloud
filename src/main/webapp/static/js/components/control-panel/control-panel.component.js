(function () {
    'use strict';
    var module = angular.module("myApp");

    module.component('controlPanel', {

        templateUrl: 'static/js/components/control-panel/control-panel.component.html',
        controllerAs: "model",
        controller: function (ControlPanelService, $log, $q) {
            var model = this;

            model.$onInit = function () {
                var defer = $q.defer();

                ControlPanelService.getDevices().then(
                    function (devicesdata) {
                        console.log(devicesdata);

                        ControlPanelService.getMeasuresByLastDate("40E7CC39").then(
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


        }
    });
}());


