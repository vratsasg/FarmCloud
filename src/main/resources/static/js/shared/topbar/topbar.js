(function () {
    'use strict';
    var module = angular.module("myApp");

    module.component('topBar', {
        templateUrl: '/js/shared/topbar/top-bar-component.html',
        controllerAs: "model",
        controller: function ($scope, $uibModal, $document, userService, $q, $interval, toastr) {
            var model = this;
            model.user = {};
            model.notifications = [];

            var defer = $q.defer();

            $scope.getnotifications = function () {
                userService.getnotifcounter().then(
                    function (data) {
                        defer.resolve(data);
                        if (data.length > model.notifications.length) {
                            toastr.info(`You have ${data.length - model.notifications.length} messages unread`);
                        }
                        model.notifications = data;
                    }, function (errResponse) {
                        toastr.error(`Cannot find messages: ${errResponse}`, 'Error');
                    }
                );
            };

            $interval( function(){ $scope.getnotifications(); }, 120000);

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

                $scope.getnotifications();
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


