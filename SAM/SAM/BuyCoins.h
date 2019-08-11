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

@property (weak, nonatomic) IBOutlet UIButton *fourMinutsMinusOtl;
@property (weak, nonatomic) IBOutlet UIButton *fourMinutsPlusOtl;
@property (weak, nonatomic) IBOutlet UILabel *quantityTokenFour;
@property (weak, nonatomic) IBOutlet UILabel *quantityTokenTwo;
@property (weak, nonatomic) IBOutlet UIButton *twoMinutsMinusOtl;
@property (weak, nonatomic) IBOutlet UIButton *twoMinutsPlusOtl;

//act
- (IBAction)minusFour:(id)sender;
- (IBAction)plusFour:(id)sender;
- (IBAction)minusTwo:(id)sender;
- (IBAction)plusTwo:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buyCoinsOtl;
- (IBAction)buyCoins:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *minutsInfo;
@property (weak, nonatomic) IBOutlet UILabel *summInfo;
@property (weak, nonatomic) IBOutlet UILabel *ballsInfo;

@property (strong,nonatomic)NSString * titleStr;


@end
