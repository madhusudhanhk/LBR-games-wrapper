//
//  GMAppDelegate.h
//  GamesWrapper
//
//  Created by Madhusudhan HK on 4/16/13.
//  Copyright (c) 2013 Madhusudhan HK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@class GMViewController;

@interface GMAppDelegate : UIResponder <UIApplicationDelegate , CLLocationManagerDelegate>{
    
     UIImageView *splashImgView;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) GMViewController *viewController;

@property (strong, nonatomic) CLLocationManager *locationManager;

-(void)getCurrentLocation;
-(void) setUpSplash ;
-(void) setUpRootViewController ;
-(void) launchSafariFromApp ;

@end