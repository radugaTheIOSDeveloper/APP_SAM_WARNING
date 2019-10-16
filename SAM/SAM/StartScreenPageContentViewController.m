//
//  StartScreenPageContentViewController.m
//  SAM
//
//  Created by Георгий Зуев on 16/10/2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import "StartScreenPageContentViewController.h"

@interface StartScreenPageContentViewController ()

@end

@implementation StartScreenPageContentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.backgroundImage.image = [UIImage imageNamed:self.imageBG];
}
- (void)viewDidLayoutSubviews {
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
