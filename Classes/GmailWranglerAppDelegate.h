//
//  GmailWranglerAppDelegate.h
//  GmailWrangler
//
//  Created by Angelo DiNardi on 7/13/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GmailWranglerViewController;
@class AccountSelectionViewController;

@interface GmailWranglerAppDelegate : NSObject <UIApplicationDelegate> {
	IBOutlet UIWindow *window;
	IBOutlet GmailWranglerViewController *viewController;
  IBOutlet AccountSelectionViewController *accountViewController;
  IBOutlet UINavigationController *navigationController;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) GmailWranglerViewController *viewController;
@property (nonatomic, retain) AccountSelectionViewController *accountViewController;
@property (nonatomic, retain) UINavigationController *navigationController;

@end

