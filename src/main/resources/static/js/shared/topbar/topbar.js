(function () {
    'use strict';
    var module = angular.module("myApp");

    module.component('topBar', {
        templateUrl: '/js/shared/topbar/top-bar-component.html',
        controllerAs: "model",
        controller: function ($uibModal, $document, userService, $q, $interval, toastr) {
            var model = this;
            model.user = {};
            model.notifications = [];

            var defer = $q.defer();

            // components have lifecycles this is before the component is rendered
            model.$onInit = function () {
                userService.getuser().then(
                    function (data) {
                        defer.resolve(model.user);
                        model.user = data;
                    }, function (errResponse) {
                        toastr.error(`Cannot get messages: ${errResponse}`, 'Error');
                    }
                );

                $interval(getnotifications(), 120000);
            };

            var getnotifications = function () {
                userService.getnotifcounter().then(
                    function (data) {
                        defer.resolve(data);
                        model.notifications = data;
                        toastr.info(`You have ${model.notifications.length} messages unread`);
                    }, function (errResponse) {
                        toastr.error(`Cannot find messages: ${errResponse}`, 'Error');
                    }
                );
            };

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
                        defer.resolve(data);
                        model.notifications = model.notifications.filter((e) => e.notificationid !== msgid);
                        toastr.success("Notification has been  cleared succesfully!", "Success!");
                    }, function (errResponse) {
                        toastr.error(`Cannot clear messages: ${errResponse}`, 'Error');
                    }
                );
            };

            model.clearAllMessages = function () {
                userService.setAllNotificationRead().then(
                    function (data) {
                        defer.resolve(data);
                        model.notifications = [];
                        toastr.success("All notification has been cleared succesfully!", "Success!");
                    }, function (errResponse) {
                        toastr.error(`Cannot clear messages: ${errResponse}`, "Error!");
                    }
                );
            };
        }
    });
}());


