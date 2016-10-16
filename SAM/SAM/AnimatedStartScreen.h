//
//  AnimatedStartScreen.h
//  SAM
//
//  Created by User on 29.09.16.
//  Copyright © 2016 freshtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimatedStartScreen : UIViewController


@property (weak, nonatomic) IBOutlet UIPageControl *pageController;

- (IBAction)skipBtn:(id)sender;

@property (strong, nonatomic) UIImageView * imageOne;
@property (strong, nonatomic) UIImageView * imageTwo;
@property (strong, nonatomic) UIImageView * imageTree;

@property NSString * nameImageOne;
@property NSString * nameImageTwo;
@property NSString * nameImageTree;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *detailLablel;

@property (strong, nonatomic) NSArray *pageImageOne;
@property (strong, nonatomic) NSArray *pageImageTwo;
@property (strong, nonatomic) NSArray * pageTitle;
@property (strong, nonatomic) NSArray * pageDetail;


@property (assign, nonatomic) NSInteger costl;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

- (IBAction)actNextBtn:(id)sender;

//animated status
@property (assign, nonatomic) BOOL animStatusOne;
@property (assign, nonatomic) BOOL animStatusTwo;
@property (assign, nonatomic) BOOL animStatusTree;
@property (assign, nonatomic) BOOL animStatusFour;
@property (assign, nonatomic) NSInteger positionScroll;


@property (strong, nonatomic) NSArray * statusArray;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
