//
//  GMViewController.m
//  GamesWrapper
//
//  Created by Madhusudhan HK on 4/16/13.
//  Copyright (c) 2013 Madhusudhan HK. All rights reserved.
//

#import "GMViewController.h"
#import "Reachability.h"

@interface GMViewController ()




@end

@implementation GMViewController
@synthesize myWebView;
@synthesize splashImage;



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
	// Do any additional setup after loading the view, typically from a nib.
    
    
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
    NSLog(@"url %@",[webView.request.URL absoluteString]);
    
    //NSLog(@"image frame %@", NSStringFromCGRect(splashImage.frame));
   // NSLog(@"webview frame %@", NSStringFromCGRect(myWebView.frame));
    
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    NSLog(@"did fail load");
    
}


@end
