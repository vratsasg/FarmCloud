(function () {
    'use strict';
    var module = angular.module("myApp");

    module.component('tableData', {
        templateUrl: 'static/js/components/observable-property/table-data/table-data.component.html',
        controllerAs: "model",
        bindings: {enddevice: "<"},
        require: {
            parent: '^observableProperty'
        },
        controller: function (TableDataService, $q, ngTableParams, $filter) {
            var model = this;

            model.measures = {measuredata: [{phenomenonTime: "", value: ""}]};

            model.$onChanges = function (changesObj) {
                var newValue = changesObj.enddevice.currentValue;
                model.identifier = newValue;
                var defer = $q.defer();


                model.tableParams = new ngTableParams({
                    page: 1,
                    count: 5,
                    paginationMaxBlocks: 10,
                    paginationMinBlocks: 2
                }, {
                    getData: function (params) {

                        var varApiGet = TableDataService.getMeasuresByProperty(model.parent.id, newValue).then(
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
            };

            model.$onInit = function () {
            };
        }
    });


}());
