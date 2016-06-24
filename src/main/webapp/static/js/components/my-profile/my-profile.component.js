(function () {
    var module = angular.module("myApp");

    module.component('myProfile', {
        templateUrl: 'static/js/components/my-profile/my-profile.component.html',
        controllerAs: "model",
        controller: function (ProfileService, $log, $q) {
            var model = this;

            model.myprofile = {};


            model.$onInit = function () {
                var defer = $q.defer();
                ProfileService.getProfile().then(
                    function (d) {

                        model.myprofile = d;
                        defer.resolve(model.myprofile);
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

/*{
 "devices": [{
 "identifier": "40D6A2CF",
 "sensors": [{
 "kindofmeasurement": "Internal Humidity",
 "sensorname": "DHT22",
 "typeofmeasurement": "Digital Measurement"
 }, {
 "kindofmeasurement": "Internal Temperature ",
 "sensorname": "DHT22",
 "typeofmeasurement": "Digital Measurement"
 }, {
 "kindofmeasurement": "Temperature",
 "sensorname": "LM35",
 "typeofmeasurement": "Analog Temperature"
 }, {
 "kindofmeasurement": "Soil Moisture",
 "sensorname": "LM393",
 "typeofmeasurement": "Soil Moisture"
 }],
 "description": "its an end device"
 }, {
 "identifier": "40E7CC39",
 "sensors": [{
 "kindofmeasurement": "Internal Humidity",
 "sensorname": "DHT22",
 "typeofmeasurement": "Digital Measurement"
 }, {
 "kindofmeasurement": "Internal Temperature ",
 "sensorname": "DHT22",
 "typeofmeasurement": "Digital Measurement"
 }, {
 "kindofmeasurement": "Temperature",
 "sensorname": "LM35",
 "typeofmeasurement": "Analog Temperature"
 }, {
 "kindofmeasurement": "Soil Moisture",
 "sensorname": "LM393",
 "typeofmeasurement": "Soil Moisture"
 }],
 "description": "its an end device"
 }, {
 "identifier": "40D6A2C9",
 "sensors": [{
 "kindofmeasurement": "Internal Humidity",
 "sensorname": "DHT22",
 "typeofmeasurement": "Digital Measurement"
 }, {
 "kindofmeasurement": "Internal Temperature ",
 "sensorname": "DHT22",
 "typeofmeasurement": "Digital Measurement"
 }, {
 "kindofmeasurement": "Temperature",
 "sensorname": "LM35",
 "typeofmeasurement": "Analog Temperature"
 }, {
 "kindofmeasurement": "Soil Moisture",
 "sensorname": "LM393",
 "typeofmeasurement": "Soil Moisture"
 }],
 "description": "its an end device"
 }],
 "stations": [{
 "identifier": "40E7CC41",
 "description": "Its a base station"
 }],
 "crop": {
 "identifier": "Crop Name",
 "description": "Its the main crop"
 }
 }
 */