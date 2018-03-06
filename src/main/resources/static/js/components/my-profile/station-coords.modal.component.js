(function () {
    'use strict';
    var module = angular.module("myApp");

    module.component('stationcoordsModal', {
            templateUrl: 'static/js/components/my-profile/station-coords.modal.component.html',
            replace: true,
            require: {
                parent: '^myProfile'
            },
            controllerAs: "model",
            controller: function (ProfileService,olData, $timeout, $q) {
                var model = this;
                var defer = $q.defer();

                model.$onInit = function () {
                    var instance = model.parent.modalInstance;
                    model.loaded = false;

                    model.defaults = {
                        interactions: {
                            mouseWheelZoom: true
                        },
                        controls: {
                            zoom: true,
                            rotate: false,
                            attribution: false
                        },
                        events: {
                            map: [ 'click','singleclick' ]
                        }
                    };

                    model.cancel = function () {
                        instance.dismiss('cancel');
                    };

                    model.submit = function () {
                        console.log('You hit me!');
                    };

                    instance.result.then(function (returnedData) {
                        console.log('testModal Measure');
                    }, function () {
                        console.log('Modal dismissed at: ' + new Date());
                    });

                    $timeout(function(){
                        model.loaded = true;
                    },100);

                    olData.getMap().then(function(map){
                        map.on("openlayers.map.click", function(e) {
                            console.log('You clicked me!');
                        });
                        map.on("openlayers.map.singleclick", function(e) {
                            console.log('You clicked me!');
                        });
                        map.on("mouseclick", function(e) {
                            console.log('You clicked me!');
                        });
                    });
                };
            }
        }
    );
}());
