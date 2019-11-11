//
//  StartScreenInstructionTwo.m
//  SAM
//
//  Created by Георгий Зуев on 19/10/2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import "StartScreenInstructionTwo.h"
#import "API.h"
@interface StartScreenInstructionTwo ()

@end

@implementation StartScreenInstructionTwo

NSUserDefaults * userDefaultsTwo;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)claenAct:(id)sender {
     if ([userDefaultsTwo objectForKey:@"token"]) {
                                         
                                 
                                 
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
                               UIViewController *pvc = [mainStoryboard instantiateViewControllerWithIdentifier:@"enterController"];
                               pvc.modalPresentationStyle = UIModalPresentationFullScreen;
                               [self presentViewController:pvc animated:YES completion:nil];
         }
}

- (IBAction)nextAct:(id)sender {
    
     if ([userDefaultsTwo objectForKey:@"token"]) {
                                         
                        
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
                               UIViewController *pvc = [mainStoryboard instantiateViewControllerWithIdentifier:@"enterController"];
                               pvc.modalPresentationStyle = UIModalPresentationFullScreen;
                               [self presentViewController:pvc animated:YES completion:nil];
         }
}

@end

