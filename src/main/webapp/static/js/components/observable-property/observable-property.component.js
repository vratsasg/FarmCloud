(function () {
    'use strict';
    var module = angular.module("myApp");

    module.component('observableProperty', {
        templateUrl: 'static/js/components/observable-property/observable-property.component.html',
        controllerAs: "model",
        controller: function (ObservablePropertyService, $log, $q) {
            var model = this;
            model.data = {};

            model.$onInit = function () {
                var defer = $q.defer();

                ObservablePropertyService.getUserProfile().then(
                    function (d) {
                        console.log('Something in the way!');
                    },
                    function (errResponse) {
                        console.error('Error while fetching user profile!!!');
                    }
                );


            }
        }
    });
}());

