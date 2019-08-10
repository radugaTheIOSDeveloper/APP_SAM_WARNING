//
//  ActiveViewController.h
//  SAM
//
//  Created by User on 09.08.2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActiveViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *TableView;
- (IBAction)byCoin:(id)sender;
-(void) refreshView: (UIRefreshControl *) refresh;

@property (strong, nonatomic) NSString * stringQR;
@property (strong, nonatomic) NSString * dateQR;
@property (strong, nonatomic) NSString * timeQR;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *revealButtonItem;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;
@end
