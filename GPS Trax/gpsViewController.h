//
//  gpsViewController.h
//  GPS Trax
//
//  Created by Stitz on 10/8/11.
//  Copyright (c) 2011 Stitz. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface gpsViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate, UIWebViewDelegate> {
    IBOutlet UITextView *gpsResponse;
    IBOutlet UITextView *gpsResponseAlt;
    
    IBOutlet UITextView *gpsResponsejs;
    IBOutlet UITextView *gpsResponseAltjs;
    
    IBOutlet UILabel *coreUpdateCount;
    CLLocationManager *locationManager;
	BOOL fetchingLocation;
    IBOutlet UIWebView *webView;
    
    IBOutlet MKMapView *coreMapView;
    IBOutlet MKMapView *webMapView;
    int coreCount;
    
    double coreLatitude;
    double coreLongitude;
    
    double webLatitude;
    double webLongitude;
    
    IBOutlet UISwitch *gpsSwitch;
    
    
    
    
}

@property (nonatomic, retain) IBOutlet UITextView *gpsResponse;
@property (nonatomic, retain) IBOutlet UITextView *gpsResponsejs;

@property (nonatomic, retain) IBOutlet UITextView *gpsResponseAlt;
@property (nonatomic, retain) IBOutlet UITextView *gpsResponseAltjs;

@property (nonatomic, retain) IBOutlet UILabel *coreUpdateCount;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) UIWebView *webView;

@property (nonatomic, retain) IBOutlet MKMapView *coreMapView;
@property (nonatomic, retain) IBOutlet MKMapView *webMapView;

@property (nonatomic, retain) UISwitch *gpsSwitch; 

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation;

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error;

-(CLLocationCoordinate2D) coreAddressLocation:(double )theLat withLong:(double )theLong;

- (IBAction) toggleGPS: (id) sender;


- (IBAction) showInfo: (id) sender;



- (void) updateCoreLocationAnn;
- (void) updateJavascriptAnn;
@end
