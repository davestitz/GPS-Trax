//
//  MapAnnotation.m
//  gps
//
//  Created by Stitz on 8/11/11.
//  Copyright 2011 Stitz. All rights reserved.
//

#import "MapAnnotation.h"

@implementation MapAnnotation

@synthesize coordinate, title;//, subtitle;

/*
- (NSString *)subtitle{
    return @"Sub Title";
}

- (NSString *)title{
    return @"Title";
}
*/

/*
- (id)initWithCoordinates:(CLLocationCoordinate2D)c coreLocationLatLong:(NSString *)latlong {
//- (id)initWithCoordinate:(CLLocationCoordinate2D) c{
    coordinate=c;
    
    title = latlong;
    //[title retain];
    
    //NSLog(@"%f,%f",c.latitude,c.longitude);
    return self;
}
*/

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void) dealloc {
    //[super dealloc];
    //self.title = nil;

}

@end
