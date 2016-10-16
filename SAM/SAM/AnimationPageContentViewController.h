//
//  AnimationPageContentViewController.h
//  SAM
//
//  Created by User on 28.09.16.
//  Copyright © 2016 freshtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimationPageContentViewController : UIViewController

@property NSUInteger pageIndex;

@property (strong, nonatomic) UIImageView * imageOne;
@property (strong, nonatomic) UIImageView * imageTwo;
@property (strong, nonatomic) UIImageView * imageTree;

@property NSString * nameImageOne;
@property NSString * nameImageTwo;
@property NSString * nameImageTree;


@property (strong, nonatomic) UILabel * titleLabel;
@property (strong, nonatomic) UILabel * detailLabel;

@property NSString * titleText;
@property NSString * detailText;




@end
