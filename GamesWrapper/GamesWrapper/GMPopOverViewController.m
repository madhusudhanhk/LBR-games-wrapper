//
//  GMPopOverViewController.m
//  GamesWrapper
//
//  Created by Madhusudhan HK on 5/31/13.
//  Copyright (c) 2013 Madhusudhan HK. All rights reserved.
//

#import "GMPopOverViewController.h"

@interface GMPopOverViewController ()

@end

@implementation GMPopOverViewController
@synthesize myWebView;
@synthesize myNavigationBar;
@synthesize urlLink;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    myNavigationBar.tintColor=UIColorFromRGB(0xf20025);
    
    NSString *urlAddress = urlLink;
    
    //Create a URL object.
    NSURL *url = [NSURL URLWithString:urlAddress];
    
    //URL Requst Object
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    //Load the request in the UIWebView.
    [myWebView loadRequest:requestObj];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
   
    [self setMyWebView:nil];
    [self setMyNavigationBar:nil];
    [super viewDidUnload];
}
- (IBAction)cancelViewController:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


#pragma mark UIWebView delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;{
   
     return YES;
    
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
 
      
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
  
    
}

@end
