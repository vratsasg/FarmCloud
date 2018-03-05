(function () {
    'use strict';
    var module = angular.module("myApp");

    module.component('topBar', {
        templateUrl: 'static/js/shared/topbar/top-bar-component.html',
        controllerAs: "model",
        controller: function ($uibModal, $document, userService, $q, toastr) {
            var model = this;
            model.user = {};
            model.notifications = [];

            var defer = $q.defer();
            userService.getnotifcounter().then(
                function (countdata) {
                    model.notifications = countdata;
                    defer.resolve(model.notifications);
                },
                function (errResponse) {
                    toastr.error(`Cannot clear messages: ${errResponse}`, 'Error');
                }
            );

            //components have lifecycles this is before the component is rendered
            model.$onInit = function () {
                var defer = $q.defer();
                userService.getuser().then(
                    function (data) {
                        model.user = data;
                        defer.resolve(model.user);
                    }, function (errResponse) {
                        console.error("error fetching user");
                    });

                userService.getnotifcounter().then(
                    function (data) {
                        model.notifications = data;
                        defer.resolve(model.notifications);
                    }, function (errResponse) {
                        toastr.error(`Cannot find messages: ${errResponse}`, 'Error');
                    });

                model.showModal = function () {
                    model.modalInstance = $uibModal.open({
                        animation: model.animationsEnabled,
                        template: '<logout-modal></logout-modal>',
                        appendTo: $document.find('top-bar')
                    });
                };

                model.toggleAnimation = function () {
                    model.animationsEnabled = !model.animationsEnabled;
                };

                model.clearMessage = function (msgid) {
                    userService.setNotificationRead(msgid).then(
                        function (data) {
                            model.notifications = model.notifications.filter((e) => e.notificationid !== msgid);
                        }, function (errResponse) {
                            console.error("error fetching user");
                            toastr.error(`Cannot clear messages: ${errResponse}`, 'Error');
                        });
                };

                model.clearAllMessages = function () {
                    userService.setAllNotificationRead().then(
                        function (data) {
                            model.notifications = [];
                        }, function (errResponse) {
                            toastr.error(`Cannot clear messages: ${errResponse}`, 'Error');
                        });
                }
            }
        }
    });
}());


