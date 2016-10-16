//
//  MyNavigationControll.m
//  SAM
//
//  Created by User on 22.07.16.
//  Copyright © 2016 freshtech. All rights reserved.
//

#import "MyNavigationControll.h"

@interface MyNavigationControll ()

@end

@implementation MyNavigationControll

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.shadowImage = [UIImage imageNamed:@"testImage"];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"testImage"] forBarMetrics:UIBarMetricsDefault];


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
