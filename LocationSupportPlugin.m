#import "LocationSupportPlugin.h"

@implementation LocationSupportPlugin
@synthesize locationManager;

NSString *user_token = @"";
NSString *host = @"";

//-(void) getLocation:(CDVInvokedUrlCommand*)command
//{
//    CDVPluginResult* pluginResult = nil;
//    
//    NSString *echo = [command.arguments objectAtIndex:0];
//    NSLog(@"in xcode: %@\n", echo);
//    
//    if (echo != nil && [echo length] > 0) {
//        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:echo];
//    } else {
//        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
//    }
//    NSLog(@"in xcode: %@\n", pluginResult);
//    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
//}
-(void) init:(CDVInvokedUrlCommand*)command
{
    NSString *msg = @"";
    CDVPluginResult* pluginResult = nil;
    
    /* init with user token */
    if (nil == locationManager){
        host = [[NSString alloc] initWithFormat:@"%@", [command.arguments objectAtIndex:0]];
        NSLog(@"Host %@", host);
        user_token = [[NSString alloc] initWithFormat:@"%@", [command.arguments objectAtIndex:1]];

        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        
        //Only applies when in foreground otherwise it only reacts on very significant changes
        //[locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        locationManager.distanceFilter = 1000;
        if ([CLLocationManager significantLocationChangeMonitoringAvailable]) {
            msg = @"LocationSupportPlugin: Tracking Significant is possible";
        } else {
            msg = @"LocationSupportPlugin: Tracking Significant not possible";
        }
    } else {
        msg = @"Plugin already initialized, this isn't a problem";
    }
    // Set a movement threshold for new events.
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:msg];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

-(void) changeUserToken:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSString *msg = @"LocationSupportPlugin: changing token";

    user_token = [[NSString alloc] initWithFormat:@"%@", [command.arguments objectAtIndex:0]];
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:msg];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}


- (void) didUpdateCoordinates:(CLLocationCoordinate2D) loc {
    //CLLocationCoordinate2D loc = coordinates.coordinate;
    // set post string with actual username and password.
    NSString *post = [NSString stringWithFormat:@"&token=%@&latitude=%f&longitude=%f", user_token, loc.latitude, loc.longitude];

    // Encode the post string using NSASCIIStringEncoding and also the post string you need to send in NSData format.
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion: YES];
    // You need to send the actual length of your data. Calculate the length of the post string.
    //NSLog(@"Post length %u \n", [postData length]);
    NSString *postLength = [NSString stringWithFormat:@"%u", [postData length]];
    
    // Create a Urlrequest with all the properties like HTTP method, http header field with length of the post string.
    //Create URLRequest object and initialize it.
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    
    // Set the Url for which your going to send the data to that request.
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat: @"%@", host]]];
    
    // Now, set HTTP method (POST or GET).
    // Write this lines as it is in your code.
    [request setHTTPMethod:@"POST"];
    
    // Set HTTP header field with length of the post data.
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    // Also set the Encoded value for HTTP header Field.
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Current-Type"];
    
    // Set the HTTPBody of the urlrequest with postData.
    [request setHTTPBody:postData];
    
    // Now, create URLConnection object. Initialize it with the URLRequest.
    NSURLConnection *conn = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    // Check for errors
    if(conn) {
        NSLog(@"Connection Successful.");
    } else {
        NSLog(@"Connection could not be made.");
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData*)data {
    NSLog(@"Did Receive Data");
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"Did Fail with Error %@", error);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"Connection Finished Loading");
}

/* this function will do something in the future but not now */
-(void) getLocation:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSString *msg = [command.arguments objectAtIndex:0];

    if (msg != nil && [msg length] > 0) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:msg];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }
        
   [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

-(void) startTrackingSignificant:(CDVInvokedUrlCommand*)command
{
    /* Plugin result object */
    CDVPluginResult* pluginResult = nil;
    
    /* status message */
    NSString *msg = @"";

    if(locationManager){
        [locationManager startMonitoringSignificantLocationChanges];
        msg = @"LocationSupportPlugin: Start Tracking on Signficant Changes";
    } else {
        msg = @"LocationSupportPlugin: location Manager was'nt available";
    }
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:msg];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

-(void) stopTrackingSignificant:(CDVInvokedUrlCommand *)command
{
    /* Plugin result object */
    CDVPluginResult* pluginResult = nil;
    /* status message */
    NSString *msg = @"";
    
    if(locationManager){
        [locationManager stopMonitoringSignificantLocationChanges];
        msg = @"LocationSupportPlugin: stop Tracking location";
    } else {
        msg = @"LocationSupportPlugin: location Manager was'nt available";
    }
    
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:msg];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    [msg release];
}

-(void) startTracking:(CDVInvokedUrlCommand*)command
{
    NSString *msg = @"";
    /* Plugin result object */
    CDVPluginResult* pluginResult = nil;

    if(locationManager){
        [locationManager startUpdatingLocation];
        msg = @"LocationSupportPlugin: start Tracking";
    } else {
        msg = @"LocationSupportPlugin: location Manager was'nt available";
    }
    
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:msg];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    [msg release];
}


-(void) stopTracking:(CDVInvokedUrlCommand*)command
{
    /* status message */
    NSString *msg = @"";
    
    /* Plugin result object */
    CDVPluginResult* pluginResult = nil;
    if(locationManager){
        [locationManager stopUpdatingLocation];
         msg = @"LocationSupportPlugin: stop Tracking location";
    } else {
        msg = @"LocationSupportPlugin: location Manager was'nt available";
    }
    
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:msg];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    [msg release];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    CLLocationCoordinate2D currentCoordinates = newLocation.coordinate;
    
    //NSLog(@"Entered new Location with the coordinates Latitude: %f Longitude: %f",currentCoordinates.latitude, currentCoordinates.longitude);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *currentCoordinates = [locations objectAtIndex:0];
    CLLocationCoordinate2D loc = currentCoordinates.coordinate;
    
    /* uncomment if needed, don't forget to show it and release it */
    //NSString *msg = [NSString stringWithFormat:@"lat: %f, lon: %f", loc.latitude, loc.longitude];
    //UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Location Update"
    //                                                message: msg
    //                                               delegate:nil
    //                                      cancelButtonTitle:@"OK"
    //                                      otherButtonTitles:nil];


    [self didUpdateCoordinates: loc];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Unable to start location manager. Error:%@", [error description]);
}


-(void)dealloc
{
    [self.locationManager release];
    [super dealloc];
}

@end
