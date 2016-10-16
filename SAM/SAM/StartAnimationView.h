//
//  StartAnimationView.h
//  SAM
//
//  Created by User on 28.09.16.
//  Copyright © 2016 freshtech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnimationPageContentViewController.h"


@interface StartAnimationView : UIViewController <UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) UIButton * btnNext;


@property (strong, nonatomic) NSArray *pageTitles;
@property (strong, nonatomic) NSArray *pageDetail;
@property (strong, nonatomic) NSArray *pageImageOne;
@property (strong, nonatomic) NSArray *pageImageTwo;
@property (strong, nonatomic) NSArray *pageImageTree;
@property (assign, nonatomic) NSInteger indexPlus;



@end
