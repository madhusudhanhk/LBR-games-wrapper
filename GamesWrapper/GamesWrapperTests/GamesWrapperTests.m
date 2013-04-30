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

#define kGamesUrl @"http://mobile.ladbrokes.com/games"


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




- (void) testAppDelegate {
    STAssertNotNil(myAppDelegate, @"Cannot find the application delegate");
}


- (void) testUserCurrentLocation{
    
   
   /* TO DO : for testing US latt : 37.33233141 , long : -122.0312186 */
    CLLocation *location = [[CLLocation alloc]initWithLatitude:51.5 longitude:-0.116666666666667];
    
   
    NSString *currentLocation = [myAppDelegate getCurrentLocation:location];
    
    STAssertTrue([currentLocation isEqualToString:@"United Kingdom"], @"Device's current location is not United Kingdom");
    
   
}

-(void) testWebView{
    
    
    NSString *returnsUrl = [myViewController loadWebViewWithUrl:kGamesUrl];
    
    STAssertTrue([returnsUrl isEqualToString:kGamesUrl], @"Cannot find expeted url from UIWebView");
    
    
    
}

@end
