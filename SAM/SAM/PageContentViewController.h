//
//  PageContentViewController.h
//  SAM
//
//  Created by User on 26.09.16.
//  Copyright © 2016 freshtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageContentViewController : UIViewController

//
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property NSString * imageBG;

@property NSUInteger pageIndex;

@end
