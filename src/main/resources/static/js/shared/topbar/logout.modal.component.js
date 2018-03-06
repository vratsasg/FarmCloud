(function () {
    'use strict';
    var module = angular.module("myApp");

    module.component('logoutModal', {
            templateUrl: '/js/shared/topbar/logout.modal.component.html',
            replace: true,
            require: {
                parent: '^topBar'
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

                    }, function () {
                        console.log('Modal dismissed at: ' + new Date());
                    });

                };

            }
        }
    );
}());
