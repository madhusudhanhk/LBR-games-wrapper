//
//  GMConstants.h
//  GamesWrapper
//
//  Created by Madhusudhan HK on 5/7/13.
//  Copyright (c) 2013 Madhusudhan HK. All rights reserved.
//

#import <Foundation/Foundation.h>


/*
 *  System Versioning Preprocessor Macros
 */

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


 
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]



//Constants for Facebook and Flurry Integration


//#define Facebook_APP_ID @"164708133700507" // Production Ladbrokes Client Account app key
#define Facebook_APP_ID @"279084948895628" // UAT Ladbrokes Client Account app key
//#define Facebook_APP_ID @"390115054437032" // LBR test account ladbrokesgames@gmail.com , Password : Aditi01*

//#define Flurry_API_KEY @"RCDDP9Q8JXFQ76DPQBYS" //  Production  Ladbrokes Client account
#define Flurry_API_KEY @"N68WNFJW2P6RNRHVWP9V" //  UAT  Ladbrokes Client account


#define Flurry_Applaunched @"Games Wrapper App Launched"
#define Flurry_LocationManagerAllow @" User enabled location manager "
#define Flurry_LocationManagerDontAllow @" User disabled location manager"
#define Flurry_UIWebViewLaunched @"Games pages is launched"
#define Flurry_SafariLaunched @"Safari is launched"
#define Flurry_AppClosed @"App closed"
#define Flurry_URL_loadedInWebView @"Accessed URL in the App "
#define Flurry_URL_loadedInSafari @"Accessed URL in the Safari "



#define activityViewWidth 100
#define activityViewHeight 100