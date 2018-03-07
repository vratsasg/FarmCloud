(function () {
    'use strict';
    var module = angular.module("myApp");

    module.component('measuringModal', {
            templateUrl: '/js/components/control-panel/measuring.modal.component.html',
            replace: true,
            require: {
                parent: '^controlPanel'
            },
            controllerAs: "model",
            controller: function (ControlPanelService, $q, toastr) {
                var model = this;
                var defer = $q.defer();
                var instance = null;

                model.$onInit = function () {

                    instance = model.parent.modalInstance;

                    instance.result.then(function (returnedData) {
                        console.log('testModal Measure');
                    }, function () {
                        console.log('Modal dismissed at: ' + new Date());
                    });
                }

                model.cancel = function () {
                    instance.dismiss('cancel');
                }

                model.submit = function () {
                    ControlPanelService.setMeasuringFlags(model.parent.coordinator.identifier).then(
                        function (returnedData) {
                            defer.resolve(returnedData);
                            instance.close(returnedData);
                            toastr.success("New measurement for all end devices has been set succesfully!","Success!");
                        }, function (errResponse) {
                            toastr.error(`Failed to set new measurement for all end devices with error: ${errResponse}`, 'Error!');
                            instance.close(errResponse);
                        });
                };
            }
        }
    );
}());
