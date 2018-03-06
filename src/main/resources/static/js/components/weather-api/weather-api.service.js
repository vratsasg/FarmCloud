(function () {

    'use strict';
    var module = angular.module('myApp');


    module.factory('WeatherApiService', ['$http', '$q', '$log', function ($http, $q, $log) {
            return {
                getCurrentWeather: function (longt, latid, apiId) {
                    return $http.get('http://api.openweathermap.org/data/2.5/weather?lat=' + latid + '&lon=' + longt + '&appid=' + apiId).then(
                        function (response) {
                            return response.data;
                        },
                        function (errResponse) {
                            console.error('Error while current weather service');
                            return $q.reject(errResponse);
                        }
                    );
                },
                getStationCoords: function () {
                    return $http.get('station/coords').then(
                        function (response) {
                            return response.data;
                        },
                        function (errResponse) {
                            console.error('Error while firstpageService devices');
                            return $q.reject(errResponse);
                        }
                    );
                }

            }
        }]
    );

}());
