//
//  StartScreenPageContentViewController.h
//  SAM
//
//  Created by Георгий Зуев on 16/10/2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StartScreenPageContentViewController : UIViewController


@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property NSString * imageBG;

@property NSUInteger pageIndex;


@end

NS_ASSUME_NONNULL_END
