(function () {

    'use strict';
    var module = angular.module("myApp");

    module.component('weatherChart', {
        templateUrl: 'static/js/components/weather-api/weather-chart/weather-chart.component.html',
        controllerAs: "model",
        bindings: {latit: '<', longti: '<'},
        controller: function (WeatherForecastService, $q) {
            var model = this;

            model.forecastData = {};
            model.clickDates = [];
            model.unixDates = [];
            model.tableData = [];

            var apiId = "2482652b83cd5ab077902e528b37ccd1";

            model.$onChanges = function (changesObj) {
                var newlongt = changesObj.longti.currentValue;
                var newlatid = changesObj.latit.currentValue;

                var defer = $q.defer();

                WeatherForecastService.getForecastWeather(newlongt, newlatid, apiId).then(
                    function (ddata) {
                        model.forecastData = ddata;

                        defer.resolve(model.forecastData);

                        for (var l = 0; l < model.forecastData.list.length; l++) {
                            if (l == 0 || ( l % 8 == 0 && l > 7)) {
                                model.clickDates.push(moment.unix(parseInt(model.forecastData.list[l].dt)).format("dddd DD/MM/YYYY"));
                                model.unixDates.push(parseInt(model.forecastData.list[l].dt));
                            }
                        }

                        var Ch = moment.unix(parseInt(model.unixDates[0])).format("DD/MM/YYYY");
                        for (var g = 0; g < model.forecastData.list.length; g++) {
                            var Chk = moment.unix(parseInt(model.forecastData.list[g].dt)).format("DD/MM/YYYY");

                            if (Ch === Chk) {
                                model.tableData.push(
                                    {
                                        temp: (model.forecastData.list[g].main.temp - 273.15).toFixed(2),
                                        humidity: model.forecastData.list[g].main.humidity,
                                        datime: model.forecastData.list[g].dt_txt,
                                        weathermain: model.forecastData.list[g].weather[0].main,
                                        wicon: model.forecastData.list[g].weather[0].icon
                                    }
                                );
                            }
                        }


                        //for (var v = 0; v < model.forecastData.list.length; v++) {
                        //    var chUnix = new Date(moment(parseInt(model.unixDates[0] * 1000)));
                        //    var chUnixWeat = new Date(moment(parseInt(model.forecastData.list[v].dt) * 1000));
                        //    if (chUnix.getDate() === chUnixWeat.getDate()) {
                        //
                        //        model.tableData.push({
                        //            temp: model.forecastData.list[v].main.temp,
                        //            humidity: model.forecastData.list[v].main.humidity,
                        //            DateTime:model.forecastData.list[v].main.dt_txt
                        //        });
                        //    }
                        //}

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
                                text: 'Temperature in C'
                            },
                            subtitle: {
                                enable: true,
                                text: '5 day / 3 hour forecast',
                                css: {
                                    'text-align': 'center',
                                    'margin': '10px 13px 0px 7px'
                                }
                            }
                        };


                        model.data = fillData();

                        function fillData() {
                            var sin = [];
                            for (var i = 0; i < model.forecastData.list.length; i++) {
                                sin.push({
                                    x: (model.forecastData.list[i].dt).toString(),
                                    y: parseFloat((model.forecastData.list[i].main.temp - 273.15).toFixed(2))
                                });
                            }

                            //Line chart data should be sent as an array of series objects.
                            return [
                                {
                                    values: sin,      //values - represents the array of {x,y} data points
                                    key: "Temperature", //key  - the name of the series.
                                    color: '#ff7f0e',  //color - optional: choose your own line color.
                                    strokeWidth: 2,
                                    classed: 'dashed'
                                }
                            ];
                        }
                    },
                    function (errResponse) {
                        console.error('Error while fetching current weather');
                    }
                );


            };


            model.showData = function (parm) {

                model.tableData = [];

                var Ch = moment.unix(parseInt(parm)).format("DD/MM/YYYY");
                for (var g = 0; g < model.forecastData.list.length; g++) {
                    var Chk = moment.unix(parseInt(model.forecastData.list[g].dt)).format("DD/MM/YYYY");

                    if (Ch === Chk) {
                        model.tableData.push(
                            {
                                temp: (model.forecastData.list[g].main.temp - 273.15).toFixed(2),
                                humidity: model.forecastData.list[g].main.humidity,
                                datime: model.forecastData.list[g].dt_txt,
                                weathermain: model.forecastData.list[g].weather[0].main,
                                wicon: model.forecastData.list[g].weather[0].icon
                            }
                        );

                    }

                }


            }

            model.$onInit = function () {


            };


        }
    });
}());