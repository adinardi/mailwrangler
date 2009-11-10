//
//  GmailWranglerAppDelegate.m
//  GmailWrangler
//
//  Created by Angelo DiNardi on 7/13/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import "GmailWranglerViewController.h"

@implementation GmailWranglerViewController

@synthesize password;
@synthesize user;
@synthesize domain;
@synthesize title;

// Implement loadView if you want to create a view hierarchy programmatically
/*- (void)loadView {

}
*/
/*
 Implement viewDidLoad if you need to do additional setup after loading the view.*/
- (void)viewDidLoad {
	[super viewDidLoad];
  
  CGRect webFrame = [[UIScreen mainScreen] applicationFrame];
  //CGRect webFrame = CGRectMake(0, 0, 10, 10);
	//webFrame.origin.y += 20 + 5.0;	// leave from the URL input field and its label
	//webFrame.size.height -= 40.0;
  webFrame.origin.y = 0;
  webFrame.origin.x = 0;
	myWebView = [[UIWebView alloc] initWithFrame:webFrame];
	myWebView.backgroundColor = [UIColor whiteColor];
	myWebView.scalesPageToFit = YES;
	myWebView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
	myWebView.delegate = self;
	[self.view addSubview: myWebView];

  NSURLRequest *req = [self requestForDomain:self.domain user:self.user password:self.password];
	[myWebView loadRequest:req];
  
  self.navigationItem.title = self.title;
  //UIActivityIndicatorView *indic = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
  //UIBarButtonItem *b = [[UIBarButtonItem alloc] initWithCustomView:indic];
  //self.navigationItem.rightBarButtonItem = b;
}

- (void) webViewDidStartLoad:(UIWebView*)w {
  [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (void) webViewDidFinishLoad:(UIWebView*)w {
  [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (NSURLRequest*) requestForDomain:(NSString*)ndomain user:(NSString*)nuser password:(NSString*)npassword {
  NSMutableString *dom = [NSMutableString string];
  NSMutableString *data = [NSMutableString stringWithString:@"ltmpl=default&ltmplcache=2&continue=http%3A%2F%2Fmail.google.com"];
  
  if ([ndomain compare:@"gmail.com"] == NSOrderedSame) {
    [dom appendString:@"https://www.google.com/accounts/ServiceLoginAuth?service=mail"];
    [data appendString:@"%2Fmail%2F%3F"];
  } else {
    [dom appendString:@"https://www.google.com/a/"];
    [dom appendString:ndomain];
    [dom appendString:@"/LoginAction2?service=mail"];
    
    [data appendString:@"%2Fa%2F"];
    [data appendString:ndomain];
    [data appendString:@"%2F"];
  }
  NSURL *url = [NSURL URLWithString:dom];
  NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
  [req setHTTPMethod:@"POST"];

  [data appendString:@"&service=mail&rm=false&ltmpl=default&ltmpl=default&Email="];
  [data appendString:nuser];
  [data appendString:@"&Passwd="];
  [data appendString:npassword];
  [data appendString:@"&rmShown=1&signIn=Sign+in"];
  
  NSString *postLength = [NSString stringWithFormat:@"%d", [data length]];
  [req setValue:postLength forHTTPHeaderField:@"Content-length"];
  [req setHTTPBody:[data dataUsingEncoding:1]];
  [req setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
  
  return req;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	//return (interfaceOrientation == UIInterfaceOrientationPortrait);
  return YES;
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	// Release anything that's not essential, such as cached data
}


- (void)dealloc {
	[super dealloc];
}

@end
