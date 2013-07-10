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
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface GMViewController : UIViewController<MFMailComposeViewControllerDelegate,UIActionSheetDelegate,MFMessageComposeViewControllerDelegate>{
    
     UIActivityIndicatorView *activityIndictr;
     NSArray *restrictedUrlsArray;
    GMPopOverViewController *popOverViewControoler;
    
    UIActionSheet *actionChk;
    UIPopoverController *popOverControl;
    UIToolbar *toolBar;
    GMViewController *controllerPopup;
    
}
    
   
    

@property (strong, nonatomic) IBOutlet UIWebView *myWebView;
@property (strong, nonatomic) IBOutlet UIImageView *splashImage;
@property (strong, nonatomic) IBOutlet  UIPopoverController *popOverControl;
@property (strong, nonatomic) IBOutlet UIToolbar *toolBar;

-(NSString *)loadWebViewWithUrl:(NSString *)newUrl;


-(IBAction)sharePress;
-(IBAction)callTwitter:(id)sender;
-(IBAction)callFacebook:(id)sender;

@end
