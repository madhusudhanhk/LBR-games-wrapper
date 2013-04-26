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
#define Facebook_APP_ID @"150038098508329" // TODO :: updated new LBR account app id 

@implementation GMAppDelegate
@synthesize locationManager;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    /* registor for Facebook Ad With Facebook App id */
    
    [FBSettings publishInstall:Facebook_APP_ID];
    
    
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
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [self locationServicesIsEnabled];
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
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

-(void)getCurrentLocation{
 
    
   
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    
    [geocoder reverseGeocodeLocation: self.locationManager.location completionHandler:
     ^(NSArray *placemarks, NSError *error) {
         
         
         if(error){
          
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Can't find current location" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
             
             [alertView show];
             
             return ;
             
             
         }
         
         CLPlacemark *placemark = [placemarks objectAtIndex:0];
         
         
         NSLog(@"isoCountryCode %@", placemark.ISOcountryCode);
         NSLog(@"country : %@",placemark.country);
         NSLog(@"locality : %@",placemark.locality);
         NSLog(@"sublocality : %@",placemark.subLocality);
       //  NSLog(@"region : %@", placemark.region);
         
         
         /* check user location is UK ,
         if Yes set rootViewController and launch WebView , 
         else redirect to safari */
         
         if([placemark.country isEqualToString:@"United Kingdom"]){
             
             [self setUpRootViewController];
             
             
         }else {
             
             [self launchSafariFromApp];
         }
         
     }];

    
}

/* method to launch safari */

-(void) launchSafariFromApp {
    
    NSURL *url = [NSURL URLWithString:@"http://mobile.ladbrokes.com/"];
    
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
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://mobile.ladbrokes.com/"]];
        return NO;
    }
    return YES;
    
    
}

#pragma mark CLLocationManager delegate

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
 
  
    
    
        if (status== kCLAuthorizationStatusAuthorized)
            {
        
                [self performSelector:@selector(getCurrentLocation)];
        
        }else if (status == kCLAuthorizationStatusDenied)
            {
        
                    [self performSelector:@selector(launchSafariFromApp)];
        
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
@end
