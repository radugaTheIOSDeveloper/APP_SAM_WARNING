//
//  PageContentViewController.m
//  SAM
//
//  Created by User on 26.09.16.
//  Copyright © 2016 freshtech. All rights reserved.
//

#import "PageContentViewController.h"

@interface PageContentViewController ()

@end

@implementation PageContentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLable.text = self.titleText;
    self.backgroundImage.image = [UIImage imageNamed:self.imageBG];
    self.logoImage.image= [UIImage imageNamed:self.imageLogo];
    self.detailLable.text = self.detailText;
    self.textField.text = self.textInfo;
}
- (void)viewDidLayoutSubviews {
    [self.textField setContentOffset:CGPointZero animated:NO];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
