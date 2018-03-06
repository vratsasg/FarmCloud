(function () {
    'use strict';

    var module = angular.module("myApp");

    module.factory('leftbarService', ['$http', '$q', '$log', function ($http, $q, $log) {


        return {
            getObsproperties: function () {
                return $http.get('observableproperties').then(
                    function (response) {
                        return response.data;
                    },
                    function (errResponse) {
                        console.error('Error while fetchingService obs properties');
                        return $q.reject(errResponse);
                    }
                );
            }
        }
    }]);
}());
