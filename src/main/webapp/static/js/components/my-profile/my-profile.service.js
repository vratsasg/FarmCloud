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

                saveProfile: function (profiledata) {
                    console.log(angular.toJson(profiledata));
                    return $http({
                        method: 'POST',
                        url: 'saveprofile',
                        data: angular.toJson(profiledata),
                        headers: {'Content-Type': 'application/json'}
                    }).then(function (response) {
                            console.log("Success!!!");
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