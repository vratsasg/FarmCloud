(function () {
    "use strict";

    var module = angular.module('myApp');

    module.factory('ControlPanelService', ['$http', '$q', '$log', function ($http, $q, $log) {

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
            getLastMeasureDate: function () {
                return $http.get('getLastMeasureDate').then(
                    function (response) {
                        return response.data;
                    },
                    function (errResponse) {
                        console.error('Error while firstpageService devices');
                        return $q.reject(errResponse);
                    }
                );
            },
            getMeasuresByLastDate: function (identifier) {
                return $http.get('getLastMeasuresByDate?identifier=' + identifier).then(
                    function (response) {
                        return response.data;
                    },
                    function (errResponse) {
                        console.error('Error while firstpageService devices');
                        return $q.reject(errResponse);
                    }
                );
            },
            setMeasuringFlags: function () {
                return $http.get('takeMeasures').then(
                    function (response) {
                        return response.data;
                    },
                    function (errResponse) {
                        console.error('Error while send request for start measuring Service');
                        return $q.reject(errResponse);
                    }
                );
            }
        }

    }]);


}());
