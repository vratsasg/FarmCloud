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
                }
            }
        }]
    );
}());