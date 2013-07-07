//
//  GMViewController.h
//  GamesWrapper
//
//  Created by Madhusudhan HK on 4/16/13.
//  Copyright (c) 2013 Madhusudhan HK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GMPopOverViewController.h"
#import <Twitter/Twitter.h>


@interface GMViewController : UIViewController{
    
     UIActivityIndicatorView *activityIndictr;
     NSArray *restrictedUrlsArray;
    GMPopOverViewController *popOverViewControoler;
    
    
}
    
   
    

@property (strong, nonatomic) IBOutlet UIWebView *myWebView;
@property (strong, nonatomic) IBOutlet UIImageView *splashImage;


-(NSString *)loadWebViewWithUrl:(NSString *)newUrl;


-(IBAction)callTwitter:(id)sender;
-(IBAction)callFacebook:(id)sender;

@end
