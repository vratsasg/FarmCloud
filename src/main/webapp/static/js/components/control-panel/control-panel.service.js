(function () {
    "use strict";

    var module = angular.module('myApp');

    module.factory('ControlPanelService', ['$http', '$q', '$log', function ($http, $q, $log) {

        return {

            getDevices: function () {
                return $http.get('enddevices').then(
                    function (response) {
                        return response.data;
                    },
                    function (errResponse) {
                        console.error('Error while firstpageService devices');
                        return $q.reject(errResponse);
                    }
                );
            },
            //
            getLastMeasureDate: function () {
                return $http.get('measures/lastdate').then(
                    function (response) {
                        return response.data;
                    },
                    function (errResponse) {
                        console.error('Error while firstpageService devices');
                        return $q.reject(errResponse);
                    }
                );
            },
            //
            getMeasuresByLastDate: function (identifier) {
                return $http.get(identifier + '/measures/last').then(
                    function (response) {
                        return response.data;
                    },
                    function (errResponse) {
                        console.error('Error while firstpageService devices');
                        return $q.reject(errResponse);
                    }
                );
            },
            //
            getWateringMeasuresByLastDate: function (identifier) {
                return $http.get(identifier + '/watering/last').then(
                    function (response) {
                        return response.data;
                    },
                    function (errResponse) {
                        console.error('Error while firstpageService devices');
                        return $q.reject(errResponse);
                    }
                );
            },
            //
            getCoordinatorData: function (identifier) {
                //TODO {coordinator}/automaticwater/dates
                return $http.get(identifier + '/automaticwater/dates').then(
                    function (response) {
                        return response.data;
                    },
                    function (errResponse) {
                        console.error('Error while getting coordinator data');
                        return $q.reject(errResponse);
                    }
                );
            },
            setMeasuringFlags: function (coordinator) {
                return $http.get('embedded/' + coordinator + '/measures').then(
                    function (response) {
                        return response.data;
                    },
                    function (errResponse) {
                        console.error('Error while send request for start measuring Service');
                        return $q.reject(errResponse);
                    }
                );
            },
            setAutomaticIrrigationTimes: function (coordData) {
                console.log(angular.toJson(coordData));
                return $http({
                    method: 'POST',
                    url: 'embedded/irrigation',
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
                return $http.post(identifier + '/irrigation/times?dtfrom=' + dtfrom + '&dtto=' + dtto).then(
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
