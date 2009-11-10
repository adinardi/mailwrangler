#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface AccountSelectionViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>{
  UITableView *table;
  IBOutlet UINavigationController *navigationController;
  IBOutlet UIBarButtonItem *addButton;
  NSMutableArray *accounts;
  IBOutlet UIBarButtonItem *editButton;
}

@property (nonatomic, retain) NSMutableArray* accounts;

@end
