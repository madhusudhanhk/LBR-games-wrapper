//
//  GMAppDelegate.m
//  GamesWrapper
//
//  Created by Madhusudhan HK on 4/16/13.
//  Copyright (c) 2013 Madhusudhan HK. All rights reserved.
//

#import "GMAppDelegate.h"

#import "GMViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "Flurry.h"




@implementation GMAppDelegate
@synthesize locationManager = _locationManager;
@synthesize userLocation = _userLocation;



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    /* registor for Facebook Ad With Facebook App id */
    
    [FBSession.activeSession isOpen];
    [FBSettings publishInstall:Facebook_APP_ID];
    
    /* registor for Flurry analytics with Flurry_API_KEY */
    
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    [Flurry startSession:Flurry_API_KEY];
    [Flurry logEvent:Flurry_Applaunched timed:YES];
    
   

    
    
    /* load splash screen */
    [self setUpSplash];
    
    
    /*  registor app to location service ,  to find current location of device */
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    
    [self.locationManager startUpdatingLocation];
    
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    /* end the settion and report to flurry */
    
    [Flurry endTimedEvent:Flurry_AppClosed withParameters:nil];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    /* start the session */
    
    [Flurry logEvent:@"LBR games wrapper App active" timed:YES];
    
    /*
    if(![self.userLocation isEqualToString:@"United Kingdom"]){
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://mobile.ladbrokes.com/games"]];
    }else{
          [self locationServicesIsEnabled];
    }
    */
    
  
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
//setup Options page on window

-(void) setUPOptionsPage {
    
    //UIView *iPhoneView;
    UIImage *optionsImage;
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 30200
    UIDevice* thisDevice = [UIDevice currentDevice];
    if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        optionsImage =[UIImage imageNamed:@"splash_768x1024"];
        
        
    }else if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPhone)
    {
        
        optionsImage =[UIImage imageNamed:@"default.png"];
        
    }
#endif
    
    UIView *iPhoneView = [[UIView alloc] initWithFrame: CGRectMake ( self.window.frame.origin.x, self.window.frame.origin.y, screenWidth, screenHeight)];
    optionsPage = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    [optionsPage setImage: optionsImage];
    [iPhoneView addSubview:optionsPage];
    float useValue = 0.0;
    float buttonSpace =0.0;
    if (screenHeight/10 > 100) {
        useValue = 150.0;
        buttonSpace = 80;
    }
    else{
        useValue = 70.0;
        buttonSpace = 40;
    }
    
    CGRect frame = CGRectMake(buttonSpace/2, screenHeight-((screenHeight/10)*3.5), screenWidth-buttonSpace, screenHeight/10);
    UIButton *tryAgainButton = [[UIButton alloc] initWithFrame:frame];
    [tryAgainButton setBackgroundImage:[UIImage imageNamed:@"btn_tryagain"] forState:UIControlStateNormal];
    [tryAgainButton addTarget:nil action:@selector(onClickTryAgain) forControlEvents:UIControlEventTouchUpInside];
    CGRect frame1 = CGRectMake(buttonSpace/2, frame.origin.y+useValue, screenWidth-buttonSpace, screenHeight/10);
    UIButton *launchWeb = [[UIButton alloc] initWithFrame:frame1];
    [launchWeb setBackgroundImage:[UIImage imageNamed:@"btn-launchwebsite"] forState:UIControlStateNormal];
    [launchWeb addTarget:nil action:@selector(onClickLaunchWebSite) forControlEvents:UIControlEventTouchUpInside];
    [iPhoneView addSubview:tryAgainButton];
    [iPhoneView addSubview:launchWeb];
    //[iPhoneView bringSubviewToFront:launchWeb];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window addSubview: iPhoneView];
    [self.window makeKeyAndVisible];
    
}


/* Try again functionalitie in option page */

- (void)onClickTryAgain{
    
    [self showProgressHudInView:self.window withTitle:@"Loading..." andMsg:nil];

    
    /* if location manager objects is exsists , make it nil  */
    if(self.locationManager)self.locationManager=nil;
    
    
    /*  registor app to location service ,  to find current location of device */
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    
    [self.locationManager startUpdatingLocation];
    
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    
        
}

/* Launch Website functionalities in option page */

- (void)onClickLaunchWebSite{
    NSLog(@"Launch Website button pressed");
    [self launchSafariFromApp];
    
}


/* Add splash screen on Window */

-(void) setUpSplash {
    
    
   
    UIImage *splashImage;
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 30200
    UIDevice* thisDevice = [UIDevice currentDevice];
    if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        splashImage =[UIImage imageNamed:@"Default"];
        
    }else if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPhone)
    {
        
        splashImage =[UIImage imageNamed:@"Default.png"];
        
    }
#endif
    
    
    splashImgView = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    [splashImgView setImage: splashImage];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window addSubview: splashImgView];
    
        
    [self.window makeKeyAndVisible];
    
    
    
}

/* set GMViewController as window's rootviewController to load UIWebView */


-(void) setUpRootViewController {
    
     [Flurry logEvent:Flurry_UIWebViewLaunched timed:YES];
    
    if(splashImgView) [splashImgView removeFromSuperview];
    
    if([self.window.rootViewController isEqual:(UIViewController *)self.viewController])return;
    
    
   // self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.viewController = [[GMViewController alloc] initWithNibName:@"GMViewController_iPhone" bundle:nil];
    } else {
        self.viewController = [[GMViewController alloc] initWithNibName:@"GMViewController_iPad" bundle:nil];
    }
    self.window.rootViewController = self.viewController;
    
    
    
    
}

/*  get user current loaction */

-(NSString *) getCurrentLocation : (CLLocation *)location;{
    
    
    __block NSString *currentLocation = @"";
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    
    
    
    
    [geocoder reverseGeocodeLocation: location completionHandler:
     ^(NSArray *placemarks, NSError *error) {
         
         
        
         if(! error){
             
             
             CLPlacemark *placemark = [placemarks objectAtIndex:0];
             
             
             NSLog(@"isoCountryCode %@", placemark.ISOcountryCode);
             NSLog(@"country : %@",placemark.country);
             NSLog(@"locality : %@",placemark.locality);
             NSLog(@"sublocality : %@",placemark.subLocality);
             //  NSLog(@"region : %@", placemark.region);
             
             
             
             self.userLocation = placemark.country;
             currentLocation = placemark.country;
             
             
                          
         }else{
             
             NSLog(@"failed getting city: %@", [error description]);
             
             
             UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Can't find current location" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
             
             [alertView show];
             
             
             
             return ;

         }
        
         
     }];

    
    while ([currentLocation isEqualToString:@""]){
        NSLog(@"%@", currentLocation);
        
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.01]];
    }
    
    
    
    return currentLocation;
    
  
    
}

/* method to launch safari */

-(void) launchSafariFromApp {
    
    
     [Flurry logEvent:Flurry_SafariLaunched timed:YES];
    
    NSURL *url = [NSURL URLWithString:@"http://mobile.ladbrokes.com/games"];
    
    if (![[UIApplication sharedApplication] openURL:url])
        NSLog(@"%@%@",@"Failed to open url:",[url description]);
    
    
}

/* check for location service status */


-(BOOL)locationServicesIsEnabled
{
   

    // If Location Services are disabled, restricted or denied.
    if ((![CLLocationManager locationServicesEnabled])
        || ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusRestricted)
        || ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied))
    {
        // Send the user to the safari with following url
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://mobile.ladbrokes.com/games"]];
        return NO;
    }
    return YES;
    
    
}



#pragma mark CLLocationManager delegate

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
 
  
    
    
        if (status== kCLAuthorizationStatusAuthorized)
            {
               
                 [Flurry logEvent:Flurry_LocationManagerAllow timed:YES];
                
              NSString *currentLocation =   [self performSelector:@selector(getCurrentLocation:) withObject:manager.location];
                
                /* check user location is UK ,
                 if Yes set rootViewController and launch WebView ,
                 else redirect to safari */
                
                if([currentLocation isEqualToString:@"United Kingdom"]){
                    
                    
                    [self setUpRootViewController];
                    
                    
                }else {
                    
                  //  [self launchSafariFromApp];
                    [self setUPOptionsPage];
                    
                    
                    
                }

                
        
        }else if (status == kCLAuthorizationStatusDenied)
            {
                    [Flurry logEvent:Flurry_LocationManagerDontAllow timed:YES];
                   // [self performSelector:@selector(launchSafariFromApp)];
                    [self performSelector:@selector(setUPOptionsPage)];
        
            }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if ([error code]== kCLAuthorizationStatusDenied)
    {
        
    }
}

#pragma mark Flurry methods

void uncaughtExceptionHandler(NSException *exception) {
    [Flurry logError:@"Uncaught" message:@"Crash!" exception:exception];
}



#pragma mark - MBProgressHud

- (void) showProgressHudInView:(UIWindow*)aView withTitle:(NSString*)aTitle andMsg:(NSString*)aMSG
{
    MBProgressHUD *aMBProgressHUD = [MBProgressHUD showHUDAddedTo:aView animated:YES];
    aMBProgressHUD.labelText = aTitle;
}

- (void) hideProgressHudInView:(UIView*)aView
{
    [MBProgressHUD hideHUDForView:aView animated:YES];
}


@end
