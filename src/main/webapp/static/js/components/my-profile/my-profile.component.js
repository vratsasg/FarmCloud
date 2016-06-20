(function () {
    var module = angular.module("myApp");

    module.component('myProfile', {
        templateUrl: 'static/js/components/my-profile/my-profile.component.html',
        controllerAs: "model",
        controller: function (ProfileService, $log) {
            var model = this;

            model.myprofile = {};
            /*{"devices":[{"identifier":"40E7CC39","description":"Its an end device"},{"identifier":"40D6A2C9","description"
             :"its a end device name"},{"identifier":"40D6A2CF","description":"its an end device"}],"stations":[{"identifier"
             :"40E7CC41","description":"Its a base station"}],"crop":{"identifier":"Crop Name","description":"Its
             the main crop"}}*/

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
