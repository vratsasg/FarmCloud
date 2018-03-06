(function () {

    'use strict';
    var module = angular.module('myApp');


    module.factory('WeatherForecastService', ['$http', '$q', '$log', function ($http, $q, $log) {
            return {
                getForecastWeather: function (longt, latid, apiId) {
                    return $http.get('http://api.openweathermap.org/data/2.5/forecast?lat=' + latid + '&lon=' + longt + '&appid=' + apiId).then(
                        function (response) {
                            return response.data;
                        },
                        function (errResponse) {
                            console.error('Error while current weather service');
                            return $q.reject(errResponse);
                        }
                    );
                }
            }
        }]
    );

}());
