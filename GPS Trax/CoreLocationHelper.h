//
//  CoreLocationHelper.h
//  gps
//
//  Created by Stitz on 9/12/11.
//  Copyright (c) 2011 Stitz. All rights reserved.
//

#import <Foundation/Foundation.h>


#import <CoreLocation/CoreLocation.h>


@protocol CoreLocationControllerDelegate 
@required
- (void)locationUpdate:(CLLocation *)location; // Our location updates are sent here
- (void)locationError:(NSError *)error; // Any errors are sent here
@end



@interface CoreLocationHelper : NSObject <CLLocationManagerDelegate> {
	CLLocationManager *locMgr;
	id delegate;
}

@property (nonatomic, retain) CLLocationManager *locMgr;
@property (nonatomic, strong) id delegate;

@end
