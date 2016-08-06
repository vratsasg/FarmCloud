(function () {
    'use strict';
    var module = angular.module("myApp");

    module.component('irrigationModal', {
            templateUrl: 'static/js/components/control-panel/irrigation.modal.component.html',
            replace: true,
            require: {
                parent: '^controlPanel'
            },
            controllerAs: "model",
            controller: function (ControlPanelService, $q) {
                var model = this;
                var defer = $q.defer();

                model.$onInit = function () {
                    model.datefrom = new Date();
                    //model.dateto = new Date();
                    model.modWaterConsume = 0;
                    var instance = model.parent.modalInstance;

                    model.cancel = function () {
                        instance.dismiss('cancel');
                    };
                    model.submit = function () {
                        //setIrrigationDates
                        ControlPanelService.setFeatureDates(model.parent.myDevice, model.datefrom, model.dateto).then(
                            function (returnedData) {
                                defer.resolve(returnedData);
                                instance.close(returnedData);
                            }, function (errResponse) {
                                console.error('Error while sending request for starting measuring');
                            });
                    }

                    instance.result.then(function () {
                        console.log('test');
                    }, function () {
                        console.log('Modal dismissed at: ' + new Date());
                    });
                };

                model.beforeRenderStartDate = function ($view, $dates, $leftDate, $upDate, $rightDate) {
                    var now = moment();
                    for (var i = 0; i < $dates.length; i++) {
                        if ($dates[i].localDateValue() < now.valueOf()) {
                            $dates[i].selectable = false;
                        }
                    }

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
                        for (var i = 0; i < $dates.length; i++) {
                            if ($dates[i].localDateValue() <= activeDate.valueOf()) {
                                $dates[i].selectable = false;
                            }
                        }
                    }
                }

            }
        }
    );
}());
