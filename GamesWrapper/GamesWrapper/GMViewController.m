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
#import "Flurry.h"
#import "TweetComposeViewController.h"
#import "FacebookController.h"
#import "R1Emitter.h"






@interface GMViewController ()
-(BOOL)checkForRestrictedUrls:(NSString *)urlSrting;
-(void)launchPopOverViewController:(NSString *)urlString;
-(void)launchPopOverControllerPromo:(NSString *)urlString;
-(void)cookiesCheckForLoginDetail;




@end

@implementation GMViewController
@synthesize myWebView;
@synthesize splashImage;
@synthesize toolBar;
@synthesize popOverControl;
@synthesize bankingButton;
//@synthesize controllerPopup;




- (void)viewDidLoad
{
    [super viewDidLoad];
    
   
    
    /* start flurry session */
    [Flurry startSession:Flurry_API_KEY];
    
    /* Flurry PageView count */
    [Flurry logPageView];
    
    
    /* alloc restricted urls into a array from plist */
    
    if(restrictedUrlsArray)restrictedUrlsArray=nil;
    
    NSString* plistPath = [[NSBundle mainBundle] pathForResource:@"MobileLobbyUrl" ofType:@"plist"];
    restrictedUrlsArray = [[NSArray alloc]initWithContentsOfFile:plistPath];
    
    
	// Do any additional setup after loading the view, typically from a nib.
  
    /*
   
   // *** To test FB SDK working just creating API calls *****
    
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
                             
                               NSSet *returnValu = [FBSettings loggingBehavior];
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
    
   // *** end FB SDK check ***
    
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
    
    // * add Observer when the set of cookies changes * //
        [[NSNotificationCenter defaultCenter] addObserver:self
                                         selector:@selector(cookiesCheckForLoginDetail)
                                             name:NSHTTPCookieManagerCookiesChangedNotification
                                           object:nil];
    
    
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [toolBar setBackgroundImage:[UIImage imageNamed:@"background-small.png"] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
    }
    else{
       //
        [toolBar setBackgroundImage:[UIImage imageNamed:@"ipad-bg.png"] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
    }
    
    //Disable barbutton item
//bankingButton = [[UIBarButtonItem alloc]init];
    
    
     bankingButton.enabled =  NO;
        
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    /* hide splashImage once Webview is loaded */
    splashImage.hidden=YES;
    activityIndictr.hidden=YES;
    
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

-(BOOL )checkForRestrictedUrls:(NSString *)urlSrting{
    
    
    
  
    
    for(int urlCount = 0 ; urlCount < [restrictedUrlsArray count] ; urlCount ++){
        
        
        
        NSString *restrictedString = [restrictedUrlsArray objectAtIndex:urlCount];
        
        
       
        
        if ([urlSrting rangeOfString:restrictedString options:NSRegularExpressionSearch].location != NSNotFound){
            
           [self launchPopOverViewController:urlSrting];
            
            
          
            return NO;
        }
        
       
    }
   
   
    
    return YES;
    
    
}

-(void)launchPopOverViewController:(NSString *)urlString{
    
    
    if(popOverViewControoler)popOverViewControoler=nil;
    

    
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
        popOverViewControoler = [[GMPopOverViewController alloc] initWithNibName:@"GMPopOverViewController_iPhone" bundle:nil];
        popOverViewControoler.urlLink=urlString;
        
        
    } else {
        
        popOverViewControoler = [[GMPopOverViewController alloc] initWithNibName:@"GMPopOverViewController_iPad" bundle:nil];
        popOverViewControoler.urlLink=urlString;
    }
    
    
     [self presentViewController:popOverViewControoler animated:YES completion:nil];
    
}
#pragma mark UIWebView delegate 

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;{
    
    
     NSString *str =[request.URL absoluteString];
    
    BOOL resultValue =[self checkForRestrictedUrls:str];
    
    
    
    return resultValue;
    
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    
   // NSLog(@"start load");
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
   // NSLog(@"finish load");
    
    
    /* hide splashImage once Webview is loaded */
    splashImage.hidden=YES;
    [activityIndictr stopAnimating];
    activityIndictr.hidden=YES;
    
    
   
    
    
    
    /*  Add an event for url loaded in UIWebView  */
    
    NSDictionary *dictionary =
    [NSDictionary dictionaryWithObjectsAndKeys:[webView.request.URL absoluteString],
     @"URL",
     nil];
    
    [Flurry logEvent:Flurry_URL_loadedInWebView withParameters:dictionary timed:YES];
    
    
    /*
    NSHTTPCookieStorage *sharedHTTPCookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *cookies = [sharedHTTPCookieStorage cookiesForURL:[NSURL URLWithString:[webView.request.URL absoluteString]]];
    NSEnumerator *enumerator = [cookies objectEnumerator];
    NSHTTPCookie *cookie;
    while (cookie = [enumerator nextObject]) {
   
        NSLog(@"COOKIE{name: %@, value: %@}", [cookie name], [cookie value]);
        
        if([[cookie name] isEqualToString:@"LIL_LOGIN"]){
            
        }
    
    }
    NSLog(@"url %@",[webView.request.URL absoluteString]);
   
    */
    
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    NSLog(@"did fail load");
    
}

#pragma mark Scocial Media connect


-(void)callTwitter{
    
  
    //* Check for iOS version *//
    
    
    if (SYSTEM_VERSION_LESS_THAN(@"5.0")) {
        
        UIAlertView *aletView =[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Update to iOS 5.0 +" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];;
        [aletView show];
        
        
    }
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"5.0")) {
        TWTweetComposeViewController *tweetComposeViewController = [[TWTweetComposeViewController alloc] init];
        [tweetComposeViewController setCompletionHandler:^(TWTweetComposeViewControllerResult result) {
            [self dismissModalViewControllerAnimated:YES];
        }];
        [self presentModalViewController:tweetComposeViewController animated:YES];
    }
[[R1Emitter sharedInstance] emitEvent:@"Share with Twitter "];
    
}


-(void)callFacebook{
    
    
    //* Check for iOS version *//
    
    
  
    
    if (SYSTEM_VERSION_LESS_THAN(@"6.0")) {
    
       
        FacebookController * facebookViewController = [[FacebookController alloc] initWithNibName: @"Facebook_iphone"
                                                                                           bundle: nil];
        UINavigationController * navController = [[UINavigationController alloc] initWithRootViewController: facebookViewController];
        navController.modalPresentationStyle = UIModalPresentationFormSheet;
        [self presentModalViewController: navController animated: YES];
        
        
    }else if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"6.0")) {
    
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
        {
            SLComposeViewController*fbViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
            
            [fbViewController setInitialText:@""];
            [fbViewController addImage:[UIImage imageNamed:@""]];
            [self presentViewController:fbViewController animated:YES completion:nil];
        }
    }
    
    [[R1Emitter sharedInstance] emitEvent:@"Share with Facebook "];

}
-(void)cookiesCheckForLoginDetail{
    
    
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [cookieJar cookies]) {
      
        //NSLog(@"COOKIE{name: %@, value: %@}", [cookie name], [cookie value]);
        
        if(![[cookie name] isEqualToString:@"LIL_Login"]){
            
            NSLog(@"Disable Banking button here");
            NSLog(@"COOKIE{name: %@}", [cookie name]);
self.bankingButton.enabled =  NO;
        }else {
        
            NSLog(@"Enable Banking button here");
            NSLog(@"COOKIE{name: %@}", [cookie name]);
        self.bankingButton.enabled =  YES;
            [[R1Emitter sharedInstance] emitEvent:@"User Login "];
            break;
            
        }
    }
}




- (void)showEmail {
    // Email Subject
    // NSString *emailTitle = @"Test Email";
    NSString *emailTitle = @"";
    // Email Content
    //NSString *messageBody = @"iOS programming is so fun!";
    NSString *messageBody = @"";
    // To address
    // NSArray *toRecipents = [NSArray arrayWithObject:@"support@appcoda.com"];
    NSArray *toRecipents = [NSArray arrayWithObject:@""];
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    if ([MFMailComposeViewController canSendMail]) {
        // show a mail composition view
        mc.mailComposeDelegate = self;
        [mc setSubject:emailTitle];
        [mc setMessageBody:messageBody isHTML:NO];
        [mc setToRecipients:toRecipents];
        // Present mail viewcontroller on screen
        [self presentViewController:mc animated:YES completion:NULL];
    }
    //Radium one event log for mail
[[R1Emitter sharedInstance] emitEvent:@"User Mail "];
    
    
    
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            //Radium one event log for mail
            [[R1Emitter sharedInstance] emitEvent:@"User Mail "];
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            //Radium one event log for mail
            [[R1Emitter sharedInstance] emitEvent:@"User Mail sent failed "];
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}




-(IBAction)sharePress:(UIBarButtonItem*)sender{
    NSLog(@"notifyShare");
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        actionChk = [[UIActionSheet alloc]initWithTitle:@"Share" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Facebook",@"Twitter",@"Mail",@"SMS", nil];
        [actionChk showInView:self.view];
    }
   else{
//        
//        if ([popOverControl isPopoverVisible]) {
//            [popOverControl dismissPopoverAnimated:YES];
//        } else {
//             UIBarButtonItem *tappedButton = (UIBarButtonItem *)sender;
//              popOverControl = [[UIPopoverController alloc]initWithContentViewController:controllerPopup];
//            [popOverControl presentPopoverFromBarButtonItem:tappedButton permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
           //            //the rectangle here is the frame of the object that presents the popover,
//            //in this case, the UIButton…
//            UIBarButtonItem *tappedButton = (UIBarButtonItem *)sender;
//            
//            // If the master list popover is showing, dismiss it before presenting the popover from the bar button item.
////            if (self.popOverControl != nil) {
////                [self.popOverControl dismissPopoverAnimated:YES];
////            }
//            
//            // If the popover is already showing from the bar button item, dismiss it. Otherwise,
          //  present it.
//            //if (self.popOverControl.popoverVisible == NO) {
//                [self.popOverControl presentPopoverFromBarButtonItem:tappedButton permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
//           // }
////            else {
////                [self.popOverControl dismissPopoverAnimated:YES];
            
            actionChk = [[UIActionSheet alloc]initWithTitle:@"Share" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Facebook",@"Twitter",@"Mail",@"SMS", nil];
            [actionChk showInView:self.view];
        
            }
            
            
       // }
    //}
    
}

-(void)notifyMessage{
    //    NSString *phonenostring = @"Hello";
    //    NSString *sms = [[NSString alloc] initWithFormat:@"sms:%@",phonenostring];
    //                     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:sms]];
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
    if([MFMessageComposeViewController canSendText])
    {
        controller.body = @"";
        controller.messageComposeDelegate = self;
        // [self presentModalViewController:controller animated:YES];
        [self presentViewController:controller animated:YES completion:nil];
    }
    //Radium one event log for mail
    [[R1Emitter sharedInstance] emitEvent:@"User SMS "];
}
- (void) messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    switch(result)
    {
        case MessageComposeResultCancelled: break; //handle cancelled event
        case MessageComposeResultFailed:{
            NSString *alertString = @"Unknown Error. Failed to send message";
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:alertString delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            //Radium one event log for SMS
            [[R1Emitter sharedInstance] emitEvent:@"User SMS failed"];
            break; //handle failed event
        }
        case MessageComposeResultSent:
            NSLog(@"SMS sent");
            //Radium one event log for SMS
            [[R1Emitter sharedInstance] emitEvent:@"User SMS sent"];
            break; //handle sent event
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"Button index:%i", buttonIndex);
    
    switch (buttonIndex) {
        case 3:
            NSLog(@"Message");
            [self notifyMessage];
            break;
        case 0:
            NSLog(@"FaceBook");
            [self callFacebook];
            break;
        case 2:
            NSLog(@"mailTo");
            [self showEmail];
            break;
            
        case 1:
            NSLog(@"Twitter");
            [self callTwitter];
            break;
            
        default:
            NSLog(@"ButtonIndex:%d",buttonIndex);
    }
}

-(IBAction)bankingAction:(id)sender{
    
    [self loadWebViewWithUrl:[NSString stringWithFormat:@"https://mobile.ladbrokes.com/lobby/bingo/banking?retUrl=%@",[myWebView.request.URL absoluteString]]];
    //Radium one event log for Banking Page
    [[R1Emitter sharedInstance] emitEvent:@"Banking Page redirection"];
    
    //  [self loadWebViewWithUrl:@"https://mobile.ladbrokes.com/lobby/bingo/banking?retUrl=http://mobile.ladbrokes.com/games"];
    
  //  [[R1Emitter sharedInstance] emitEvent:@"Banking Despriction" withParameters:@{"Banking":"value"}];
    
}
-(IBAction)helpAction:(id)sender{
    
    
    NSString *url = @"http://mobile.ladbrokes.com/lobby/apps/games/help";
    [self launchPopOverViewController:url];
    
          //[self loadWebViewWithUrl:@"http://mobile.ladbrokes.com/lobby/apps/games/help"];
    //Radium one event log for Help Page
    [[R1Emitter sharedInstance] emitEvent:@"Help Page redirection"];
}
-(IBAction)appsAction:(id)sender{
    //* ladbrokes-sportsbook-lp is developer name , its list all applications developed by this developer. All the Apps available only in UK market *//
    
    
    NSURL *appItunesUrl = [NSURL URLWithString:@"https://itunes.apple.com/gb/artist/ladbrokes-sportsbook-lp/id375820903"];
    [[UIApplication sharedApplication] openURL:appItunesUrl];    //Radium one event log for Apps Page
    [[R1Emitter sharedInstance] emitEvent:@"Apps Page redirection"];
}
-(IBAction)promoAction:(id)sender{
    
    NSString *url = @"http://mobile.ladbrokes.com/lobby/games/promotions";
    [self launchPopOverViewController:url];
      // [self loadWebViewWithUrl:@"http://mobile.ladbrokes.com/lobby/games/promotions"];
    //Radium one event log for promo Page
    [[R1Emitter sharedInstance] emitEvent:@"Promo Page redirection"];
}



@end
