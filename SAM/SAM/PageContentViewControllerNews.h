//
//  PageContentViewControllerNews.h
//  SAM
//
//  Created by Георгий Зуев on 10/08/2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PageContentViewControllerNews : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageNews;
@property NSUInteger pageIndex;
@property NSString * imageBG;

@end

NS_ASSUME_NONNULL_END
