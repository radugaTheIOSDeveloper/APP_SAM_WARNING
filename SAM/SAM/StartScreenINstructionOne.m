//
//  StartScreenINstructionOne.m
//  SAM
//
//  Created by Георгий Зуев on 19/10/2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import "StartScreenINstructionOne.h"
#import "API.h"

@interface StartScreenINstructionOne ()

@end

@implementation StartScreenINstructionOne

NSUserDefaults * userDefaults;


- (void)viewDidLoad {
    [super viewDidLoad];
    
        userDefaults = [NSUserDefaults standardUserDefaults];
      [userDefaults setInteger:1 forKey:@"show_animated"];
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)nectAct:(id)sender {
    
    
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                          UIViewController *pvc = [mainStoryboard instantiateViewControllerWithIdentifier:@"instructionTwo"];
                          pvc.modalPresentationStyle = UIModalPresentationFullScreen;
                          [self presentViewController:pvc animated:YES completion:nil];
}

- (IBAction)cleanAct:(id)sender {
    
    
    
    
    
    
    
    
    if ([userDefaults objectForKey:@"token"]) {
                                       
        
        if ([[API apiManager]getToken ]== NULL|| [[[API apiManager]getToken] isEqualToString:@""]) {
                                       
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
        
                               
       }else{
           
       
       UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                             UIViewController *pvc = [mainStoryboard instantiateViewControllerWithIdentifier:@"instructionTwo"];
                             pvc.modalPresentationStyle = UIModalPresentationFullScreen;
                             [self presentViewController:pvc animated:YES completion:nil];
       }
}
@end
