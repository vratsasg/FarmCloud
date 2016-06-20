(function () {
    'use strict';
    var module = angular.module("myApp");

    module.component('topBar', {
        templateUrl: 'static/js/shared/topbar/top-bar-component.html',
        controllerAs: "model",
        controller: function ($uibModal, $document) {
            var model = this;
            model.username = "";
            //components have lifecycles this is before the component is rendered
            model.$onInit = function () {
                model.username = "test user";


                model.showModal = function () {

                    console.log("show modal");

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


