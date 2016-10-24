//
//  ConfirmRegister.h
//  SAM
//
//  Created by User on 03.10.16.
//  Copyright © 2016 freshtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfirmRegister : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UITextField *confirmNumber;

@property (strong, nonatomic) NSString * saveTelephone;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)actConfirm:(id)sender;
- (IBAction)buttonConfirm:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *labelInfo;

@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;


@end
