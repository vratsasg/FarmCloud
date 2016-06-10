/**
 * Created by George on 5/6/2016.
 */

'use strict';

App.factory('CropService', ['$http', '$q','$log', function ($http, $q,$log,$location) {

    return {

        addcrop: function (crop) {
            $log.info("service createCrop");
            return $http.post('home' , crop).then(
                function (response) {
                    return response.data;
                },
                function (errResponse) {
                    console.error('Error while creating user');
                    return $q.reject(errResponse);
                }
            );

        }


    };


}]);
