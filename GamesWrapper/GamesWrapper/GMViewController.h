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
//#import "GMPromoViewController.h"

@interface GMViewController : UIViewController<MFMailComposeViewControllerDelegate,UIActionSheetDelegate,MFMessageComposeViewControllerDelegate,UIPopoverControllerDelegate>{
    
     UIActivityIndicatorView *activityIndictr;
    
     NSArray *restrictedUrlsArray;
    GMPopOverViewController *popOverViewControoler;
    
    UIActionSheet *actionChk;
    UIPopoverController *popOverControl;
    UIToolbar *toolBar;
    GMViewController *controllerPopup;
    UIBarButtonItem *bankingButton;

}
    
   
    

@property (strong, nonatomic) IBOutlet UIWebView *myWebView;
@property (strong, nonatomic) IBOutlet UIImageView *splashImage;
@property (strong, nonatomic) IBOutlet  UIPopoverController *popOverControl;
@property (strong, nonatomic) IBOutlet UIToolbar *toolBar;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *bankingButton;
//@property (strong, nonatomic) IBOutlet GMViewController *controllerPopup;
@property (nonatomic, strong) id lastTappedButton;
-(NSString *)loadWebViewWithUrl:(NSString *)newUrl;
-(IBAction)bankingAction:(id)sender;

-(IBAction)sharePress:(UIBarButtonItem*)sender;
//-(IBAction)callTwitter:(id)sender;
//-(IBAction)callFacebook:(id)sender;
-(IBAction)helpAction:(id)sender;
-(IBAction)appsAction:(id)sender;
-(IBAction)promoAction:(id)sender;

@end
