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

            model.measures = {measuredata: [{phenomenonTime: "", value: ""}]};

            /*$scope.foo = 'foo';
             $scope.bar = 'bar';

             $scope.$watchGroup(['foo', 'bar'], function(newValues, oldValues, scope) {
             // newValues array contains the current values of the watch expressions
             // with the indexes matching those of the watchExpression array
             // i.e.
             // newValues[0] -> $scope.foo
             // and
             // newValues[1] -> $scope.bar
             });*/

            var groupBindingScope = $scope.$watchGroup(['model.enddevice', 'model.dtfrom', 'model.dtto'], function (newValues, oldValues, scope) {
                //var newValue = changesObj.enddevice.currentValue;
                //model.identifier = newValue;
                //var tmp_datefrom = changesObj.dtfrom.currentValue;
                //model.datetimefrom = tmp_datefrom;
                //var tmp_dateto = changesObj.dtto.currentValue;
                //model.datetimeto = tmp_datefrom;

                var newValue;
                if (newValues[0] != oldValues[0]) {
                    newValue = newValues[0]
                    model.identifier = newValue;
                } else {
                    newValue = oldValues[0]
                    model.identifier = newValue;
                }

                var tmp_datefrom
                if (newValues[1] != oldValues[1]) {
                    tmp_datefrom = newValues[1];
                    model.datetimefrom = tmp_datefrom;
                } else {
                    tmp_datefrom = oldValues[1]
                    model.datetimefrom = tmp_datefrom;
                }

                var tmp_dateto
                if (newValues[2] != oldValues[2]) {
                    tmp_dateto = oldValues[2];
                    model.datetimeto = tmp_dateto;
                } else {
                    tmp_dateto = oldValues[2]
                    model.datetimeto = tmp_dateto;
                }

                var defer = $q.defer();

                model.tableParams = new ngTableParams({
                    page: 1,
                    count: 5,
                    paginationMaxBlocks: 10,
                    paginationMinBlocks: 2
                }, {
                    getData: function (params) {

                        var datefrom = moment("2015-05-21 00:00:00", "YYYY-MM-DD HH:mm:ss");
                        var dateto = moment("2015-05-21 23:59:59", "YYYY-MM-DD HH:mm:ss");

                        var varApiGet = TableDataService.getMeasuresByProperty(model.parent.id, model.identifier, datefrom.format("YYYY-MM-DD HH:mm:ss"), dateto.format("YYYY-MM-DD HH:mm:ss")).then(
                            function (d) {
                                var theMeasures = d;
                                model.measures = d;


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


//var datefrom = moment().format("YYYY-MM-DD HH:mm:ss"); //Date from = dateFormat.parse("2015-05-21 00:00:00");
//var dateto = moment().subtract(1, "days").format("YYYY-MM-DD HH:mm:ss");

