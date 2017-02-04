(function () {
    'use strict';
    var module = angular.module("myApp");
    module.component('leftBar', {

        templateUrl: 'static/js/shared/leftbar/left-bar-component.html',
        controllerAs: "model",
        controller: function (leftbarService, $log, $q) {
            //$('body').on("click", "#sidebarleft li", function () {
            //    $(this).parent().find('.active').removeClass('active');
            //    $(this).css("background-color", "");
            //    $(this).addClass('active');
            //});

            var model = this;
            model.observations = {};
            model.$onInit = function () {
                var defer = $q.defer();
                leftbarService.getObsproperties().then(
                    function (data) {

                        model.observations = data;
                        defer.resolve(model.observations);

                    }, function (errResponse) {
                        console.log("Error fetching obs");
                    }
                );
            }
        }
    });

}());








