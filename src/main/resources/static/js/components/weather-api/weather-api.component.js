(function () {

    'use strict';
    var module = angular.module("myApp");

    module.component('weatherApi', {
        templateUrl: '/js/components/weather-api/weather-api.component.html',
        controllerAs: "model",
        controller: function (WeatherApiService, $q, toastr) {
            var model = this;

            model.apirespond = {};
            // Initialize api password
            var apiId = "2482652b83cd5ab077902e528b37ccd1";


            model.$onInit = function () {
                var deferDev = $q.defer();
                var def = $q.defer();

                WeatherApiService.getStationCoords().then(
                    function (d) {
                        console.log(d);
                        model.longt = d[0];
                        model.latid = d[1];

                        def.resolve(model.longt, model.latid);

                        WeatherApiService.getCurrentWeather(model.longt, model.latid, apiId).then(
                            function (ddat) {
                                model.apirespond = ddat;

                                deferDev.resolve(model.apirespond);

                                model.apirespond.main.temp = (model.apirespond.main.temp - 273.15).toFixed(2);
                                model.apirespond.dt = moment.unix(parseInt(model.apirespond.dt)).format("dddd DD/MM/YYYY HH:mm:ss");
                                //(new Date(moment(parseInt(model.apirespond.dt) * 1000))).toString();
                                model.apirespond.sys.sunrise = moment.unix(parseInt(model.apirespond.sys.sunrise)).format("dddd DD/MM/YYYY HH:mm:ss");
                                model.apirespond.sys.sunset = moment.unix(parseInt(model.apirespond.sys.sunset)).format("dddd DD/MM/YYYY HH:mm:ss");
                            },
                            function (errResponse) {
                                toastr.error(`Error while fetching weather data: ${errResponse}`, 'Error');
                            }
                        );
                    },
                    function (errResponse) {
                        toastr.error(`Error while fetching devices: ${errResponse}`, 'Error');
                    }
                );
            }
        }
    });


}());