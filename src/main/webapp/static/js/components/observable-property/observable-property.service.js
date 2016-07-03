(function () {
    'use strict';
    var module = angular.module('myApp');

    module.factory('ObservablePropertyService', ['$http', '$q', '$log', function ($http, $q, $log) {
            return {
                getMeasuresByProperty: function (id) {
                    return $http.get('getObspMeasures/' + id).then(
                        function (response) {
                            return response.data;
                        },
                        function (errResponse) {
                            console.error('Error while fetchingService ObsProp Measures!!!');
                            return $q.reject(errResponse);
                        }
                    );
                }
            }
        }]
    );

}());