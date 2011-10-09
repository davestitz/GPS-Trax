//
//  gpsAppDelegate.h
//  GPS Trax
//
//  Created by Stitz on 10/8/11.
//  Copyright (c) 2011 Stitz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class gpsViewController;

@interface gpsAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) gpsViewController *viewController;

@end
