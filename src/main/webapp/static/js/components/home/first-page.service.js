(function () {

    "use strict";

    var module = angular.module('myApp');

    module.factory('firstPageDevices', ['$http', '$q', '$log', function ($http, $q, $log) {

        return {
            getDevices: function () {
                return $http.get('firstPDev').then(
                    function (response) {
                        return response.data;
                    },
                    function (errResponse) {
                        console.error('Error while firstpageService devices');
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
                        console.error('Error while firstpageService devices');
                        return $q.reject(errResponse);
                    }
                );        
            }
        }

    }]);


}());
