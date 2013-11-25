/*'*************************************************
* Name: locationsupport-cordova-plugin
*
* Purpose: Provide the functionality to track a location of your
*          app users with your cordova App.
*          This allows other functionalities to be possible,
*          e.g location targeted push-message notifications.
*
* Author: R. Torenvliet(icyrizard)
* Date Created: 10-15-2013
* Licence: GNU GPL-V2
*/
CDV = ( typeof CDV == 'undefined' ? {} : CDV );

var cordova = window.cordova || window.Cordova;

CDV.LS = {
    /**
     * Initialize with random token which
     * identifies the current session with the user.
     *
     * DO NOT store any personal information about users.
     */
    init: function(token){
        console.log("Initializing plugin");
        // example host, change the host name
        var host = 'http://localhost/api';
        cordova.exec(function(e){
            console.log(e);
        }, function(e){
            console.error(e);
        }, "LocationSupportPlugin", "init", [host, token]);
    },

    getLocation: function(){
        cordova.exec(function(e){
            console.log(e);
        }, function(e){
            console.error(e);
        }, "LocationSupportPlugin", "getLocation", ["getLocation"]);
    },

    startTrackingSignificant: function(){
        cordova.exec(function(e){
            console.log(e);
        }, function(e){
            console.error(e);
        }, "LocationSupportPlugin", "startTrackingSignificant", ["startTracking"]);
    },

    stopTrackingSignificant: function(){
        cordova.exec(function(e){
            console.log(e);
        }, function(e){
            console.error(e);
        },  "LocationSupportPlugin", "stopTrackingSignificant", ["stopTracking"]);
    },

    startTracking: function(){
        cordova.exec(function(e){
            console.log(e);
        }, function(e){
            console.error(e);
        }, "LocationSupportPlugin", "startTracking", ["startTracking"]);
    },

    stopTracking: function(){
        cordova.exec(function(e){
            console.log(e);
        }, function(e){
            console.error(e);
        }, "LocationSupportPlugin", "stopTracking", ["stopTracking"]);
    },
};

