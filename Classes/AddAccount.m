/*
  Copyright 2008-2009 Angelo R. DiNardi (angelo@dinardi.name)

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
*/

#import "AddAccount.h"

@implementation AddAccount
@synthesize accounts;

- (void) viewDidLoad {  

  self.view.backgroundColor = [UIColor darkGrayColor];

  CGRect titleRectLabel = CGRectMake(5, 12, 95, 20);
  titleLabel = [[UILabel alloc] initWithFrame:titleRectLabel];
  titleLabel.text = @"Title";
  //titleLabel.backgroundColor = [UIColor clearColor];
  //titleLabel.textColor = [UIColor whiteColor];
  titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont labelFontSize]];
  
  CGRect titleRectField = CGRectMake(100, 12, 200, 30);
  titleField = [[UITextField alloc] initWithFrame:titleRectField];
  titleField.borderStyle = UITextBorderStyleNone;
  titleField.clearButtonMode = UITextFieldViewModeWhileEditing;
  titleField.autocapitalizationType = UITextAutocapitalizationTypeNone;
  titleField.placeholder = @"My Gmail Account";

  CGRect lrect = CGRectMake(5, 12, 95, 20);
  userLabel = [[UILabel alloc] initWithFrame:lrect];
  userLabel.text = @"Username";
  userLabel.font = [UIFont boldSystemFontOfSize:[UIFont labelFontSize]];
  
  CGRect rect = CGRectMake(100, 12, 200, 30);
  userField = [[UITextField alloc] initWithFrame:rect];
  [userField setBorderStyle:UITextBorderStyleNone];
  userField.autocapitalizationType = UITextAutocapitalizationTypeNone;
  userField.autocorrectionType = UITextAutocorrectionTypeNo;
  userField.keyboardType = UIKeyboardTypeEmailAddress;
  userField.clearButtonMode = UITextFieldViewModeWhileEditing;
  userField.placeholder = @"username";
  
  CGRect domainRectLabel = CGRectMake(5, 12, 95, 20);
  domainLabel = [[UILabel alloc] initWithFrame:domainRectLabel];
  [domainLabel setText:@"Domain"];
  domainLabel.font = [UIFont boldSystemFontOfSize:[UIFont labelFontSize]];
  
  domainField = [[UITextField alloc] initWithFrame:CGRectMake(100, 12, 200, 30)];
  domainField.text = @"gmail.com";
  domainField.borderStyle = UITextBorderStyleNone;
  domainField.autocapitalizationType = UITextAutocapitalizationTypeNone;
  domainField.autocorrectionType = UITextAutocorrectionTypeNo;
  domainField.keyboardType = UIKeyboardTypeURL;
  domainField.clearButtonMode = UITextFieldViewModeWhileEditing;
  
  passLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 12, 95, 20)];
  passLabel.text = @"Password";
  passLabel.font = [UIFont boldSystemFontOfSize:[UIFont labelFontSize]];
  
  passField = [[UITextField alloc] initWithFrame:CGRectMake(100, 12, 200, 30)];
  passField.borderStyle = UITextBorderStyleNone;
  passField.secureTextEntry = YES;
  passField.clearButtonMode = UITextFieldViewModeWhileEditing;
  passField.placeholder = @"mypassword";
  
  
  //[self.view addSubview:titleLabel];
  //[self.view addSubview:titleField];
  //[self.view addSubview:userLabel];
  //[self.view addSubview:userField];
  //[self.view addSubview:domainLabel];
  //[self.view addSubview:domainField];
  //[self.view addSubview:passLabel];
  //[self.view addSubview:passField];
  
  CGRect frame = [[UIScreen mainScreen] applicationFrame];
  frame.origin.y = 0;
  table = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
  [table setDataSource:self];
  [table setScrollEnabled:NO];
  [self.view addSubview:table];
  
  UILabel *domainHelp = [[UILabel alloc] initWithFrame:CGRectMake(20, 200, 300, 50)];
  domainHelp.text = @"Change the domain if you are using Google Apps for Your Domain.";
  domainHelp.backgroundColor = [UIColor clearColor];
  domainHelp.lineBreakMode = UILineBreakModeWordWrap;
  domainHelp.numberOfLines = 2;
  //domainHelp.textColor = [UIColor whiteColor];
  [self.view addSubview:domainHelp];
  [domainHelp release];
  
  self.navigationItem.hidesBackButton = YES;
  self.navigationItem.title = @"New Account";
  
  UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelAdd)];
  self.navigationItem.leftBarButtonItem = cancel;
  [cancel release];
  
  UIBarButtonItem *add = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(doneAdd)];
  self.navigationItem.rightBarButtonItem = add;
  [add release];
}

- (void) doneAdd {
  if ([userField.text length] > 0 && [domainField.text length] > 0 && [passField.text length] > 0 && [titleField.text length] > 0) {
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:userField.text, @"user", domainField.text, @"domain", passField.text, @"password", titleField.text, @"title", nil];
    [accounts addNewAccount:dic];
    [dic release];
    [self.navigationController popViewControllerAnimated:YES];
  } else {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Fill in all fields before adding."
        delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];	
    [alert release];
  }
}

- (void) cancelAdd {
  [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tb {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *titleCell = [[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:nil];
    [titleCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    UILabel *l;
    UITextField *tf;
    
    switch(indexPath.row) {
      case 0:
        l = titleLabel;
        tf = titleField;
        break;
      case 1:
        l = userLabel;
        tf = userField;
        break;
      case 2:
        l = passLabel;
        tf = passField;
        break;
      case 3:
        l = domainLabel;
        tf = domainField;
        break;
    }
    
    [titleCell.contentView addSubview:l];
    [titleCell.contentView addSubview:tf];
    [titleCell layoutSubviews];
    return titleCell;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	//return (interfaceOrientation == UIInterfaceOrientationPortrait);
  return YES;
}
@end
