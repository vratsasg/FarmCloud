(function () {
    'use strict';

    var module = angular.module("myApp");

    module.factory('leftbarService', ['$http', '$q', '$log', function ($http, $q, $log) {


        return {
            getObsproperties: function () {
                return $http.get('getobsproperties').then(
                    function (response) {
                        console.log('Test 1');
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
