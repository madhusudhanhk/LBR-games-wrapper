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

-(void)loadWebViewWithUrl:(NSString *)newUrl;


@end

@implementation GMViewController
@synthesize myWebView;
@synthesize splashImage;
@synthesize myArray;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
	// Do any additional setup after loading the view, typically from a nib.
    
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != kNotReachable) {
    
    }else {
    
        UIAlertView *alt = [[UIAlertView alloc]initWithTitle:nil message:@"You need to be connected to the internet to proceed." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alt    show];
    }
    
    NSString* plistPath = [[NSBundle mainBundle] pathForResource:@"UrlFile" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    [self loadWebViewWithUrl:[dict valueForKey:@"live"]];
    
 
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadWebViewWithUrl:(NSString *)newUrl{
    
    
    NSString *urlAddress = newUrl;
    
    //Create a URL object.
    NSURL *url = [NSURL URLWithString:urlAddress];
    
    //URL Requst Object
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    //Load the request in the UIWebView.
    [myWebView loadRequest:requestObj];
    
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
    
    splashImage.hidden=YES;
    
    NSLog(@"image frame %@", NSStringFromCGRect(splashImage.frame));
    NSLog(@"webview frame %@", NSStringFromCGRect(myWebView.frame));
    
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    NSLog(@"did fail load");
    
}


@end
