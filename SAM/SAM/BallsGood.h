//
//  BallsGood.h
//  SAM
//
//  Created by Георгий Зуев on 10/08/2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BallsGood : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *sizeMinuts;


- (IBAction)inMyBuyButton:(id)sender;

@property (nonatomic,assign) NSInteger sizeMin;
@property (nonatomic,assign) NSInteger sizeTime;


@end

NS_ASSUME_NONNULL_END
