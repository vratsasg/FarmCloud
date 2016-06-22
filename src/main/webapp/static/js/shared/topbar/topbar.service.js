(function () {
    'use strict';
    var module = angular.module("myApp");

    module.factory('userService', [
        '$http', '$q', '$log', function ($http, $q, $log) {

            return {
                getuser: function () {
                    return $http.get('topbaruser').then(
                        function (response) {
                            return response.data;
                        }, function (errResponse) {
                            console.error('Error while userService user');
                            return $q.reject(errResponse);
                        }
                    );
                }
            }
        }
    ]);
}());
