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

#import "AccountSelectionViewController.h"
#import "GmailWranglerViewController.h"
#import "AddAccount.h"

@implementation AccountSelectionViewController
@synthesize accounts;

- (void) awakeFromNib {
  //CGRect webFrame = [[UIScreen mainScreen] applicationFrame];
  //table = [[UITableView alloc] initWithFrame:webFrame];
  //table.dataSource = self;
  
  
  //accounts = [[NSMutableArray alloc] init];
  
  // Load data from defaults
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  accounts = [NSMutableArray arrayWithArray:[defaults arrayForKey:@"MailWranglerSettingsArray"]];
  
  if (accounts == nil) {
    accounts = [[NSMutableArray alloc] init];
  } else {
    [accounts retain];
  }
  
  [addButton setTarget:self];
  [addButton setAction:@selector(addAccount)];
  
  [editButton setTarget:self];
  [editButton setAction:@selector(editAccounts)];
}

- (void) addNewAccount:(NSDictionary*) settings {
  [accounts addObject:settings];
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  [defaults setObject:accounts forKey:@"MailWranglerSettingsArray"];
  [self updateTable];
}

- (void) addAccount {
  AddAccount *add = [[AddAccount alloc] init];
  add.accounts = self;
  [navigationController pushViewController:add animated:YES];
}

- (void) editAccounts {
  UITableView *t = self.view;
  if ([t isEditing] == YES) {
    [self.view setEditing:NO animated:YES];
    [editButton setStyle:UIBarButtonItemStylePlain];
    [editButton setTitle:@"Edit"];
  } else {
    [self.view setEditing:YES animated:YES];
    [editButton setStyle:UIBarButtonItemStyleDone];
    [editButton setTitle:@"Done"];
  }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [accounts count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *MyIdentifier = @"MyIdentifier";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:MyIdentifier] autorelease];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
	}
	
  [cell setText:[[accounts objectAtIndex:indexPath.row] objectForKey:@"title"]];
  
	// Set up the cell
	return cell;
}


 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	 // Navigation logic
  GmailWranglerViewController *gm = [[GmailWranglerViewController alloc] init];
  NSDictionary *dic = [accounts objectAtIndex:indexPath.row];
  gm.user = [dic objectForKey:@"user"];
  gm.domain = [dic objectForKey:@"domain"];
  gm.password = [dic objectForKey:@"password"];
  gm.title = [dic objectForKey:@"title"];
  
  //UIViewController *gm = [[accounts objectAtIndex:indexPath.row] objectForKey:@"controller"];

  [navigationController pushViewController:gm animated:YES];
  [gm release];
}

- (void) updateTable {
  [self.view reloadData];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
  return YES;
}

/*
 Override if you support editing the list*/
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
		
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		// Delete the row from the data source
    [accounts removeObjectAtIndex:indexPath.row];
		[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:accounts forKey:@"MailWranglerSettingsArray"];
	}	
	if (editingStyle == UITableViewCellEditingStyleInsert) {
		// Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
	}	
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	//return (interfaceOrientation == UIInterfaceOrientationPortrait);
  return YES;
}
@end
