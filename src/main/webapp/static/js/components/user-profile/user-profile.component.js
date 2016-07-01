(function () {
    'use strict';
    var module = angular.module("myApp");

    $("#body").on(
        "transitionend MSTransitionEnd webkitTransitionEnd oTransitionEnd",
        function () {
            $('#alertAreaid').empty();
        }
    );

    module.component('userProfile', {
        templateUrl: 'static/js/components/user-profile/user-profile.component.html',
        controllerAs: "model",
        link: function (model, element, attrs) {
            $timeout(function () {
                element.remove();
            }, 4000);
        },
        controller: function (UserProfileService, $log, $q) {
            var model = this;
            model.userprofile = {};

            model.$onInit = function () {
                var defer = $q.defer();

                UserProfileService.getUserProfile().then(
                    function (d) {
                        model.userprofile = d;
                        defer.resolve(model.userprofile);

                        var dt = moment(model.userprofile.dateofbirth, "YYYY-MM-DD");
                        model.userprofile.dateofbirth = new Date(dt.year(), dt.month(), dt.date())

                        model.altInputFormats = ['d!/M!/yyyy'];
                        model.format = "dd/MM/yyyy";
                        model.dateOptions = {
                            formatYear: 'YYYY',
                            maxDate: new Date(),
                            minDate: new Date(1930, 0, 1),
                            startingDay: new Date()
                        };

                        model.open1 = function () {
                            model.popup1.opened = true;
                        };

                        model.popup1 = {
                            opened: false
                        };

                        model.submit = function () {
                            console.log(model.userprofile);
                            UserProfileService.saveUserProfile(model.userprofile).then(
                                function (response) {
                                    if (response === true || response == "true") {
                                        var myEl = angular.element(document.querySelector('#alertAreaid'));
                                        var appenddiv = '<div class="alert alert-success alert_messa">' +
                                            '   <strong>Success!</strong>You have succesfully saved your profile!' +
                                            '</div>';
                                        myEl.html(appenddiv);
                                    } else {
                                        //TODO error
                                    }
                                },
                                function (errResponse) {
                                    console.error('Error while fetching Currencies');
                                }
                            );
                        };

                    },
                    function (errResponse) {
                        console.error('Error while fetching user profile!!!');
                    }
                );


            }
        }
    });
}());

