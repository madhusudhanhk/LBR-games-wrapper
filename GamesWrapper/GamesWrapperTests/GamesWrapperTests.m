//
//  GamesWrapperTests.m
//  GamesWrapperTests
//
//  Created by Madhusudhan HK on 4/16/13.
//  Copyright (c) 2013 Madhusudhan HK. All rights reserved.
//

#import "GamesWrapperTests.h"
#import "GMViewController.h"
@implementation GamesWrapperTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
    GMViewController *otherViewCntrl = [GMViewController new];
    
    STAssertEqualObjects(0,  0, @"both array equal");
    
    //STFail(@"Unit tests are not implemented yet in GamesWrapperTests");
}

@end
