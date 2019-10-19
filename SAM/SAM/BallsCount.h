//
//  BallsCount.h
//  SAM
//
//  Created by Георгий Зуев on 10/08/2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BallsCount : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *actPlus;

@property (weak, nonatomic) IBOutlet UIButton *actMinus;
@property (weak, nonatomic) IBOutlet UILabel *scizeBalls;

@property (weak, nonatomic) IBOutlet UILabel *infoMinuts;
@property(strong, nonatomic) NSString * titleBall;
@property (retain) NSNumber * ball;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;

@property (weak, nonatomic) IBOutlet UILabel *infoBalls;
@property (weak, nonatomic) IBOutlet UIButton *getButton;

@property (strong, nonatomic) NSString * messageAlert;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;

- (IBAction)getActionButton:(id)sender;
- (IBAction)buttonPlusAct:(id)sender;
- (IBAction)buttonMinusAction:(id)sender;

@end

NS_ASSUME_NONNULL_END
