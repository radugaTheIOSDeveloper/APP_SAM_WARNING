//
//  SetPassController.h
//  SAM
//
//  Created by User on 24.10.16.
//  Copyright © 2016 freshtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetPassController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *registerLabel;

@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@property (weak, nonatomic) IBOutlet UITextField *pasTextField;
- (IBAction)actTextField:(id)sender;
- (IBAction)registrBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;

@end
