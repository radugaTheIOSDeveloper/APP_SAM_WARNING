//
//  NewPassword.h
//  SAM
//
//  Created by User on 16.11.16.
//  Copyright © 2016 freshtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewPassword : UIViewController


@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *password;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)btnConfirm:(id)sender;

@end
