//
//  BuyCoins.h
//  SAM
//
//  Created by User on 05.09.16.
//  Copyright © 2016 freshtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuyCoins : UIViewController

//otl


@property (weak, nonatomic) IBOutlet UILabel *quantityTokenTwo;
@property (weak, nonatomic) IBOutlet UIButton *twoMinutsMinusOtl;
@property (weak, nonatomic) IBOutlet UIButton *twoMinutsPlusOtl;



//- (IBAction)promoTouch:(id)sender;
//@property (weak, nonatomic) IBOutlet UITextField *promoTextEdit;
- (IBAction)promoTouch:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *promoText;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

- (IBAction)minusTwo:(id)sender;
- (IBAction)plusTwo:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buyCoinsOtl;
- (IBAction)buyCoins:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *minutsInfo;
@property (weak, nonatomic) IBOutlet UILabel *summInfo;
@property (weak, nonatomic) IBOutlet UILabel *ballsInfo;

@property (strong,nonatomic)NSString * titleStr;


@end
