/**
 * Created by George on 12/6/2016.
 */
'use strict';
App.component('topbar',{
    templateUrl:'/static/js/shared/topbar/top-bar-component.html',
    controllerAs: "model",
    controller: function(){
        var model = this;
        model.username = "";

        //components have lifecycles this is before the component is rendered
        model.$onInit = function () {
            model.username = "test user";
        }
    }
});
