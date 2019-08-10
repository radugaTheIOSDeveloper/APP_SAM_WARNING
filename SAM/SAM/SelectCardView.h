//
//  SelectCardView.h
//  SAM
//
//  Created by User on 23.01.17.
//  Copyright © 2017 freshtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectCardView : UIViewController


- (IBAction)buyBtn:(id)sender;

- (IBAction)buyEnotherBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *buyBtnOtl;
@property (weak, nonatomic) IBOutlet UILabel *cardLabel;

@property (strong, nonatomic) NSString * cardMaskStr;

@property (weak, nonatomic) IBOutlet UIView *viewLoad;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityInd;

@end
