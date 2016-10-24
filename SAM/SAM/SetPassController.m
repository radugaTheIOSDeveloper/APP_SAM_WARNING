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

@end

@implementation SetPassController

-(void) setPass:(NSString *) newPass {
    
    [[API apiManager] setPass:newPass
                   onSuccess:^(NSDictionary *responseObject) {
                       
                       NSLog(@"%@",responseObject);
                       [self.activityIndicator stopAnimating];
                       [self.view setUserInteractionEnabled:YES];

                       [self performSegueWithIdentifier:@"success" sender:self];
                       
}                  onFailure:^(NSError *error, NSInteger statusCode) {
    
                        NSLog(@"%@",error);
                        [self.activityIndicator stopAnimating];
                        [self.view setUserInteractionEnabled:YES];
                        [self alerts];

}];
}

-(void) alerts{
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Ошибка регистрации"                                  message:@"Недопустимый пароль"
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
    self.pasTextField.placeholder = @"введите пароль";
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.alpha = 0.f;
    [self.view addSubview:self.activityIndicator];
    self.activityIndicator.center = CGPointMake([[UIScreen mainScreen]bounds].size.width/2, [[UIScreen mainScreen]bounds].size.height/2);
    self.activityIndicator.color = [UIColor whiteColor];
    [self.view setUserInteractionEnabled:YES];


}

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
        [self setPass:self.pasTextField.text];
    }
    
    
    return YES;
}

- (IBAction)actTextField:(id)sender {
}

- (IBAction)registrBtn:(id)sender {
    self.activityIndicator.alpha = 1.f;
    [self.activityIndicator startAnimating];
    [self setPass:self.pasTextField.text];

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
