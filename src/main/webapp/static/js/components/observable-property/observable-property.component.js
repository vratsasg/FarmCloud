(function () {
    'use strict';
    var module = angular.module("myApp");

    module.component('observableProperty', {
        templateUrl: 'static/js/components/observable-property/observable-property.component.html',
        controllerAs: "model",
        controller: function (ObservablePropertyService, $log, $q, ngTableParams, $filter, $scope) {
            var model = this;


            model.$routerOnActivate = function (next) {
                console.log(next);
                model.id = next.params.id;
                var StrDescr = next.params.description;
                model.descr = StrDescr.replace(/%20/g, " ");

            };


            model.measures = "";
            model.total = 20;


            model.updateMyDevice = function (myD) {

                var datefrom = moment(new Date(model.datefrom)).format("YYYY-MM-DD HH:mm:ss");
                var dateto = moment(new Date(model.dateto)).format("YYYY-MM-DD HH:mm:ss");


                console.log("MYDEVICE")
                console.log(myD);
                model.tableParams = new ngTableParams({
                    counts: [],
                    page: 1,
                    count: 10
                    //paginationMaxBlocks: 5,
                    //paginationMinBlocks: 1
                }, {
                    total: model.total,
                    getData: function (params) {

                        return TableData(model.myDevice, params, datefrom, dateto);
                    }
                });


            };


            model.updateDateFrom = function (dfr) {


                var datefrom = moment(new Date(dfr)).format("YYYY-MM-DD HH:mm:ss");
                var dateto = moment(new Date(model.dateto)).format("YYYY-MM-DD HH:mm:ss");

                model.tableParams = new ngTableParams({
                    counts: [],
                    page: 1,
                    count: 10
                    //paginationMaxBlocks: 5,
                    //paginationMinBlocks: 1
                }, {
                    total: model.total,
                    getData: function (params) {

                        return TableData(model.myDevice, params, datefrom, dateto);
                    }
                });

                console.log(dfr);


            }


            model.updateDateTo = function (dto) {

                var datefrom = moment(new Date(model.datefrom)).format("YYYY-MM-DD HH:mm:ss");
                var dateto = moment(new Date(dto)).format("YYYY-MM-DD HH:mm:ss");

                model.tableParams = new ngTableParams({
                    counts: [],
                    page: 1,
                    count: 10
                    //paginationMaxBlocks: 5,
                    //paginationMinBlocks: 1
                }, {
                    total: model.total,
                    getData: function (params) {

                        return TableData(model.myDevice, params, datefrom, dateto);
                    }
                });

                console.log(dto);


            }






            model.$onInit = function () {
                var deferDev = $q.defer();
                //var datefrom = moment("2015-05-21 00:00:00", "YYYY-MM-DD HH:mm:ss");
                //var dateto = moment("2015-05-21 23:59:59", "YYYY-MM-DD HH:mm:ss");

                var datefrom = moment(new Date("2015-05-21 00:00:00")).format("YYYY-MM-DD HH:mm:ss");
                var dateto = moment(new Date("2015-05-21 23:59:59")).format("YYYY-MM-DD HH:mm:ss");

                model.datefrom = datefrom;
                model.dateto = dateto;



                ObservablePropertyService.getDevices().then(
                    function (da) {
                        model.devices = da;
                        deferDev.resolve(model.devices);
                        model.myDevice = model.devices.enddevices[0].identifier;

                        model.tableParams = new ngTableParams({
                            counts: [],
                            page: 1,
                            count: 10
                            //paginationMaxBlocks: 5,
                            //paginationMinBlocks: 1
                        }, {
                            total: model.total,
                            getData: function (params) {

                                return TableData(model.myDevice, params, datefrom, dateto);
                            }
                        });
                    },
                    function (errResponse) {
                        console.error('Error while fetching devices for firstpage');
                    }
                );

            }


            function TableData(devIdentifier, params, datefrom, dateto) {
                var defer = $q.defer();

                var varApiGet = ObservablePropertyService.getMeasuresByProperty(model.id, devIdentifier, datefrom, dateto).then(
                    function (d) {
                        var theMeasures = d;
                        model.measures = d;
                        model.total = theMeasures.measuredata.length; // set total for recalc pagination


                        for (var i = 0; i < theMeasures.measuredata.length; i++) {

                            theMeasures.measuredata[i].phenomenonTime = moment(parseInt(theMeasures.measuredata[i].phenomenonTime) * 1000).format('DD/MM/YYYY HH:mm:ss');
                        }

                        theMeasures.measuredata = theMeasures.measuredata.slice((params.page() - 1) * params.count(), params.page() * params.count());

                        defer.resolve($filter('orderBy')(theMeasures.measuredata, params.orderBy()));
                        return $filter('orderBy')(theMeasures.measuredata, params.orderBy());


                    },
                    function (errResponse) {
                        console.error('Error while fetching MeasuresByProperty!!!');
                    }
                );
                return varApiGet;


            }



        }
    });
}());

