(function () {
    'use strict';

    var module = angular.module('myApp');


    module.factory('ProfileService', ['$http', '$q', '$log', function ($http, $q, $log) {

            return {
                getProfile: function () {
                    return $http.get('profile').then(
                        function (response) {
                            return response.data;
                        },
                        function (errResponse) {
                            console.error('Error while fetchingService profile');
                            return $q.reject(errResponse);
                        }
                    );
                },
                getStationCoords: function () {
                    return $http.get('coordinator/stationcoords').then(
                        function (response) {
                            return response.data;
                        },
                        function (errResponse) {
                            console.error('Error while firstpageService devices');
                            return $q.reject(errResponse);
                        }
                    );
                },
                saveProfile: function (profiledata) {
                    console.log(profiledata);
                    return $http({
                        method: 'POST',
                        url: 'myprofile/save',
                        data: profiledata,
                        headers: {'Content-Type': 'application/json'}
                    }).then(function (response) {
                            return (true);
                        },
                        function (errResponse) {
                            console.error('Error while saving minimum and maximum values for watering profile!');
                            return $q.reject(errResponse);
                        });
                }
            }
        }]
    );
}());