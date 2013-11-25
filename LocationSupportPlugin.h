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


