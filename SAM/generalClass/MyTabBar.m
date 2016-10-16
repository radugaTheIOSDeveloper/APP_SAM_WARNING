//
//  MyTabBar.m
//  SAM
//
//  Created by User on 22.07.16.
//  Copyright © 2016 freshtech. All rights reserved.
//

#import "MyTabBar.h"

@interface MyTabBar ()

@end

@implementation MyTabBar

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.tintColor = [UIColor colorWithRed:228/255.0f green:0/255.0f blue:11/255.0f alpha:1];
    [self.navigationController setNavigationBarHidden:YES animated:NO];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
