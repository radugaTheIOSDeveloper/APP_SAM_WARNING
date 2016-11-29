//
//  SocialController.m
//  SAM
//
//  Created by User on 25.11.16.
//  Copyright © 2016 freshtech. All rights reserved.
//

#import "SocialController.h"
#import "SWRevealViewController.h"

@interface SocialController ()

@end

@implementation SocialController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.revealButtonItem setTarget: self.revealViewController];
        [self.revealButtonItem setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }

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

- (IBAction)vkBtn:(id)sender {
}

- (IBAction)facebookBtn:(id)sender {
}

- (IBAction)twiterBtn:(id)sender {
}

- (IBAction)classBtn:(id)sender {
}
@end
