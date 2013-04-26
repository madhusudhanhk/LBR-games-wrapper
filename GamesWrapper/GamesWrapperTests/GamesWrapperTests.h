	//
//  GamesWrapperTests.h
//  GamesWrapperTests
//
//  Created by Madhusudhan HK on 4/16/13.
//  Copyright (c) 2013 Madhusudhan HK. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "GMAppDelegate.h"
#import "GMViewController.h"
@interface GamesWrapperTests : SenTestCase  <CLLocationManagerDelegate>{
    
    GMAppDelegate *myAppDelegate;
    GMViewController *myViewController;
    UIView *myView;
    
}

@end
