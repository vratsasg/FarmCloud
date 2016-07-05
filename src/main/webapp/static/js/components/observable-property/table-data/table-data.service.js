(function () {

    "use-strict"

    var module = angular.module('myApp');


    module.factory('TableDataService', ['$http', '$q', '$log', function ($http, $q, $log) {

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
            }
        };
    }]);
}());
