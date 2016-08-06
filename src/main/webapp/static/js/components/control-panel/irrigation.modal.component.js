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
                    model.datefrom = moment();
                    model.irrigationDuration = "0 hours and 0 minutes";
                    model.modWaterConsume = 0;
                    var instance = model.parent.modalInstance;

                    model.cancel = function () {
                        instance.dismiss('cancel');
                    };
                    model.submit = function () {
                        console.log(model.datefrom);
                        console.log(model.dateto);
                        //setIrrigationDates
                        ControlPanelService.setFeatureDates(model.parent.myDevice, model.datefrom.format("YYYY-MM-DD HH:mm:ss"), model.dateto.format("YYYY-MM-DD HH:mm:ss")).then(
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

                model.$onChanges = function (changesObj) {
                    var newstarttime = changesObj.datefrom;
                    var newendtime = changesObj.dateto;

                    if (newstarttime && newendtime) {
                        var totalHours = (newendtime.diff(newstarttime, 'hours'));
                        if (totalHours > 12) { //12 hours of irrigation is too much???
                            model.dateto = "";
                        }

                        var totalMinutes = newendtime.diff(newstarttime, 'minutes');
                        var clearMinutes = totalMinutes % 60;
                        model.irrigationDuration = totalHours + " hours and " + clearMinutes + " minutes";
                        console.log(totalHours + " hours and " + clearMinutes + " minutes");
                    }
                }

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
