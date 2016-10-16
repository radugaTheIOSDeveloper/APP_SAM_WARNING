//
//  Enter.h
//  SAM
//
//  Created by User on 22.09.16.
//  Copyright © 2016 freshtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Enter : UIViewController


@property (weak, nonatomic) IBOutlet UIImageView *logo;

@property (weak, nonatomic) IBOutlet UILabel *enterLable;


@property (weak, nonatomic) IBOutlet UITextField *textFieldNumber;

@property (weak, nonatomic) IBOutlet UITextField *textFieldPassword;

@property (weak, nonatomic) IBOutlet UIButton *enterBtn;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)actEnterBtn:(id)sender;

@property (strong, nonatomic) NSString * strTest;

- (IBAction)actNumTel:(id)sender;
- (IBAction)actPass:(id)sender;

@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;

@end
