//
//  StartScreenView.m
//  SAM
//
//  Created by User on 13.09.16.
//  Copyright © 2016 freshtech. All rights reserved.
//

#import "StartScreenView.h"
#import "API.h"

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
                                    
                            if ([[API apiManager]getToken]== NULL || [[[API apiManager]getToken] isEqualToString:@""]) {
                                
                                
                                                               UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                                               UIViewController *pvc = [mainStoryboard instantiateViewControllerWithIdentifier:@"enterController"];
                                                               pvc.modalPresentationStyle = UIModalPresentationFullScreen;
                                                               [self presentViewController:pvc animated:YES completion:nil];
                                
                                
                            }else{
                                
                                UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                                              UIViewController *pvc = [mainStoryboard instantiateViewControllerWithIdentifier:@"payControlller"];
                                                              pvc.modalPresentationStyle = UIModalPresentationFullScreen;
                                                              [self presentViewController:pvc animated:YES completion:nil];
                            }
                              

                            
                        } else {
                                    
                                if ([userDefaults integerForKey:@"need_activate"] == 1) {
                                    
                                    
                                    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                    UIViewController *pvc = [mainStoryboard instantiateViewControllerWithIdentifier:@"registrController"];
                                    pvc.modalPresentationStyle = UIModalPresentationFullScreen;
                                    [self presentViewController:pvc animated:YES completion:nil];
                                    
               
                                } else  {
                                    
                                    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                    UIViewController *pvc = [mainStoryboard instantiateViewControllerWithIdentifier:@"enterController"];
                                    pvc.modalPresentationStyle = UIModalPresentationFullScreen;
                                    [self presentViewController:pvc animated:YES completion:nil];
                                   
                                    
                                }
                            }
                        
                    }else{
                        
                        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                        UIViewController *pvc = [mainStoryboard instantiateViewControllerWithIdentifier:@"instructionOne"];
                        pvc.modalPresentationStyle = UIModalPresentationFullScreen;
                        [self presentViewController:pvc animated:YES completion:nil];
                        
                    }
                                
                     
                            
                }];
        
            }];
    
}

-(void) alert {
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Ошибка соединения"
                                  message:@"Проверьте интернет подключение"
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"OK"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                }];
    
    [alert addAction:yesButton];
    [self presentViewController:alert animated:YES completion:nil];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)clear:(id)sender {
}
@end
