(function () {
    'use strict';
    var module = angular.module("myApp");

    module.component('algorithmModal', {
            templateUrl: 'static/js/components/control-panel/algorithm.modal.component.html',
            replace: true,
            require: {
                parent: '^controlPanel'
            },
            controllerAs: "model",
            controller: function (ControlPanelService, $q) {
                var model = this;
                var defer = $q.defer();

                model.$onInit = function () {
                    var coord = model.parent.coordinator;
                    coord.autoIrrigFromTime = moment(coord.autoIrrigFromTime).format("YYYY-MM-DD HH:mm:ss");
                    coord.autoIrrigUntilTime = moment(coord.autoIrrigUntilTime).format("YYYY-MM-DD HH:mm:ss");

                    var instance = model.parent.modalInstance;
                    model.cancel = function () {
                        instance.dismiss('cancel');
                    };

                    model.submit = function () {
                        ControlPanelService.setAutomaticIrrigationTimes(coord).then(
                            function (returnedData) {
                                defer.resolve(returnedData);
                                instance.close(returnedData);
                            }, function (errResponse) {
                                console.error('Error while sending request for starting measuring');
                            });
                    };

                    instance.result.then(function (returnedData) {
                        console.log('Modal Automatic Irrigation Time');
                    }, function () {
                        console.log('Modal dismissed at: ' + new Date());
                    });
                };
            }
        }
    );
}());
