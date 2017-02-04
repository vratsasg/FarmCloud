(function () {
    'use strict';
    var module = angular.module('myApp');

    module.factory('WateringProfileService', ['$http', '$q', '$log', function ($http, $q, $log) {
            return {
                getMinMaxValues: function () {
                    return $http.get('wateringprofile/minmax').then(
                        function (response) {
                            return response.data;
                        },
                        function (errResponse) {
                            console.error('Error while fetchingService user profile!!!');
                            return $q.reject(errResponse);
                        }
                    );
                }
                , saveWateringProfile: function (wateringprofiledata) {
                    console.log(angular.toJson(wateringprofiledata));
                    return $http({
                        method: 'POST',
                        url: 'wateringprofile/saveminmax',
                        data: angular.toJson(wateringprofiledata),
                        headers: {'Content-Type': 'application/json'}
                    }).then(function (response) {
                            return true;
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