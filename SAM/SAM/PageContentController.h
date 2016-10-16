//
//  PageContentController.h
//  SAM
//
//  Created by User on 16.10.16.
//  Copyright © 2016 freshtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageContentController : UIViewController


@property (weak, nonatomic) IBOutlet UIImageView *animatedView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@property NSUInteger pageIndex;
@property NSString *titleText;
@property NSString *detailText;

@property NSString *imageName;
@property NSMutableArray * arrayImage;

@end
