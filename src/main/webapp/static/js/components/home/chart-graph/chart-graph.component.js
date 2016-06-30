(function () {
    "use-strict"

    var module = angular.module("myApp");

    module.component('chartGraph', {

        templateUrl: 'static/js/components/home/chart-graph/chart-graph.component.html',
        controllerAs: "model",
        bindings: {enddev: '<'},
        controller: function (chartService, $q) {

            var model = this;
            model.data = [];

            model.$onInit = function () {

                var defer = $q.defer();
                chartService.getDeviceChart(model.enddev).then(
                    function (serverdata) {
                        model.data = serverdata;
                        defer.resolve(model.data);


                    },
                    function (errResponse) {
                        console.error('Error while fetching chart devices');
                    });


                console.log(model.enddev);


                /* Chart data */
                model.options = {
                    chart: {
                        type: 'cumulativeLineChart',
                        height: 450,
                        margin: {
                            top: 20,
                            right: 20,
                            bottom: 60,
                            left: 65
                        },
                        x: function (d) {
                            return new Date(parseInt(d[0]));
                        },
                        y: function (d) {
                            return parseFloat(d[1]);
                        },

                        color: d3.scale.category10().range(),
                        duration: 300,
                        useInteractiveGuideline: true,
                        clipVoronoi: false,

                        xAxis: {
                            axisLabel: 'X Axis',
                            tickFormat: function (d) {
                                return d3.time.format('%H:%M')(new Date(parseInt(d)))
                            },
                            showMaxMin: false,
                            staggerLabels: true
                        },

                        yAxis: {
                            axisLabel: 'Y Axis',
                            tickFormat: function (d) {
                                return d3.format('.3f')(d);
                            },
                            axisLabelDistance: 20
                        }
                    }
                };


            };


        }


    });


}());


/*[{
 "Temperature": [{
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