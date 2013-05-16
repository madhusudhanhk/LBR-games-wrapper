//
//  GMViewController.m
//  GamesWrapper
//
//  Created by Madhusudhan HK on 4/16/13.
//  Copyright (c) 2013 Madhusudhan HK. All rights reserved.
//

#import "GMViewController.h"
#import "Reachability.h"

#import <FacebookSDK/FacebookSDK.h>
@interface GMViewController ()




@end

@implementation GMViewController
@synthesize myWebView;
@synthesize splashImage;



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
	// Do any additional setup after loading the view, typically from a nib.
  
    
   /*
    *** To test FB SDK working just creating API calls *****
    
    // FBSample logic
    // if the session is open, then load the data for our view controller
    if (!FBSession.activeSession.isOpen) {
        // if the session is closed, then we open it here, and establish a handler for state changes
        [FBSession.activeSession openWithCompletionHandler:^(FBSession *session,
                                                             FBSessionState state,
                                                             NSError *error) {
            switch (state) {
                case FBSessionStateClosedLoginFailed:
                {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                        message:error.localizedDescription
                                                                       delegate:nil
                                                              cancelButtonTitle:@"OK"
                                                              otherButtonTitles:nil];
                    [alertView show];
                }case FBSessionStateOpen:{
                    if (FBSession.activeSession.isOpen) {
                        [[FBRequest requestForMe] startWithCompletionHandler:
                         ^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
                             if (!error) {
                                 
                                 
                             }
                         }];
                    }
                }
                default:
                    break;
            }
        }];
    }
    
    *** end FB SDK check ***
    
    
   */
    
     /* add UIActivityIndicatorView to UIView */
    
    
    if(activityIndictr)activityIndictr=nil;
    
    
    
    
    
    activityIndictr = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, activityViewWidth, activityViewHeight)];
    activityIndictr.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    
    activityIndictr.color = [UIColor whiteColor];
    activityIndictr.hidden=NO;
    [activityIndictr startAnimating];
    [self.view addSubview:activityIndictr];
   
    int PlaceX = (self.view.frame.size.width - activityIndictr.frame.size.width)/2;
    int PlaceY = self.view.frame.size.height/2 + activityViewHeight;
    
    
    
    CGRect activityViewFrame = activityIndictr.frame;
    activityViewFrame.origin.x = PlaceX;
    activityViewFrame.origin.y = PlaceY;
    activityIndictr.frame = activityViewFrame;
    
    
    
    
    
      
    
    /* check for internet connection */
    
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != kNotReachable) {
    
        NSString* plistPath = [[NSBundle mainBundle] pathForResource:@"UrlFile" ofType:@"plist"];
        NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
       [self loadWebViewWithUrl:[dict valueForKey:@"live"]];
        
    
        
    }else {
    
        UIAlertView *alt = [[UIAlertView alloc]initWithTitle:nil message:@"You need to be connected to the internet to proceed." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alt    show];
    }
        
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString *)loadWebViewWithUrl:(NSString *)newUrl{
    
    NSString *urlAddress = newUrl;
    
    //Create a URL object.
    NSURL *url = [NSURL URLWithString:urlAddress];
    
    //URL Requst Object
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    //Load the request in the UIWebView.
    [myWebView loadRequest:requestObj];
     return [requestObj.URL absoluteString];
    
    
}
#pragma mark UIWebView delegate 

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;{
    
    return YES;
    
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    
    NSLog(@"start load");
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    NSLog(@"finish load");
    
    
    /* hide splashImage once Webview is loaded */
    splashImage.hidden=YES;
    activityIndictr.hidden=YES;
    
    NSLog(@"url %@",[webView.request.URL absoluteString]);
    
    //NSLog(@"image frame %@", NSStringFromCGRect(splashImage.frame));
   // NSLog(@"webview frame %@", NSStringFromCGRect(myWebView.frame));
    
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    NSLog(@"did fail load");
    
}


@end
