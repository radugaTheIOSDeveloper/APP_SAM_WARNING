//
//  RegistrClass.h
//  SAM
//
//  Created by User on 22.09.16.
//  Copyright © 2016 freshtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistrClass : UIViewController


@property (weak, nonatomic) IBOutlet UIImageView *logoSAM;
@property (weak, nonatomic) IBOutlet UILabel *lableRegist;

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextField *pasTextField;

@property (weak, nonatomic) IBOutlet UIImageView *line;
@property (weak, nonatomic) IBOutlet UIImageView *lineTwo;
@property (weak, nonatomic) IBOutlet UIButton *btnRegistr;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)actBtnRegistr:(id)sender;
- (IBAction)actTextField:(id)sender;
- (IBAction)actPasTextField:(id)sender;
@property (strong , nonatomic) NSString * demoString;
@property (strong , nonatomic) NSString * demoTel;



//array


@end
