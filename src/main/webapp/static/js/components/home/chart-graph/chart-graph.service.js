(function () {

    "use strict";

    var module = angular.module('myApp');

    module.factory('chartService', ['$http', '$q', '$log', function ($http, $q, $log) {

        return {

            getDeviceChart: function (id) {

                return $http.get('charthome/' + id).then(
                    function (response) {
                        return response.data;
                    },
                    function (errResponse) {
                        console.error('Error while chartService devices');
                        return $q.reject(errResponse);
                    }
                );


            }


        }


    }]);


}());

