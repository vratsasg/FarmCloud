/**
 * Created by George on 28/5/2016.
 */
'use strict';

App.controller('homecontroller', ['$scope', 'CropService', '$log', '$uibModal', function ($scope, CropService, $log, $uibModal) {

    $log.debug('Hello Debug!');
    var self = this;

// press add crop create modal service ModalInstanceCtrl
    $scope.showModal = function () {

        $log.debug('Hello Debug2!');

        var modalInstance = $uibModal.open({
            animation: $scope.animationsEnabled,
            templateUrl: 'myModalAddCrop.html',
            controller: ModalInstanceCtrl,
            scope: $scope
        });
// return data from ModalInstanceCtrl
        modalInstance.result.then(function (data) {
         //   $log.info(data.devices[0].devname);
         //   $log.info(data.devices[1]);

            self.createCrop(data);
        }, function () {
            $log.info('Modal dismissed at: ' + new Date());
        });

    };

    self.createCrop = function (crop) {
        $log.info("Controller createCrop");
        CropService.addcrop(crop).then(
            function (errResponse) {
                console.error('Error while fetching Currencies');
            }
        );


    };
    $scope.toggleAnimation = function () {
        $scope.animationsEnabled = !$scope.animationsEnabled;
    };


}]);

// Service Modal and Modal Content
var ModalInstanceCtrl = function ($log, $scope, $uibModalInstance) {


    //Form modal elements
   $scope.crop = {cropname: "", stationname: "", cropdescription: "", stationdescription: "", devices: [{devname:""}]};
   // $scope.crop = {cropname: "", stationname: "", cropdescription: "", stationdescription: ""};

    // Dynamically push enddevices to crop list
    $scope.addenddevice = function () {

        $scope.crop.devices.push({
            devname: ""
        });
    };
    // at submit send data to parentController homecontroller
    $scope.submit = function () {
        $log.info($scope.crop.cropname);
        console.log('user form is in scope');
        // send data to parent controller
        $uibModalInstance.close($scope.crop);

    };
    // at cancel send dismiss to parentController homecontroller
    $scope.cancel = function () {
        $uibModalInstance.dismiss('cancel');
    };
};



