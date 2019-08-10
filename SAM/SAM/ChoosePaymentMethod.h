//
//  ChoosePaymentMethod.h
//  SAM
//
//  Created by User on 04.10.16.
//  Copyright © 2016 freshtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChoosePaymentMethod : UIViewController

- (IBAction)yandexBtn:(id)sender;

- (IBAction)bancBtn:(id)sender;

- (IBAction)mobBtn:(id)sender;

- (IBAction)qiwiBtn:(id)sender;

@property (strong, nonatomic) NSString * typePyment;


@property (weak, nonatomic) IBOutlet UIView *myView;

@property (weak, nonatomic) IBOutlet UIView *viewCheck;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
