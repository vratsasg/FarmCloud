(function () {
    'use strict';
    var module = angular.module("myApp");

    module.component('irrigationModal', {
            templateUrl: 'static/js/components/control-panel/irrigation.modal.component.html',
            replace: true,
            require: {
                parent: '^controlPanel'
            },
            controllerAs: "model",
            controller: function () {
                var model = this;

                model.$onInit = function () {

                    var instance = model.parent.modalInstance;
                    model.cancel = function () {
                        instance.dismiss('cancel');
                    };
                    instance.result.then(function () {
                        console.log('test');
                    }, function () {
                        console.log('Modal dismissed at: ' + new Date());
                    });
                };
            }
        }
    );
}());
