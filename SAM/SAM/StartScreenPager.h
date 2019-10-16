//
//  StartScreenPager.h
//  SAM
//
//  Created by Георгий Зуев on 16/10/2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StartScreenPager : UIViewController<UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageViewController;

@property (strong, nonatomic) NSArray *pageBGImage;
@end

NS_ASSUME_NONNULL_END
