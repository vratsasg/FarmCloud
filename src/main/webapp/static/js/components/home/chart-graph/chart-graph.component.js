(function () {
    "use-strict"

    var module = angular.module("myApp");

    module.component('chartGraph', {

        templateUrl: 'static/js/components/home/chart-graph/chart-graph.component.html',
        controllerAs: "model",
        bindings: {enddev: '<'},
        controller: function (chartService, $q) {

            var model = this;

            model.$onChanges = function (changesObj) {
                var newValue = changesObj.enddev.currentValue.identifier;

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
                                            //return d3.time.format('%H:%M')(new Date(moment(parseInt(d))));
                                            var returnvalue = new Date(moment(parseInt(d)));
                                            if (isNaN(returnvalue)) {
                                                return d3.time.format('%H:%M')(new Date(d));
                                            }
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
                                        chart.interactiveLayer.tooltip.gravity('');

                                        chart.interactiveLayer.tooltip.contentGenerator(function (d) {
                                            var html = "<div class='wtool col-sm-4'><p><b>" + d.value + "</b></p> <ul>";

                                            d.series.forEach(function (elem) {
                                                html += "<li><p><b>" + elem.key + ":" + elem.value + "</b></p></li>";
                                            })
                                            html += "</ul></div>"


                                            return html;
                                        })
                                        console.log("!!! lineChart callback !!!");
                                    }
                                },
                                title: {
                                    enable: true,
                                    text: 'Temperature in C'
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
                                    //useInteractiveGuideline: true,
                                    //dispatch: {
                                    //    stateChange: function (e) {
                                    //        console.log("stateChange");
                                    //    },
                                    //    changeState: function (e) {
                                    //        console.log("changeState");
                                    //    },
                                    //    tooltipShow: function (e) {
                                    //        console.log("tooltipShow");
                                    //    },
                                    //    tooltipHide: function (e) {
                                    //        console.log("tooltipHide");
                                    //    }
                                    //},
                                    xAxis: {
                                        axisLabel: 'Time (HH:MM)',
                                        tickFormat: function (d) {
                                            var returnvalue = new Date(moment(parseInt(d)));
                                            if (isNaN(returnvalue)) {
                                                return d3.time.format('%H:%M')(new Date(d));
                                            }
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
                                    useInteractiveGuideline: true,
                                    //interactive: true,
                                    //tooltips: true,
                                    //contentGenerator: function (d) {
                                    //    var header = d.value;
                                    //    var headerhtml = "<thead><tr><td colspan='3'><strong class='x-value'>" + header + "</strong></td></tr></thead>";
                                    //
                                    //    var bodyhtml = "<tbody>";
                                    //    var series = d.series;
                                    //    series.forEach(function (d) {
                                    //        bodyhtml = bodyhtml + "<tr><td class='legend-color-guide'><div style='background-color: " + d.color + ";'></div></td><td class='key'>" + d.key + "</td><td class='value'>" + d.value + "</td></tr>";
                                    //    });
                                    //    bodyhtml = bodyhtml + "</tbody>";
                                    //    return "<table>" + headerhtml + '' + bodyhtml + "</table>";
                                    //},
                                    callback: function (chart) {
                                        chart.interactiveLayer.tooltip.gravity('');

                                        chart.interactiveLayer.tooltip.contentGenerator(function (d) {
                                            var html = "<div class='wtool col-sm-4'><p><b>" + d.value + "</b></p> <ul>";

                                            d.series.forEach(function (elem) {
                                                html += "<li><p><b>" + elem.key + ":" + elem.value + "</b></p></li>";
                                            })
                                            html += "</ul></div>"


                                            return html;
                                        })
                                        console.log("!!! lineChart callback !!!");
                                    }
                                },
                                title: {
                                    enable: true,
                                    text: 'Humidity in RH%'
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
                            var sin = [], cos = [];
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
                                    color: '#558B2F',  //color - optional: choose your own line color.
                                    fill: 'none',
                                    opeacity: 0.0,
                                    strokeWidth: 2,
                                    classed: 'dashed'
                                },
                                {
                                    values: cos,
                                    key: model.datac[0].Temperatures[1].key,
                                    color: '#ff7f0e',
                                    fill: 'none',
                                    strokeWidth: 2,
                                    opeacity: 0
                                }
                            ];
                        };

                        function HumidiTy() {
                            var sin = [], cos = [];
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
                                    color: '#71843f',  //color - optional: choose your own line color.
                                    fill: 'none',
                                    opeacity: 0,
                                    strokeWidth: 2,
                                    classed: 'dashed'
                                },
                                {
                                    values: cos,
                                    key: model.datac[1].Humidities[1].key,
                                    color: '#ff7f0e',
                                    fill: 'none',
                                    opeacity: 0
                                }
                            ];
                        };


                    },
                    function (errResponse) {
                        console.error('Error while fetching chart devices');
                    });


                console.log("chargraph");
                console.log(newValue);
            };

            model.$onInit = function () {

            };
        }
    });
}());
