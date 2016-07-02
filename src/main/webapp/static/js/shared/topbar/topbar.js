(function () {
    'use strict';
    var module = angular.module("myApp");

    module.component('topBar', {
        templateUrl: 'static/js/shared/topbar/top-bar-component.html',
        controllerAs: "model",
        controller: function ($uibModal, $document, userService, $q) {
            var model = this;
            model.user = {};

            //components have lifecycles this is before the component is rendered
            model.$onInit = function () {
                var defer = $q.defer();
                userService.getuser().then(
                    function (data) {

                        model.user = data;
                        defer.resolve(model.user);

                    }, function (errResponse) {
                        console.log("error fetching user");
                    });


                model.showModal = function () {
                    model.modalInstance = $uibModal.open({
                        animation: model.animationsEnabled,
                        template: '<logout-modal></logout-modal>',
                        appendTo: $document.find('top-bar')
                    });
                };

                model.toggleAnimation = function () {
                    model.animationsEnabled = !model.animationsEnabled;
                };

            }
        }
    });
}());


