//
//  GamesWrapperTests.m
//  GamesWrapperTests
//
//  Created by Madhusudhan HK on 4/16/13.
//  Copyright (c) 2013 Madhusudhan HK. All rights reserved.
//

#import "GamesWrapperTests.h"
#import "GMViewController.h"
#import "GMAppDelegate.h"
@implementation GamesWrapperTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
   
    myAppDelegate = (GMAppDelegate *)[[UIApplication sharedApplication]delegate];
    myViewController = myAppDelegate.viewController;
    myView = myViewController.view;
    
   
    
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
   // GMViewController *otherViewCntrl = [GMViewController new];
    
    STAssertEqualObjects(0,  0, @"both array equal");
    
    //STFail(@"Unit tests are not implemented yet in GamesWrapperTests");
}


- (void) testAppDelegate {
    STAssertNotNil(myAppDelegate, @"Cannot find the application delegate");
}

- (void) testLocationManagerAlerView{
    
    id<CLLocationManagerDelegate> delegate = [myAppDelegate.locationManager delegate];
    
    [delegate locationManager:myAppDelegate.locationManager didChangeAuthorizationStatus:kCLAuthorizationStatusAuthorized];
    

    
    
    
    
}



#pragma mark CLLocationManager delegate

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    
    
    
    
    if (status== kCLAuthorizationStatusAuthorized)
    {
        
       
        
    }else if (status == kCLAuthorizationStatusDenied)
    {
        
       
        
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
