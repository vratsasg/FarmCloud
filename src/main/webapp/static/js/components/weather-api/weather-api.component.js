(function () {

    'use strict';
    var module = angular.module("myApp");

    module.component('weatherApi', {
        templateUrl: 'static/js/components/weather-api/weather-api.component.html',
        controllerAs: "model",
        controller: function (WeatherApiService, $q) {
            var model = this;

            model.apirespond = {};

            model.longt = 23;
            model.latid = 37;
            var apiId = "2482652b83cd5ab077902e528b37ccd1";


            model.$onInit = function () {

                var deferDev = $q.defer();
                WeatherApiService.getCurrentWeather(model.longt, model.latid, apiId).then(
                    function (d) {
                        model.apirespond = d;

                        model.apirespond.main.temp = (model.apirespond.main.temp - 273.15).toFixed(2);
                        model.apirespond.dt = (new Date(moment(parseInt(model.apirespond.dt) * 1000))).toString();
                        model.apirespond.sys.sunrise = (new Date(moment(parseInt(model.apirespond.sys.sunrise) * 1000))).toString();
                        model.apirespond.sys.sunset = (new Date(moment(parseInt(model.apirespond.sys.sunset) * 1000))).toString();

                        deferDev.resolve(model.apirespond);
                    },
                    function (errResponse) {
                        console.error('Error while fetching current weather');
                    }
                );

            }


        }
    });


}());