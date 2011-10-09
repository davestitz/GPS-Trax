//
//  gpsViewController.m
//  GPS Trax
//
//  Created by Stitz on 10/8/11.
//  Copyright (c) 2011 Stitz. All rights reserved.
//

#import "gpsViewController.h"
#import "MapAnnotation.h"

@implementation gpsViewController

@synthesize gpsResponse, webView, locationManager, coreMapView, coreUpdateCount, webMapView, gpsSwitch, gpsResponsejs;
@synthesize gpsResponseAlt, gpsResponseAltjs;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    webView.opaque = NO;
    webView.backgroundColor = [UIColor clearColor];
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"gps" ofType:@"html"]isDirectory:NO]]];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    gpsResponse = nil;
    gpsResponsejs = nil;
    webView = nil;
    coreUpdateCount = nil;
    gpsSwitch = nil;
    
    gpsResponseAlt = nil;
    gpsResponseAltjs = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}





- (IBAction) startCore {
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager startUpdatingLocation];
    
    locationManager = nil;
    
}

- (IBAction) stopGPS {
    [self.locationManager stopUpdatingLocation];
    
}

- (IBAction) toggleGPS: (id) sender {  
    [UIView beginAnimations:nil context:NULL];  
    [UIView setAnimationDuration: 0.2];  
    
    if (gpsSwitch.on) {
        NSLog(@"GPS ON");
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [self.locationManager startUpdatingLocation];
        
        //locationManager = nil;
        //fetchingLocation = YES;
    }
    else {
        NSLog(@"GPS OFF");
        [self.locationManager stopUpdatingLocation];
        //fetchingLocation = NO;
    }
    
    [UIView commitAnimations];  
}  



- (CLLocationCoordinate2D) coreAddressLocation:(double )theLat withLong:(double )theLong {
    
    double latitude = theLat;
    double longitude = theLong;
    
    CLLocationCoordinate2D location;
    location.latitude = latitude;
    location.longitude = longitude;
    
    return location;
}





- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
	
    NSString *webLat = [self.webView stringByEvaluatingJavaScriptFromString: @"document.getElementById('latitude').textContent"];
    NSString *webLong = [self.webView stringByEvaluatingJavaScriptFromString: @"document.getElementById('longitude').textContent"];
    NSString *webAccuracy = [self.webView stringByEvaluatingJavaScriptFromString: @"document.getElementById('accuracy').textContent"];
    NSString *webAltitude = [self.webView stringByEvaluatingJavaScriptFromString: @"document.getElementById('altitude').textContent"];
    NSString *webAltAcc = [self.webView stringByEvaluatingJavaScriptFromString: @"document.getElementById('alt_altitude').textContent"]; 
    NSString *webSpeed = [self.webView stringByEvaluatingJavaScriptFromString: @"document.getElementById('speed').textContent"];   
    NSString *webHeading = [self.webView stringByEvaluatingJavaScriptFromString: @"document.getElementById('heading').textContent"];   
    NSLog (@"Web Lat: %@, Web Long: %@", webLat, webLong);
    NSLog (@"Web Acc: %@, Web Alt: %@, Web Speed: %@", webAccuracy, webAltitude, webSpeed);
    
	NSLog(@"Lat = %f Long = %f",newLocation.coordinate.latitude,newLocation.coordinate.longitude);
	
    coreCount = coreCount++;
    NSLog(@"Core Count: %d", coreCount);
    coreUpdateCount.text = [NSString stringWithFormat:@"%d", coreCount];
    
	CLLocationDegrees  latitude = newLocation.coordinate.latitude;
	CLLocationDegrees longitude = newLocation.coordinate.longitude;
	//NSString *coreLat = [[NSNumber numberWithDouble:latitude] stringValue];
	//NSString *coreLng = [[NSNumber numberWithDouble:longitude] stringValue];
    
    NSString *coreLat = [NSString stringWithFormat:@"%f", latitude];
    NSString *coreLng = [NSString stringWithFormat:@"%f", longitude];
    
    
    NSString *coreAlt = [NSString stringWithFormat:@"%.02f ft", 3.2808399 * newLocation.altitude];
    
    
    //distanceMeters = newLocation.altitude;
    //distanceFeet = distanceMeters * 3.2808399;
    //tAltitude  = [NSString stringWithFormat:@"%.02f ft",    distanceFeet];
    
    
    
    
    
    NSString *coreSpeed = [NSString stringWithFormat:@"%0.1f", 2.23693629 * newLocation.speed];
    //NSString *coreSpeed = [NSString stringWithFormat:@"%f", newLocation.speed];
	
    gpsResponse.text = [NSString stringWithFormat:@"Lat: %@ Long: %@", coreLat, coreLng];
    gpsResponseAlt.text = [NSString stringWithFormat:@"Altitude: %@ Speed (MPH): %@ HAcc: %f VAcc: %f", coreAlt, coreSpeed, newLocation.horizontalAccuracy, newLocation.verticalAccuracy];
    
    gpsResponsejs.text = [NSString stringWithFormat:@"Lat: %@ Long: %@", webLat, webLong];
    gpsResponseAltjs.text = [NSString stringWithFormat:@"Altitude: %@ Speed: %@ Accuracy: %@ Alt Accuracy: %@ Heading: %@", webAltitude, webSpeed, webAccuracy, webAltAcc, webHeading];
    
    NSString *annoTitle = [NSString stringWithFormat:@"%@ %@", coreLat, coreLng];
    NSString *annoTitleWeb = [NSString stringWithFormat:@"%@ %@", webLat, webLong];
    
    //-------------------------------------------------------
    //Add Annotation for CoreLocation Call
    
    if (newLocation.coordinate.latitude != oldLocation.coordinate.latitude && newLocation.coordinate.longitude != oldLocation.coordinate.longitude) {
        
        MKCoordinateRegion region;
        MKCoordinateSpan span;
        span.latitudeDelta=0.02;
        span.longitudeDelta=0.02;
        
        CLLocationCoordinate2D location = [self coreAddressLocation: [coreLat floatValue] withLong:[coreLng floatValue]];
        region.span=span;
        region.center=location;
        
        [coreMapView removeAnnotations:coreMapView.annotations];
        MapAnnotation* coreCurrentLocation = [[MapAnnotation alloc] init];
        coreCurrentLocation.coordinate = location;
        coreCurrentLocation.title = annoTitle;
        [coreMapView addAnnotation:coreCurrentLocation];
        
        [coreMapView setRegion:region animated:TRUE];
        [coreMapView regionThatFits:region];
        
    }
    //-------------------------------------------------------
    
    
    
    //-------------------------------------------------------
    //Add Annotation for Javascript Call
    MKCoordinateRegion regionWeb;
    MKCoordinateSpan spanWeb;
    spanWeb.latitudeDelta=0.02;
    spanWeb.longitudeDelta=0.02;
    
    CLLocationCoordinate2D locationWeb = [self coreAddressLocation: [webLat floatValue] withLong:[webLong floatValue]];
    regionWeb.span=spanWeb;
    regionWeb.center=locationWeb;
    
    [webMapView removeAnnotations:webMapView.annotations];
    MapAnnotation* coreCurrentLocationWeb = [[MapAnnotation alloc] init];
    coreCurrentLocationWeb.coordinate = locationWeb;
    coreCurrentLocationWeb.title = annoTitleWeb;
    [webMapView addAnnotation:coreCurrentLocationWeb];
    
    [webMapView setRegion:regionWeb animated:TRUE];
    [webMapView regionThatFits:regionWeb];
    //-------------------------------------------------------
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
	//--NSLog(@"Error: %@", [error description]);
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	[manager stopUpdatingLocation];
	self.locationManager = nil;
	//fetchingLocation = NO;
	
	
	switch([error code])
	{
		case kCLErrorNetwork: // general, network-related error
		{
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please check your network connection or that you are not in airplane mode" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
			alert.tag = 56;
			alert.delegate = self;
			[alert show];
			//[alert release];
		}
			break;
		case kCLErrorDenied:{
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your current location will not be used to determined your location." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
			alert.tag = 57;
			alert.delegate = self;
			[alert show];
			//[alert release];
		}
			break;
		default:
		{
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your current location could not be determined. Please check your device and try again." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
			alert.tag = 58;
			alert.delegate = self;
			[alert show];
			//[alert release];
		}
			break;
	}		
}



- (void) updateCoreLocationAnn {
    
    
}

- (void) updateJavascriptAnn {
    
    
}








- (void)webViewDidStartLoad:(UIWebView *)webView {
	//[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSLog(@"webViewDidStartLoad");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
	//[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	NSLog(@"webViewDidFinishLoad");
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
	NSLog (@"webView:didFailLoadWithError");
    
    if (error != NULL) {
        /*
        UIAlertView *errorAlert = [[UIAlertView alloc]
								   initWithTitle: [error localizedDescription]
								   message: [error localizedFailureReason]
								   delegate:nil
								   cancelButtonTitle:@"OK" 
								   otherButtonTitles:nil];
        //[errorAlert show];
        //[errorAlert release];
         */
    }
}

- (BOOL)webView:(UIWebView *)WebView shouldStartLoadWithRequest: (NSURLRequest *)request navigationType:(UIWebViewNavigationType) navigationType {
	NSLog(@"shouldStartWithLoadRequest");
	
    /*
     if ( [request.mainDocumentURL.relativePath isEqualToString:@"/getGPS/"] ) {
     NSString *webLat = [self.webView stringByEvaluatingJavaScriptFromString: @"document.getElementById('latitude').textContent"];
     NSString *webLong = [self.webView stringByEvaluatingJavaScriptFromString: @"document.getElementById('longitude').textContent"];
     NSLog (@"REQUEST Web Lat: %@, Web Long: %@", webLat, webLong); //should log the node
     
     return false;
     }
     */
	return true;
    
}




















- (IBAction) showInfo: (id) sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Known Issues" message:@"1) The javascript API refreshes on the button click event yet the core location call is constantly updated." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    alert.tag = 526;
    alert.delegate = self;
    [alert show];
    //[alert release];
}










@end
