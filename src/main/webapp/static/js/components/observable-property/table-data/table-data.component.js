(function () {
    'use strict';
    var module = angular.module("myApp");

    module.component('tableData', {
        templateUrl: 'static/js/components/observable-property/table-data/table-data.component.html',
        controllerAs: "model",
        bindings: {enddevice: "<", dtfrom: "<", dtto: "<"},
        require: {
            parent: '^observableProperty'
        },
        controller: function (TableDataService, $q, ngTableParams, $filter, $scope) {
            var model = this;

            model.total = 20; //TODO get count of measures from parrent component
            model.measures = {measuredata: [{phenomenonTime: "", value: ""}]};

            var groupBindingScope = $scope.$watchGroup(['model.enddevice', 'model.dtfrom', 'model.dtto'], function (newValues, oldValues, scope) {

                var newValue;
                if (newValues[0] != oldValues[0]) {
                    newValue = newValues[0];
                    model.identifier = newValue;
                } else {
                    newValue = oldValues[0];
                    model.identifier = newValue;
                }

                var tmp_datefrom;
                if (newValues[1] != oldValues[1]) {
                    tmp_datefrom = newValues[1];
                    model.datetimefrom = tmp_datefrom;
                } else {
                    tmp_datefrom = oldValues[1];
                    model.datetimefrom = tmp_datefrom;
                }

                var tmp_dateto;
                if (newValues[2] != oldValues[2]) {
                    tmp_dateto = oldValues[2];
                    model.datetimeto = tmp_dateto;
                } else {
                    tmp_dateto = oldValues[2];
                    model.datetimeto = tmp_dateto;
                }

                var defer = $q.defer();

                model.tableParams = new ngTableParams({
                    counts: [],
                    page: 1,
                    count: 10
                    //paginationMaxBlocks: 5,
                    //paginationMinBlocks: 1
                }, {
                    total: model.total,
                    getData: function (params) {

                        var datefrom = moment("2015-05-21 00:00:00", "YYYY-MM-DD HH:mm:ss");
                        var dateto = moment("2015-05-21 23:59:59", "YYYY-MM-DD HH:mm:ss");

                        var varApiGet = TableDataService.getMeasuresByProperty(model.parent.id, model.identifier, datefrom.format("YYYY-MM-DD HH:mm:ss"), dateto.format("YYYY-MM-DD HH:mm:ss")).then(
                            function (d) {
                                var theMeasures = d;
                                model.measures = d;
                                model.total = theMeasures.measuredata.length; // set total for recalc pagination

                                //this.cols = [
                                //    { field: "phenomenonTime", title: "phenomenonTime", filter: { name: "date" }, show: true },
                                //    { field: "value", title: "Measure value", filter: { name: "value" }, show: true }];

                                for (var i = 0; i < theMeasures.measuredata.length; i++) {
                                    //theMeasures.measuredata[i].phenomenonTime = (new Date(moment(parseInt(theMeasures.measuredata[i].phenomenonTime) * 1000))).toString();
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
                });
            });

            model.$onInit = function () {

            };
        }
    });


}());

/*
 ////Create chart graphs
 model.chartoptions =
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
 text: model.measures.observableProperty + ' in ' + model.measures.unit
 },
 subtitle: {
 enable: true,
 text: model.measures.observableProperty,
 css: {
 'text-align': 'center',
 'margin': '10px 13px 0px 7px'
 }
 }
 };

 model.chartdata = fillData();

 function fillData() {
 var graphdata = [];
 for (var i = 0; i < model.measures.measuredata.length; i++) {
 graphdata.push({
 x: model.measures.measuredata[i].phenomenonTime,
 y: parseFloat(model.measures.measuredata[i].value)
 });
 }

 //Line chart data should be sent as an array of series objects.
 return [
 {
 values: graphdata,      //values - represents the array of {x,y} data points
 key: model.measures.observableProperty, //key  - the name of the series.
 color: '#ff7f0e',  //color - optional: choose your own line color.
 strokeWidth: 2,
 classed: 'dashed'
 }
 ];
 };
 * */

//var datefrom = moment().format("YYYY-MM-DD HH:mm:ss"); //Date from = dateFormat.parse("2015-05-21 00:00:00");
//var dateto = moment().subtract(1, "days").format("YYYY-MM-DD HH:mm:ss");

