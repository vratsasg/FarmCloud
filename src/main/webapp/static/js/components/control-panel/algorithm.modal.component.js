(function () {
    'use strict';
    var module = angular.module("myApp");

    module.component('measuringModal', {
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
                    model.coordinator = "";

                    var instance = model.parent.modalInstance;
                    model.cancel = function () {
                        instance.dismiss('cancel');
                    };

                    model.submit = function () {
                        ControlPanelService.setAutomaticIrrigationTimes().then(
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
