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
                getStationCoords: function (id) {
                    return $http.get('getStationCoords/' + id).then(
                        function (response) {
                            return response.data;
                        },
                        function (errResponse) {
                            console.error('Error while first page Service devices');
                            return $q.reject(errResponse);
                        }
                    );
                }
            }
        }]
    );

}());
