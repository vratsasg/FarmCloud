(function () {
    'use strict';
    var module = angular.module('myApp');

    module.factory('ObservablePropertyService', ['$http', '$q', '$log', function ($http, $q, $log) {
            return {
                getUserProfile: function () {
                    return $http.get('userprofile').then(
                        function (response) {
                            return response.data;
                        },
                        function (errResponse) {
                            console.error('Error while fetchingService user profile!!!');
                            return $q.reject(errResponse);
                        }
                    );
                }
            }
        }]
    );

}());