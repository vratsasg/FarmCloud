(function () {
    'use strict';
    var module = angular.module("myApp");

    module.component('topBar', {
        templateUrl: 'static/js/shared/topbar/top-bar-component.html',
        controllerAs: "model",
        controller: function () {
            var model = this;
            model.username = "";
            //components have lifecycles this is before the component is rendered
            model.$onInit = function () {
                model.username = "test user";
            }
        }
    });
}());


