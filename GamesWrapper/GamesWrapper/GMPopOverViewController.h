//
//  GMPopOverViewController.h
//  GamesWrapper
//
//  Created by Madhusudhan HK on 5/31/13.
//  Copyright (c) 2013 Madhusudhan HK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GMPopOverViewController : UIViewController

- (IBAction)cancelViewController:(id)sender;

@property (strong, nonatomic) IBOutlet UINavigationBar *myNavigationBar;
@property (strong, nonatomic) IBOutlet UIWebView *myWebView;
@property (strong , nonatomic) NSString *urlLink;



@end
