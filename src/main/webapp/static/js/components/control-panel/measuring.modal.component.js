(function () {
    'use strict';
    var module = angular.module("myApp");

    module.component('measuringModal', {
            templateUrl: 'static/js/components/control-panel/measuring.modal.component.html',
            replace: true,
            require: {
                parent: '^controlPanel'
            },
            controllerAs: "model",
            controller: function (ControlPanelService, $q) {
                var model = this;
                var defer = $q.defer();

                model.$onInit = function () {

                    var instance = model.parent.modalInstance;
                    model.cancel = function () {
                        instance.dismiss('cancel');
                    };

                    model.submit = function () {
                        console.log('you hit me!');
                        ControlPanelService.setMeasuringFlags(model.coordinator.identifier).then(
                            function (returnedData) {
                                defer.resolve(returnedData);
                                instance.close(returnedData);
                            }, function (errResponse) {
                                console.error('Error while sending request for starting measuring');
                            });
                    };

                    instance.result.then(function (returnedData) {
                        console.log('testModal Measure');
                    }, function () {
                        console.log('Modal dismissed at: ' + new Date());
                    });
                };
            }
        }
    );
}());
