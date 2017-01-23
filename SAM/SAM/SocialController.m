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



- (IBAction)shareBtn:(id)sender {
    
    NSString * message = @"Я рекомундую мойку самообслуживания САМ!";
    
    UIImage * image = [UIImage imageNamed:@"supportLogo"];
    
    NSArray * shareItems = @[message, image];
    
    UIActivityViewController * avc = [[UIActivityViewController alloc] initWithActivityItems:shareItems applicationActivities:nil];
    
    [self presentViewController:avc animated:YES completion:nil];
    
}
@end
