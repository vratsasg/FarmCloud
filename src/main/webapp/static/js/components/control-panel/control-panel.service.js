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
            getWateringMeasuresByLastDate: function (identifier) {
                return $http.get('lastWateringMeasures?identifier=' + identifier).then(
                    function (response) {
                        return response.data;
                    },
                    function (errResponse) {
                        console.error('Error while firstpageService devices');
                        return $q.reject(errResponse);
                    }
                );
            },
            getCoordinatorData: function (identifier) {
                return $http.get('automaticwater/getdates?identifier=' + identifier).then(
                    function (response) {
                        return response.data;
                    },
                    function (errResponse) {
                        console.error('Error while getting coordinator data');
                        return $q.reject(errResponse);
                    }
                );
            },
            setAutomaticIrrigationTimes: function (coordData) {
                console.log(angular.toJson(coordData));
                return $http({
                    method: 'POST',
                    url: '/automaticwater/save',
                    data: angular.toJson(coordData),
                    headers: {'Content-Type': 'application/json'}
                }).then(function (response) {
                        console.log("Success!!!");
                    },
                    function (errResponse) {
                        console.error('Error while saving dates and cosnumption values for automatic water!');
                        return $q.reject(errResponse);
                    });
            },
            setFeatureDates: function (identifier, dtfrom, dtto) {
                return $http.post('setIrrigationDates?identifier=' + identifier + "&dtfrom=" + dtfrom + "&dtto=" + dtto).then(
                    function (response) {
                        return response;
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
