(function () {
    "use-strict"

    var module = angular.module("myApp");

    module.component('chartGraph', {

        templateUrl: 'static/js/components/home/chart-graph/chart-graph.component.html',
        controllerAs: "model",
        bindings: {enddev: '<'},
        controller: function (chartService, $q, $scope) {

            var model = this;


            model.$onInit = function () {
                var BindingDeReg = $scope.$watch('model.enddev', function (newValue) {


                    var defer = $q.defer();
                    chartService.getDeviceChart(newValue).then(
                        function (serverdata) {
                            model.datac = serverdata;
                            defer.resolve(model.datac);
                            console.log(serverdata);


                            model.Alloptions = [
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
                                            var dt = new Date(moment(parseInt(d.x) * 1000));
                                            return dt;
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
                                            axisLabel: 'Time (HH:MM)',
                                            tickFormat: function (d) {
                                                return d3.time.format('%H:%M')(new Date(moment(parseInt(d))));
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
                                            console.log("!!! lineChart callback !!!");
                                        }
                                    },
                                    title: {
                                        enable: true,
                                        text: 'Temperature'
                                    }
                                    //subtitle: {
                                    //    enable: true,
                                    //    text: 'Subtitle for simple line chart. Lorem ipsum dolor sit amet, at eam blandit sadipscing, vim adhuc sanctus disputando ex, cu usu affert alienum urbanitas.',
                                    //    css: {
                                    //        'text-align': 'center',
                                    //        'margin': '10px 13px 0px 7px'
                                    //    }
                                    //},
                                    //caption: {
                                    //    enable: true,
                                    //    html: '<b>Figure 1.</b>',
                                    //    css: {
                                    //        'text-align': 'justify',
                                    //        'margin': '10px 13px 0px 7px'
                                    //    }
                                    //}
                                }, {
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
                                            var dt = new Date(moment(parseInt(d.x) * 1000));
                                            return dt;
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
                                            axisLabel: 'Time (HH:MM)',
                                            tickFormat: function (d) {
                                                return d3.time.format('%H:%M')(new Date(moment(parseInt(d))));
                                            }
                                        },
                                        yAxis: {
                                            axisLabel: 'Humidity',
                                            tickFormat: function (d) {
                                                return d3.format('.4')(d);
                                            },
                                            axisLabelDistance: -10
                                        },
                                        callback: function (chart) {
                                            console.log("!!! lineChart callback !!!");
                                        }
                                    },
                                    title: {
                                        enable: true,
                                        text: 'Humidity'
                                    }
                                    //subtitle: {
                                    //    enable: true,
                                    //    text: 'Subtitle for simple line chart. Lorem ipsum dolor sit amet, at eam blandit sadipscing, vim adhuc sanctus disputando ex, cu usu affert alienum urbanitas.',
                                    //    css: {
                                    //        'text-align': 'center',
                                    //        'margin': '10px 13px 0px 7px'
                                    //    }
                                    //},
                                    //caption: {
                                    //    enable: true,
                                    //    html: '<b>Figure 1.</b>',
                                    //    css: {
                                    //        'text-align': 'justify',
                                    //        'margin': '10px 13px 0px 7px'
                                    //    }
                                    //}
                                }];

                            model.dataset = {
                                data1: TemperaT(),
                                data2: HumidiTy()
                            };


                            function TemperaT() {
                                var sin = [], sin2 = [], cos = [];
                                for (var i = 0; i < model.datac[0].Temperatures[0].values.length; i++) {
                                    sin.push({
                                        x: model.datac[0].Temperatures[0].values[i][0],
                                        y: parseFloat(model.datac[0].Temperatures[0].values[i][1])
                                    });
                                }

                                for (var i = 0; i < model.datac[0].Temperatures[1].values.length; i++) {
                                    cos.push({
                                        x: model.datac[0].Temperatures[1].values[i][0],
                                        y: parseFloat(model.datac[0].Temperatures[1].values[i][1])
                                    });
                                }


                                //Line chart data should be sent as an array of series objects.
                                return [
                                    {
                                        values: sin,      //values - represents the array of {x,y} data points
                                        key: model.datac[0].Temperatures[0].key, //key  - the name of the series.
                                        color: '#ff7f0e',  //color - optional: choose your own line color.
                                        strokeWidth: 2,
                                        classed: 'dashed'
                                    },
                                    {
                                        values: cos,
                                        key: model.datac[0].Temperatures[1].key,
                                        color: '#2ca02c'
                                    }
                                ];
                            };

                            function HumidiTy() {
                                var sin = [], sin2 = [], cos = [];
                                for (var i = 0; i < model.datac[1].Humidities[0].values.length; i++) {
                                    sin.push({
                                        x: model.datac[1].Humidities[0].values[i][0],
                                        y: parseFloat(model.datac[1].Humidities[0].values[i][1])
                                    });
                                }

                                for (var i = 0; i < model.datac[1].Humidities[1].values.length; i++) {
                                    cos.push({
                                        x: model.datac[1].Humidities[1].values[i][0],
                                        y: parseFloat(model.datac[1].Humidities[1].values[i][1])
                                    });
                                }


                                //Line chart data should be sent as an array of series objects.
                                return [
                                    {
                                        values: sin,      //values - represents the array of {x,y} data points
                                        key: model.datac[1].Humidities[0].key, //key  - the name of the series.
                                        color: '#ff7f0e',  //color - optional: choose your own line color.
                                        strokeWidth: 2,
                                        classed: 'dashed'
                                    },
                                    {
                                        values: cos,
                                        key: model.datac[1].Humidities[1].key,
                                        color: '#2ca02c'
                                    }
                                ];
                            };


                        },
                        function (errResponse) {
                            console.error('Error while fetching chart devices');
                        });


                    console.log("chargraph");
                    console.log(newValue);
                });
            };
        }
    });
}());


/*[{
 "Temperatures": [{
 "values": [
 ["1432180800", "17.00"],
 ["1432188000", "20.00"],
 ["1432191600", "23.00"],
 ["1432198800", "28.00"],
 ["1432202400", "30.00"],
 ["1432209600", "32.00"],
 ["1432216800", "32.00"],
 ["1432224000", "30.00"],
 ["1432224900", "30.20"],
 ["1432225500", "30.10"],
 ["1432226100", "30.00"],
 ["1432227000", "29.00"],
 ["1432227900", "27.00"],
 ["1432228800", "26.00"],
 ["1432229700", "26.00"],
 ["1432230600", "25.50"],
 ["1432231500", "23.00"],
 ["1432232400", "20.00"],
 ["1432240200", "16.00"]
 ],
 "key": "Temperature"
 }, {
 "values": [
 ["1432180800", "25.00"],
 ["1432188000", "26.00"],
 ["1432191600", "27.00"],
 ["1432198800", "28.00"],
 ["1432202400", "30.00"],
 ["1432209600", "32.00"],
 ["1432216800", "35.00"],
 ["1432224000", "40.00"],
 ["1432224900", "41.00"],
 ["1432225500", "40.00"],
 ["1432226100", "38.00"],
 ["1432227000", "37.00"],
 ["1432227900", "36.00"],
 ["1432228800", "32.00"],
 ["1432229700", "30.00"],
 ["1432230600", "25.00"],
 ["1432231500", "20.00"],
 ["1432232400", "19.00"],
 ["1432240200", "16.00"]
 ],
 "key": "Internal Temperature"
 }]
 }, {
 "Humidities": [{
 "values": [
 ["1432180800", "70.00"],
 ["1432188000", "69.00"],
 ["1432191600", "67.00"],
 ["1432198800", "65.00"],
 ["1432202400", "65.00"],
 ["1432209600", "50.00"],
 ["1432216800", "40.00"],
 ["1432224000", "35.00"],
 ["1432224900", "36.00"],
 ["1432225500", "39.00"],
 ["1432226100", "40.00"],
 ["1432227000", "45.00"],
 ["1432227900", "50.00"],
 ["1432228800", "55.00"],
 ["1432229700", "55.00"],
 ["1432230600", "53.00"],
 ["1432231500", "52.00"],
 ["1432232400", "51.00"],
 ["1432240200", "50.00"]
 ],
 "key": "Soil Moisture"
 }, {
 "values": [
 ["1432180800", "60.00"],
 ["1432188000", "59.00"],
 ["1432191600", "55.00"],
 ["1432198800", "52.00"],
 ["1432202400", "33.00"],
 ["1432209600", "30.00"],
 ["1432216800", "28.00"],
 ["1432224000", "27.00"],
 ["1432224900", "35.00"],
 ["1432225500", "37.00"],
 ["1432226100", "36.00"],
 ["1432227000", "70.00"],
 ["1432227900", "60.00"],
 ["1432228800", "55.00"],
 ["1432229700", "57.00"],
 ["1432230600", "52.00"],
 ["1432231500", "60.00"],
 ["1432232400", "61.00"],
 ["1432240200", "62.00"]
 ],
 "key": "Internal Humidity"
 }]
 }]*/