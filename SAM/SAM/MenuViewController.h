//
//  MenuViewController.h
//  SAM
//
//  Created by User on 14.10.16.
//  Copyright © 2016 freshtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SWUITableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *label;

@end


@interface MenuViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)btnClose:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *closeOtl;

@end
