//
//  GMAppDelegate.h
//  GamesWrapper
//
//  Created by Madhusudhan HK on 4/16/13.
//  Copyright (c) 2013 Madhusudhan HK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "UALocationService.h"

@class GMViewController;

@interface GMAppDelegate : UIResponder <UIApplicationDelegate , CLLocationManagerDelegate>{
    
     UIImageView *splashImgView;
     NSString *userLocation;
     UIImageView *optionsPage;
     UIActivityIndicatorView *activityIndictr;
    UALocationService *locationService;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) GMViewController *viewController;

@property (strong, nonatomic) CLLocationManager *locationManager;

@property (strong , nonatomic)  NSString *userLocation;




-(NSString *) getCurrentLocation : (CLLocation *)location;

-(void) setUpSplash ;
-(void) setUpRootViewController ;
-(void) launchSafariFromApp ;
-(void) onClickTryAgain;
-(void) onClickLaunchWebSite;



@end
