(function () {
    'use strict';
    var module = angular.module('myApp');

    //{params:{"param1": val1, "param2": val2}})

    module.factory('ObservablePropertyService', ['$http', '$q', '$log', function ($http, $q, $log) {
            return {
                getMeasuresByProperty: function (id, mydevice) {
                    return $http.get('getObspMeasures?id=' + id + '&mydevice=' + mydevice).then(
                        //"/search?fname="+fname"+"&lname="+lname
                        function (response) {
                            return response.data;
                        },
                        function (errResponse) {
                            console.error('Error while fetchingService ObsProp Measures!!!');
                            return $q.reject(errResponse);
                        }
                    );
                },
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
                }
            }
        }]
    );

}());