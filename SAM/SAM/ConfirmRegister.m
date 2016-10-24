//
//  ConfirmRegister.m
//  SAM
//
//  Created by User on 03.10.16.
//  Copyright © 2016 freshtech. All rights reserved.
//

#import "ConfirmRegister.h"
#import "API.h"

@interface ConfirmRegister () <UITextFieldDelegate>

@property (strong, nonatomic) NSString * messages;
@property (strong, nonatomic) NSString * typeMessages;

@end

@implementation ConfirmRegister

-(void) confirmRegister:(NSString *)telNumber
                confirm:(NSString *)confirm{
    
    [[API apiManager]confirmRegistr:telNumber
                            confirm:confirm
                          onSuccess:^(NSDictionary *responseObject) {
                              
                              NSLog(@"%@",responseObject);
                              self.messages = [responseObject objectForKey:@"message"];
                              [self.activityIndicator stopAnimating];
                              [self.view setUserInteractionEnabled:YES];
                              if ([responseObject objectForKey:@"token"]) {
                                  [[API apiManager]setToken:[NSString stringWithFormat:@"Token %@",[responseObject objectForKey:@"token"]]];
                                  [self performSegueWithIdentifier:@"setPass" sender:self];
                                  
                              } else {
                                  self.typeMessages = @"Ошибка подтверждения!";
                                  [self alerts];
                              }
                              
}                               onFailure:^(NSError *error, NSInteger statusCode) {
                                    self.typeMessages = @"Ошибка подтверждения!";
                                    [self.activityIndicator stopAnimating];
    [self.view setUserInteractionEnabled:YES];

                                    [self alerts];
                                    NSLog(@"%@",error);
    }];
}

-(void) alerts{
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:self.typeMessages
                                  message:self.messages
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

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    
//    if ([userDefaults integerForKey:@"need_activate"] == 1) {
//
//        self.labelInfo.text = @"Вы уже пыталиcь зарегистрироваться";
//    }
    
    self.confirmNumber.placeholder = @"Код подтверждения";
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    [userDefaults setInteger:1 forKey:@"need_activate"];
    [userDefaults setObject:self.saveTelephone forKey:@"user_phone"];
    
    NSLog(@"%@",self.saveTelephone);
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.alpha = 0.f;
    [self.view addSubview:self.activityIndicator];
    self.activityIndicator.center = CGPointMake([[UIScreen mainScreen]bounds].size.width/2, [[UIScreen mainScreen]bounds].size.height/2);
    self.activityIndicator.color = [UIColor whiteColor];
    [self.view setUserInteractionEnabled:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) dismissKeyboard{
    [self.confirmNumber resignFirstResponder];
}

-(void) textFieldDidBeginEditing:(UITextField *)textField{
    self.titleLabel.alpha = 0.f;
    CGPoint scrollPoint = CGPointMake(0, 120);
    [self.scrollView setContentOffset:scrollPoint animated:YES];
}

-(void)textFieldDidEndEditing:(UITextField*)textField{
    self.titleLabel.alpha = 1.f;
    [self.scrollView setContentOffset:CGPointZero animated:YES];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if ([textField isEqual:self.confirmNumber]) {
        self.activityIndicator.alpha = 1.f;
        [self.activityIndicator startAnimating];
        [self confirmRegister:self.saveTelephone confirm:self.confirmNumber.text];
    }
    
    
    return YES;
}



- (IBAction)buttonConfirm:(id)sender {
    self.activityIndicator.alpha = 1.f;
    [self.activityIndicator startAnimating];
    [self confirmRegister:self.saveTelephone confirm:self.confirmNumber.text];
    
}
- (IBAction)actConfirm:(id)sender {

}



@end
