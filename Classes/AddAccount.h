#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "AccountSelectionViewController.h"

@interface AddAccount : UIViewController <UITableViewDataSource> {
  AccountSelectionViewController *accounts;
  
  UILabel *titleLabel;
  UITextField *titleField;
  UILabel *userLabel;
  UITextField *userField;
  UILabel *passLabel;
  UITextField *passField;
  UILabel *domainLabel;
  UITextField *domainField;
  UITableView *table;
}

@property (nonatomic, retain) AccountSelectionViewController *accounts;

@end
