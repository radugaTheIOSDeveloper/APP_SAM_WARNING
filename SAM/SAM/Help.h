//
//  Help.h
//  SAM
//
//  Created by User on 05.09.16.
//  Copyright © 2016 freshtech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageContentViewController.h"


@interface Help : UIViewController <UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *revealButtonItem;

@property (strong, nonatomic) NSArray *pageTitles;
@property (strong, nonatomic) NSArray *pageBGImage;
@property (strong, nonatomic) NSArray *pageLogoImaage;
@property (strong, nonatomic) NSArray *pageDetail;
@property (strong, nonatomic) NSArray *pageTextInfo;


@end
