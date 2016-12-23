//
//  SetPassController.m
//  SAM
//
//  Created by User on 24.10.16.
//  Copyright © 2016 freshtech. All rights reserved.
//

#import "SetPassController.h"
#import "API.h"


@interface SetPassController ()

@property (strong, nonatomic) NSString * phone;
@property (strong, nonatomic) NSString * messageAlert;

@end

@implementation SetPassController

#pragma mark ViewDidLoad

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.pasTextField.placeholder = @"введите пароль";
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.alpha = 0.f;
    [self.view addSubview:self.activityIndicator];
    self.activityIndicator.center = CGPointMake([[UIScreen mainScreen]bounds].size.width/2, [[UIScreen mainScreen]bounds].size.height/2);
    self.activityIndicator.color = [UIColor whiteColor];
    [self.view setUserInteractionEnabled:YES];
    
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    self.phone = [userDefaults objectForKey:@"user_phone"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark API


//
-(void) saveAPNSToken:(NSString *)token {

    [[API apiManager] saveAPNSToken:token
                          onSuccess:^(NSDictionary *responseObject) {
                              NSLog(@"%@",responseObject);
                              NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
                              [userDefaults setInteger:12 forKey:@"pushTokenStatus"];
                              
                              [self performSegueWithIdentifier:@"success" sender:self];

                          } onFailure:^(NSError *error, NSInteger statusCode) {
                              NSLog(@"%@",error);
                          }];

}

-(void) registr:(NSString*)numPhone
       password:(NSString *)password{
    
    [[API apiManager]passRegistr:numPhone
                        password:password onSuccess:^(NSDictionary *responseObject) {
                            
                            self.activityIndicator.alpha = 0.f;
                            [self.activityIndicator stopAnimating];

                            if ([responseObject objectForKey:@"token"]) {
                                
                                [[API apiManager]setToken:[NSString stringWithFormat:@"Token %@",[responseObject objectForKey:@"token"]]];
                                NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
                                [userDefaults setObject:@"true" forKey:@"token"];
                                
                                if ([userDefaults integerForKey:@"pushTokenStatus"] == 12) {
                                    NSLog(@"token save");
                                    [self performSegueWithIdentifier:@"success" sender:self];
                                } else {
                                    [self saveAPNSToken:[userDefaults objectForKey:@"token_push"]];
                                }
                                
                                NSLog(@"%@",[userDefaults objectForKey:@"token_push"]);
                            } else {
                                self.messageAlert = [responseObject objectForKey:@"message"];
                                [self alerts];
                            }
                              
                      }onFailure:^(NSError *error, NSInteger statusCode) {
                          
                          self.activityIndicator.alpha = 0.f;
                          [self.activityIndicator stopAnimating];
                          self.messageAlert = @"Повторите попытку";
                          [self alerts];
                          
}];
    
}

-(void) alerts{
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Ошибка!"                                  message:self.messageAlert
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

#pragma mark TextField and Keyboard

-(void) dismissKeyboard{
    [self.pasTextField resignFirstResponder];
}

-(void) textFieldDidBeginEditing:(UITextField *)textField{
    self.registerLabel.alpha = 0.f;
    CGPoint scrollPoint = CGPointMake(0, 120);
    [self.scrollView setContentOffset:scrollPoint animated:YES];
}

-(void)textFieldDidEndEditing:(UITextField*)textField{
    self.registerLabel.alpha = 1.f;
    [self.scrollView setContentOffset:CGPointZero animated:YES];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if ([textField isEqual:self.pasTextField]) {
        self.activityIndicator.alpha = 1.f;
        [self.activityIndicator startAnimating];
        [self registr:self.phone password:self.pasTextField.text];
    }
    return YES;
}

#pragma mark Button action

- (IBAction)actTextField:(id)sender {
    
}

- (IBAction)registrBtn:(id)sender {
    
    self.activityIndicator.alpha = 1.f;
    [self.activityIndicator startAnimating];
    [self registr:self.phone password:self.pasTextField.text];

}

@end
