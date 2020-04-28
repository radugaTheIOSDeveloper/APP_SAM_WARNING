//
//  MyTabBarController.m
//  SAM
//
//  Created by User on 09.08.2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import "MyTabBarController.h"
#import "ViewController.h"
#import "Payment.h"
#import "API.h"


@interface MyTabBarController ()

@end

@implementation MyTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    
  //  [[UITabBar appearance] setTintColor:[UIColor redColor]];
   // [[UITabBar appearance] setBarTintColor:[UIColor yellowColor]];

    [[UITabBar appearance] setUnselectedItemTintColor:[UIColor colorWithRed:198.0 /255 green:198.0/255 blue:200.0/255 alpha:1.f]];

    // set tabbar background image
//    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"tabbar_bg"]];
    // remove shadow image of tabbar
    [[UITabBar appearance] setShadowImage:[[UIImage alloc]init]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidAppear:(BOOL)animated {
    // Other code...
    
    
    if ([[[Payment save]getMyBack] isEqualToString:@"indexTwo"]) {
        self.selectedIndex = 2;

    }


}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)actionExit:(id)sender {
    
    [self alerts];
}


-(void) alerts{
    
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Выход из аккаунта"
                                  message:@"Вы действительно хотите выйти из аккаунта?"
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"ДА"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
        
                                [[API apiManager]setToken:@""];
                               NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
                               [userDefaults setObject:@"true" forKey:@"token"];
        
        
                        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                        UIViewController *pvc = [mainStoryboard instantiateViewControllerWithIdentifier:@"enterController"];
                        pvc.modalPresentationStyle = UIModalPresentationFullScreen;
                        [self presentViewController:pvc animated:YES completion:nil];
        
                                }];
    
    UIAlertAction* nowButton = [UIAlertAction
                                actionWithTitle:@"НЕТ"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                }];
    
    [alert addAction:yesButton];
    [alert addAction:nowButton];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
