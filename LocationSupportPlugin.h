/**************************************************
* Name: locationsupport-cordova-plugin
*
* Purpose: Provide the functionality to track a location of your
*       app users in order to make other functionalities possible.
*        e.g, location targeted push-message notifications.
*
* Author: R. Torenvliet(icyrizard)
* Date Created: 10-15-2013
* Licence: GNU GPL-V2
*/

#import <Cordova/CDV.h>
#import <CoreLocation/CoreLocation.h>

CLLocationManager *locationManager;

@interface LocationSupportPlugin : CDVPlugin
    -(void) init:(CDVInvokedUrlCommand*)command;
    -(void) getLocation:(CDVInvokedUrlCommand*)command;
    -(void) startTracking:(CDVInvokedUrlCommand*)command;
    -(void) stopTracking:(CDVInvokedUrlCommand*)command;
    -(void) startTrackingSignificant:(CDVInvokedUrlCommand*)command;
    -(void) stopTrackingSignificant:(CDVInvokedUrlCommand*)command;
    - (void) latitude:(CLLocationDegrees) currentLatitude longitude:(CLLocationDegrees) currentLongitude;

@property (nonatomic, retain) CLLocationManager *locationManager;

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation;
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error;
@end


