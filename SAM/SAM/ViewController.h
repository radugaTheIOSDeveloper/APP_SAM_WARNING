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
@property (strong, nonatomic) NSString * promocde;

@property (strong, nonatomic) NSString *returnedString;
@property (weak, nonatomic) IBOutlet UIButton *btnOutlet;
@property (weak, nonatomic) IBOutlet UIButton *backButtonOutl;
- (IBAction)actBackButton:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *tilteSucces;
@property (weak, nonatomic) IBOutlet UIImageView *logoSucces;
@property (weak, nonatomic) IBOutlet UIImageView *bacgroundSucces;
@property (weak, nonatomic) IBOutlet UILabel *summ;
@property (weak, nonatomic) IBOutlet UILabel *SiceCoins;

@property (weak, nonatomic) IBOutlet UILabel *sumLabel;

@property (weak, nonatomic) IBOutlet UISwitch *switChChecked;
- (IBAction)switchAct:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *switchLabel;
@property (weak, nonatomic) IBOutlet UIButton *cancelCardOutlet;

- (IBAction)cancelCardAct:(id)sender;


@end

