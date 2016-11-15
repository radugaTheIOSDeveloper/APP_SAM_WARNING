//
//  StartScreenView.m
//  SAM
//
//  Created by User on 13.09.16.
//  Copyright © 2016 freshtech. All rights reserved.
//

#import "StartScreenView.h"

@interface StartScreenView ()

@end

@implementation StartScreenView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.logoImage.alpha = 0.f;
    
    [UIView animateWithDuration:1.6 animations:^{
        self.logoImage.alpha = 1.0f;
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:2.2 animations:^{
            CGRect newLogoFrame = self.logoImage.frame;
            newLogoFrame.origin.y= 60.0f;
            self.logoImage.frame=newLogoFrame;
        } completion:^(BOOL finished) {
            
            NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
                if ([userDefaults integerForKey:@"show_animated"] == 1) {
                    if ([userDefaults objectForKey:@"token"]) {
                        
                        [self performSegueWithIdentifier:@"mapSegue" sender:self];
                    } else {
                        
                        if ([userDefaults integerForKey:@"need_activate"] == 1) {
                            
                            [self performSegueWithIdentifier:@"registrSegue" sender:self];
                        } else  {
                            
                            [self performSegueWithIdentifier:@"enterSegue" sender:self];
                        }
                    }
                    
                } else {
                    
                    [self performSegueWithIdentifier:@"segue" sender:self];
                }
        }];
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
