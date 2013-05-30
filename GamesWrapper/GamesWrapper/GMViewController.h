//
//  GMViewController.h
//  GamesWrapper
//
//  Created by Madhusudhan HK on 4/16/13.
//  Copyright (c) 2013 Madhusudhan HK. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GMViewController : UIViewController{
    
     UIActivityIndicatorView *activityIndictr;
     NSArray *restrictedUrlsArray;
    
}
    
   
    

@property (strong, nonatomic) IBOutlet UIWebView *myWebView;
@property (strong, nonatomic) IBOutlet UIImageView *splashImage;


-(NSString *)loadWebViewWithUrl:(NSString *)newUrl;

@end
