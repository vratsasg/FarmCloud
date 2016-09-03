(function () {
    'use strict';
    var module = angular.module('myApp');

    //{params:{"param1": val1, "param2": val2}})

    module.factory('ObservablePropertyService', ['$http', '$q', '$log', function ($http, $q, $log) {
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
                }, getMeasuresByProperty: function (id, mydevice, datefrom, dateto) {
                    return $http.get('getObspMeasures?id=' + id + '&mydevice=' + mydevice + '&dtstart=' + datefrom + '&dtend=' + dateto).then(
                        //"/search?fname="+fname"+"&lname="+lname
                        function (response) {
                            return response.data;
                        },
                        function (errResponse) {
                            console.error('Error while fetchingService ObsProp Measures!!!');
                            return $q.reject(errResponse);
                        }
                    );
                }, getMeasuresPdf: function (id, mydevice, datefrom, dateto) {
                    //return $http.get('extract/pdf?id=' + id + '&mydevice=' + mydevice + '&dtstart=' + datefrom + '&dtend=' + dateto);
                    $http({
                        url: 'extract/pdf?id=' + id + '&mydevice=' + mydevice + '&dtstart=' + datefrom + '&dtend=' + dateto,
                        method: 'POST',
                        params: {},
                        headers: {
                            'Content-type': 'application/pdf',
                        },
                        responseType: 'arraybuffer'
                    }).success(function (data, status, headers, config) {
                        // TODO when WS success
                        var file = new Blob([data], {
                            type: 'application/pdf'
                        });
                        //trick to download store a file having its URL
                        var fileURL = URL.createObjectURL(file);
                        var a = document.createElement('a');
                        a.href = fileURL;
                        a.target = '_blank';
                        a.download = 'measures.pdf';
                        document.body.appendChild(a);
                        a.click();
                    }).error(function (data, status, headers, config) {
                        //TODO when WS error
                        log.error('Error: ' + data);
                    });
                }

            }
        }]
    );

}());