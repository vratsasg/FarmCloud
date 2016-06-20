(function () {
    "use strict";

    var module = angular.module("myApp");
    module.component("cropApp", {
        templateUrl: 'static/js/components/crop-app/crop-app.component.html',
        $routeConfig: [
            {path: "/myprofile", component: "myProfile", name: "Profile"},
            {path: "/**", component: "firstPage", name: "Firstpage"}
        ],
        controller: function () {
        }
    });
}());