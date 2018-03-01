(function () {
    'use strict';
    var module = angular.module('myApp');

    module.factory('UserProfileService', ['$http', '$q', '$log', function ($http, $q, $log) {
            return {
                getUserProfile: function () {
                    return $http.get('user/profile').then(
                        function (response) {
                            return response.data;
                        },
                        function (errResponse) {
                            console.error('Error while fetchingService user profile!!!');
                            return $q.reject(errResponse);
                        }
                    );
                },
                saveUserProfile: function (userprofiledata) {
                    return $http.post('user/profile', userprofiledata).then(
                        function (response) {
                            return response.data;
                        },
                        function (errResponse) {
                            console.error('Error while saving user profile!!!');
                            return $q.reject(errResponse);
                        }
                    );
                }

            }
        }]
    );

}());