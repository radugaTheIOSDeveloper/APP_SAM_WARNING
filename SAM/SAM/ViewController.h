//
//  ViewController.h
//  SAM
//
//  Created by User on 05.09.16.
//  Copyright © 2016 freshtech. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PaymentController;

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
@property (assign) NSInteger rubles;
@property (assign) NSInteger cntCoin;
@property (strong, nonatomic) NSString * tokenUser;
@property (strong, nonatomic) NSString *returnedString;
@property (weak, nonatomic) IBOutlet UILabel *LabelInfo;
@property (weak, nonatomic) IBOutlet UIButton *btnOutlet;
@property (weak, nonatomic) IBOutlet UIButton *backButtonOutl;
- (IBAction)actBackButton:(id)sender;

@end

