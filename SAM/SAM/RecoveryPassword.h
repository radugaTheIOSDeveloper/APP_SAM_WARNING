//
//  RecoveryPassword.h
//  SAM
//
//  Created by User on 15.11.16.
//  Copyright © 2016 freshtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecoveryPassword : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (weak, nonatomic) IBOutlet UIImageView *lineOne;

@property (weak, nonatomic) IBOutlet UIButton *btnRecovey;

- (IBAction)recoveryAct:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *textFieldNum;
- (IBAction)textFieldActTel:(id)sender;


@end
