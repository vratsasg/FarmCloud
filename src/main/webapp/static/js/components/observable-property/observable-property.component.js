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
                    function (apd) {
                        var theMeasures = apd;
                        model.measures = apd;
                        model.total = theMeasures.measuredata.length; // set total for recalc pagination


                        model.options =
                        {
                            chart: {
                                type: 'lineChart',
                                height: 370,
                                margin: {
                                    top: 20,
                                    right: 20,
                                    bottom: 40,
                                    left: 55
                                },
                                x: function (d) {
                                    var oo = new Date(moment(parseInt(d.x) * 1000));
                                    return oo;
                                },
                                y: function (d) {
                                    return d.y;
                                },
                                useInteractiveGuideline: true,
                                dispatch: {
                                    stateChange: function (e) {
                                        console.log("stateChange");
                                    },
                                    changeState: function (e) {
                                        console.log("changeState");
                                    },
                                    tooltipShow: function (e) {
                                        console.log("tooltipShow");
                                    },
                                    tooltipHide: function (e) {
                                        console.log("tooltipHide");
                                    }
                                },
                                xAxis: {
                                    axisLabel: 'Time (MM/DD HH:MM)',
                                    tickFormat: function (d) {

                                        var returnvalue = new Date(moment(parseInt(d)));
                                        if (isNaN(returnvalue)) {
                                            return d3.time.format('%a %b %e %H:%M')(new Date(d));
                                        }
                                        return d3.time.format('%a %b %e %H:%M')(new Date(moment(parseInt(d))));
                                    }
                                },
                                yAxis: {
                                    axisLabel: 'Temperature',
                                    tickFormat: function (d) {
                                        return d3.format('.4')(d);
                                    },
                                    axisLabelDistance: -10
                                },
                                callback: function (chart) {
                                    // chart.interactiveLayertooltip.enabled();
                                    chart.interactiveLayer.tooltip.gravity('');

                                    chart.interactiveLayer.tooltip.contentGenerator(function (d) {
                                        var html = "<div class='wtool col-sm-2'><p><b>" + d.value + "</b></p> <ul>";

                                        d.series.forEach(function (elem) {
                                            html += "<li><p><b>" + elem.value + "</b></p></li>";
                                        })
                                        html += "</ul></div>"

                                        return html;
                                    })

                                    console.log("!!! lineChart callback !!!");
                                }
                            },
                            title: {
                                enable: true,
                                text: model.measures.observableProperty
                            }
                            //subtitle: {
                            //    enable: true,
                            //    text: '5 day / 3 hour forecast',
                            //    css: {
                            //        'text-align': 'center',
                            //        'margin': '10px 13px 0px 7px'
                            //    }
                            //}
                        };


                        model.data = fillData(model.measures);

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


            function fillData(dataChart) {
                var sin = [];
                for (var i = 0; i < dataChart.measuredata.length; i++) {
                    sin.push({
                        x: (dataChart.measuredata[i].phenomenonTime).toString(),
                        y: parseFloat(dataChart.measuredata[i].value)
                    });
                }

                //Line chart data should be sent as an array of series objects.
                return [
                    {
                        values: sin,      //values - represents the array of {x,y} data points
                        key: dataChart.observableProperty, //key  - the name of the series.
                        color: '#ff7f0e',  //color - optional: choose your own line color.
                        strokeWidth: 2,
                        classed: 'dashed'
                    }
                ];
            }







        }
    });
}());

