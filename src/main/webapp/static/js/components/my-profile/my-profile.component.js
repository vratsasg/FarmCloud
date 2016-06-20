(function () {
    var module = angular.module("myApp");

    module.component('myProfile', {
        templateUrl: 'static/js/components/my-profile/my-profile.component.html',
        controllerAs: "model",
        controller: function (ProfileService, $log) {
            var model = this;

            model.myprofile = {};

            model.$onInit = function () {

                ProfileService.getProfile().then(
                    function (d) {

                        model.myprofile = d;
                        $log.info('Crop name: ' + model.myprofile.crop.identifier);
                    },
                    function (errResponse) {
                        console.error('Error while fetching Profile');
                    }
                );
            }
        }
    });
}());
