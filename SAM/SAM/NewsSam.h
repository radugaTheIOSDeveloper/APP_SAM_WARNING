//
//  NewsSam.h
//  SAM
//
//  Created by Георгий Зуев on 10/08/2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageContentViewControllerNews.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewsSam : UIViewController <UIPageViewControllerDataSource>
@property (strong, nonatomic) UIPageViewController *pageViewController;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)byCoinAct:(id)sender;

@property (strong, nonatomic) NSString * stringQR;
@property (strong, nonatomic) NSString * dateQR;
@property (strong, nonatomic) NSString * timeQR;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *revealButtonItem;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;

@property (weak, nonatomic) IBOutlet UIView *viewPage;
@property (strong, nonatomic) NSArray *pageBGImage;

@end

NS_ASSUME_NONNULL_END
