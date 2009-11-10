//
//  GmailWranglerAppDelegate.m
//  GmailWrangler
//
//  Created by Angelo DiNardi on 7/13/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import "GmailWranglerAppDelegate.h"
#import "AccountSelectionViewController.h"
#import "GmailWranglerViewController.h"

@implementation GmailWranglerAppDelegate

@synthesize window;
@synthesize viewController;
@synthesize accountViewController;
@synthesize navigationController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {	
	
	// Override point for customization after app launch	
  [window addSubview:navigationController.view];
	[window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
	[window release];
	[super dealloc];
}


@end
