(function () {
    'use strict';
    var module = angular.module("myApp");

    module.component('wateringProperty', {
        templateUrl: 'static/js/components/watering-property/watering-property.component.html',
        controllerAs: "model",
        controller: function (WateringPropertyService, $log, $q, ngTableParams, $filter, $scope, toastr) {
            var model = this;
            model.measures = "";

            model.updateMyDevice = function (myD) {
                var datefrom = moment(new Date(model.datefrom)).format("YYYY-MM-DD HH:mm:ss");
                var dateto = moment(new Date(model.dateto)).format("YYYY-MM-DD HH:mm:ss");
                var diff = moment(model.dateto).diff(moment(model.datefrom), 'days');

                model.tableParams = new ngTableParams({
                    counts: [],
                    page: 1,
                    count: 10
                    //paginationMaxBlocks: 5,
                    //paginationMinBlocks: 1
                }, {
                    getData: function (params) {
                        return getTableData(model.myDevice.identifier, params, datefrom, dateto);
                    }
                });
            };

            model.updateDateFrom = function (dfr) {
                var datefrom = moment(new Date(dfr)).format("YYYY-MM-DD HH:mm:ss");
                var dateto = moment(new Date(model.dateto)).format("YYYY-MM-DD HH:mm:ss");
                var diff = moment(model.dateto).diff(moment(model.datefrom), 'days');

                model.tableParams = new ngTableParams({
                    counts: [],
                    page: 1,
                    count: 10
                    //paginationMaxBlocks: 5,
                    //paginationMinBlocks: 1
                }, {
                    getData: function (params) {
                        return getTableData(model.myDevice.identifier, params, datefrom, dateto);
                    }
                });

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
                    getData: function (params) {
                        return getTableData(model.myDevice.identifier, params, datefrom, dateto);
                    }
                });
            };

            model.downloadFile = function (filetype) {
                var datefrom = moment(new Date(model.datefrom)).format("YYYY-MM-DD HH:mm:ss");
                var dateto = moment(new Date(model.dateto)).format("YYYY-MM-DD HH:mm:ss");
                switch (filetype) {
                    case 'pdf':
                        WateringPropertyService.getMeasuresPdf(model.myDevice.identifier, datefrom, dateto);
                        break;
                    case 'xls':
                        WateringPropertyService.getMeasuresXls(model.myDevice.identifier, datefrom, dateto);
                        break;
                    case 'csv':
                        WateringPropertyService.getMeasuresCsv(model.myDevice.identifier, datefrom, dateto);
                        break;
                    default:
                        console.error('Error trying to pass a wrong parameter inside function!!!');
                        break;
                }
            }


            model.$onInit = function () {
                var deferDev = $q.defer();
                model.datefrom = moment().subtract(1, 'days').format("YYYY-MM-DD HH:mm:ss");
                model.dateto = moment().format("YYYY-MM-DD HH:mm:ss");

                WateringPropertyService.getDevices().then(
                    function (da) {
                        model.devices = da;
                        deferDev.resolve(model.devices);
                        model.myDevice = model.devices[0];

                        model.tableParams = new ngTableParams({
                            counts: [],
                            page: 1,
                            count: 10
                            //paginationMaxBlocks: 5,
                            //paginationMinBlocks: 1
                        }, {
                            getData: function (params) {
                                return getTableData(model.myDevice.identifier, params, model.datefrom, model.dateto);
                            }
                        });


                    },
                    function (errResponse) {
                        console.error('Error while fetching devices for firstpage');
                    }
                );

            }

            function getTableTotalCount(devIdentifier, datefrom, dateto) {
                var defer = $q.defer();
                var totalLineCounter = WateringPropertyService.getTableTotalCount(devIdentifier, datefrom, dateto).then(
                    function (totalCount) {
                        return totalCount;
                    }
                )

                return totalLineCounter;
            }

            function getTableData(devIdentifier, params, datefrom, dateto) {
                var defer = $q.defer();
                var diff = moment(model.dateto).diff(moment(model.datefrom), 'days');

                var varApiGet = WateringPropertyService.getMeasuresByProperty(devIdentifier, datefrom, dateto).then(
                    function (apd) {
                        var theMeasures = apd;
                        model.measures = apd;

                        model.options =
                        {
                            chart: {
                                type: 'historicalBarChart',
                                showValues: true,
                                height: 370,
                                margin: {
                                    top: 20,
                                    right: 20,
                                    bottom: 40,
                                    left: 55
                                },
                                x: function (d) {
                                    var oo = new Date(moment(parseInt(d.x)));
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

                                        if (diff <= 3) {
                                            var returnvalue = new Date(moment(parseInt(d)));
                                            if (isNaN(returnvalue)) {
                                                return d3.time.format('%H:%M')(new Date(d));
                                            }
                                            return d3.time.format(' %H:%M')(new Date(moment(parseInt(d))));
                                        } else if (diff > 3 && diff <= 30) {
                                            var returnvalue = new Date(moment(parseInt(d)));
                                            if (isNaN(returnvalue)) {
                                                return d3.time.format('%a %b %e ')(new Date(d));
                                            }
                                            return d3.time.format('%a %b %e ')(new Date(moment(parseInt(d))));
                                        } else {
                                            if (isNaN(returnvalue)) {
                                                return d3.time.format('%b %e')(new Date(d));
                                            }
                                            return d3.time.format('%b %e')(new Date(moment(parseInt(d))));
                                        }


                                    }
                                },
                                yAxis: {
                                    //TODO change to dynamically
                                    axisLabel: 'Water Consumption',
                                    tickFormat: function (d) {
                                        return d3.format('.4')(d);
                                    },
                                    axisLabelDistance: -10
                                },
                                callback: function (chart) {
                                    // chart.interactiveLayertooltip.enabled();
                                    chart.interactiveLayer.tooltip.gravity('');

                                    chart.interactiveLayer.tooltip.contentGenerator(function (d) {
                                        var html = "<div class='wtool col-sm-6'><p><b>" + d.value + "</b></p> <ul>";

                                        d.series.forEach(function (elem) {
                                            html += "<li><p><b>" + elem.value + "</b></p></li>";
                                        })
                                        html += "</ul></div>"

                                        return html;
                                    })

                                    //console.log("!!! lineChart callback !!!");
                                }
                            },
                            zoom: {
                                enabled: true,
                                scaleExtent: [
                                    1,
                                    10
                                ],
                                useFixedDomain: false,
                                useNiceScale: false,
                                horizontalOff: false,
                                verticalOff: true,
                                unzoomEventType: "dblclick.zoom"
                            },
                            title: {
                                enable: true,
                                text: "Watering Consumption"
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
                            theMeasures.measuredata[i].phenomenonTimeStart = moment(parseInt(theMeasures.measuredata[i].phenomenonTimeStart)).format('DD/MM/YY HH:mm:ss');
                            theMeasures.measuredata[i].phenomenonTimeEnd = moment(parseInt(theMeasures.measuredata[i].phenomenonTimeEnd)).format('DD/MM/YY HH:mm:ss');
                        }

                        params.total(theMeasures.measuredata.length); // recal. page nav controls
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
                        x: (dataChart.measuredata[i].phenomenonTimeStart).toString(),
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

            model.beforeRenderStartDate = function ($view, $dates, $leftDate, $upDate, $rightDate) {
                if (model.dateto) {
                    var activeDate = moment(model.dateto);
                    for (var i = 0; i < $dates.length; i++) {
                        if ($dates[i].localDateValue() >= activeDate.valueOf()) {
                            $dates[i].selectable = false;
                        }
                    }
                }
            }

            model.beforeRenderEndDate = function ($view, $dates, $leftDate, $upDate, $rightDate) {
                if (model.datefrom) {
                    var activeDate = moment(model.datefrom).subtract(1, $view).add(1, 'minute');
                    var now = moment();
                    for (var i = 0; i < $dates.length; i++) {
                        if ($dates[i].localDateValue() <= activeDate.valueOf()) {
                            $dates[i].selectable = false;
                        }
                    }

                    for (var i = 0; i < $dates.length; i++) {
                        if ($dates[i].localDateValue() > now.valueOf()) {
                            $dates[i].selectable = false;
                        }
                    }
                }
            }

        }
    });
}());

