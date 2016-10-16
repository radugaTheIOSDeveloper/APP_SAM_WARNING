//
//  PageContentViewController.h
//  SAM
//
//  Created by User on 26.09.16.
//  Copyright © 2016 freshtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageContentViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property NSString *titleText;
//
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property NSString * imageBG;
//
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property  NSString * imageLogo;
//
@property (weak, nonatomic) IBOutlet UILabel *detailLable;
@property NSString * detailText;
//
@property (weak, nonatomic) IBOutlet UITextView *textField;
@property NSString * textInfo;
//
@property NSUInteger pageIndex;

@end
