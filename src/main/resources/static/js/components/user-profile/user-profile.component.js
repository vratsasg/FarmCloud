(function () {
    'use strict';
    var module = angular.module("myApp");

    module.component('userProfile', {
        templateUrl: '/js/components/user-profile/user-profile.component.html',
        controllerAs: "model",
        controller: function (UserProfileService, $log, $q, toastr) {
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
                            UserProfileService.saveUserProfile(model.userprofile).then(
                                function (response) {
                                    if (response === true || response == "true") {
                                        toastr.success('User profile saved succesfully', 'Success!');
                                    } else {
                                        // toastr.error('Error on save watering profile data', 'Error');
                                    }
                                },
                                function (errResponse) {
                                    // toastr.error(errResponse, 'Error');
                                }
                            );
                        };

                        model.reset = function () {
                            model.userprofile = {
                                userId: null,
                                firstname: "",
                                lastname: "",
                                fathersname: "",
                                address: "",
                                addressnum: "",
                                zipcode: "",
                                telephone: "",
                                mobile: "",
                                dateofbirth: ""
                            };
                            model.userProfileForm.$setPristine(); //reset Form    
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

