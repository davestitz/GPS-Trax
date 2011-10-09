//
//  MapAnnotation.h
//  gps
//
//  Created by Stitz on 8/11/11.
//  Copyright 2011 Stitz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MapAnnotation  : NSObject <MKAnnotation> {
    CLLocationCoordinate2D coordinate;
    NSString *title;
    //NSString *subtitle;
    
}


@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString* title;
//@property (nonatomic, copy) NSString* subtitle;

@end


