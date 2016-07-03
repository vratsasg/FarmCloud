(function () {
    'use strict';
    var module = angular.module("myApp");

    module.component('observableProperty', {
        templateUrl: 'static/js/components/observable-property/observable-property.component.html',
        controllerAs: "model",
        controller: function (ObservablePropertyService, $log, $q) {
            var model = this;


            model.$onInit = function () {

                model.$routerOnActivate = function (next) {

                    console.log(next);
                    model.id = next.params.id;


                    var defer = $q.defer();

                    ObservablePropertyService.getMeasuresByProperty(model.id).then(
                        function (d) {
                            console.log('Something in the way!');
                        },
                        function (errResponse) {
                            console.error('Error while fetching MeasuresByProperty!!!');
                        }
                    );


                };





            }
        }
    });
}());

