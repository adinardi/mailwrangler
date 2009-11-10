//
//  GmailWranglerViewController.h
//  GmailWrangler
//
//  Created by Angelo DiNardi on 7/13/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GmailWranglerViewController : UIViewController <UIWebViewDelegate>{
  UIWebView *myWebView;
  NSString *domain;
  NSString *user;
  NSString *password;
  NSString *title;
}

@property (nonatomic, retain) NSString *domain;
@property (nonatomic, retain) NSString *user;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, retain) NSString *title;

@end

