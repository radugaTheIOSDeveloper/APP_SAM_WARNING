//
//  PageContentController.m
//  SAM
//
//  Created by User on 16.10.16.
//  Copyright © 2016 freshtech. All rights reserved.
//

#import "PageContentController.h"

@interface PageContentController ()

@end

@implementation PageContentController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.titleLabel.text = self.titleText;
    self.detailLabel.text = self.detailText;
    self.animatedView.image = [UIImage imageNamed:self.imageName];
    self.animatedView.animationImages = self.arrayImage;
    self.animatedView.animationDuration = 0.63f;
    self.animatedView.animationRepeatCount = 1;
    [self.animatedView startAnimating];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
