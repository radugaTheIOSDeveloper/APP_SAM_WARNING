//
//  RegistrClass.m
//  SAM
//
//  Created by User on 22.09.16.
//  Copyright © 2016 freshtech. All rights reserved.
//

#import "RegistrClass.h"
#import "API.h"
#import "ConfirmRegister.h"

@interface RegistrClass ()<UITextFieldDelegate>

@end

@implementation RegistrClass

#pragma mark ViewDidLoad

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.textField.placeholder = @"Номер телефона";
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.alpha = 0.f;
    [self.view addSubview:self.activityIndicator];
    self.activityIndicator.center = CGPointMake([[UIScreen mainScreen]bounds].size.width/2, [[UIScreen mainScreen]bounds].size.height/2);
    self.activityIndicator.color = [UIColor whiteColor];
    [self.view setUserInteractionEnabled:YES];
    
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:1 forKey:@"show_animated"];
}


#pragma mark API

-(void) prepareForRegister:(NSString *)numTel{
    
    [[API apiManager]prepareForRegister:numTel
                        onSuccess:^(NSDictionary *responseObject) {
                            
                            [self.activityIndicator stopAnimating];
                            [self.view setUserInteractionEnabled:YES];
                            self.demoTel = numTel;
                            
        [self performSegueWithIdentifier:@"confirm" sender:self];
    }                   onFailure:^(NSError *error, NSInteger statusCode) {
        
                            [self.activityIndicator stopAnimating];
                            [self.view setUserInteractionEnabled:YES];
                            [self alerts];
    }];
}


-(void) alerts{
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Ошибка регистрации!"
                                  message:@"Недопустимый номер телефона!"
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

#pragma mark TextField and Keyboadr

-(void) dismissKeyboard{
    [self.textField resignFirstResponder];
}

-(void) textFieldDidBeginEditing:(UITextField *)textField{
    self.logoSAM.alpha = 0;
    CGPoint scrollPoint = CGPointMake(0, 120);
    [self.scrollView setContentOffset:scrollPoint animated:YES];
}

-(void)textFieldDidEndEditing:(UITextField*)textField{
    self.logoSAM.alpha = 1;
    [self.scrollView setContentOffset:CGPointZero animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(BOOL)textFieldShouldClear:(UITextField *)textField {
    textField.text = @"+7";
    return NO;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return YES;
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
   
        if([textField isEqual:self.textField]){
        
        if (self.textField.text.length <= 0) {
            
            self.activityIndicator.alpha = 1.f;
            [self.activityIndicator startAnimating];
            [self prepareForRegister:self.textField.text];
            
        } else {
            
            self.activityIndicator.alpha = 1.f;
            [self.activityIndicator startAnimating];
            NSMutableString *stringRange = [self.textField.text mutableCopy];
            NSRange range = NSMakeRange(0, 1);
            [stringRange deleteCharactersInRange:range];
            [self prepareForRegister:stringRange];
        }
        
    }
    return YES;
}

#pragma mark Button action

- (IBAction)actBtnRegistr:(id)sender {
    
    if (self.textField.text.length <= 0) {
        
        self.activityIndicator.alpha = 1.f;
        [self.activityIndicator startAnimating];
        [self prepareForRegister:self.textField.text];
        
    } else {
        
        self.activityIndicator.alpha = 1.f;
        [self.activityIndicator startAnimating];
        NSMutableString *stringRange = [self.textField.text mutableCopy];
        NSRange range = NSMakeRange(0, 1);
        [stringRange deleteCharactersInRange:range];
        [self prepareForRegister:stringRange];

    }
}

- (IBAction)actTextField:(id)sender {
    self.textField.text = @"+7";
}

#pragma mark Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    ConfirmRegister * conReg;
    if ([[segue identifier] isEqualToString:@"confirm"]){
        conReg = [segue destinationViewController];
        conReg.saveTelephone = self.demoTel;
    }
}

@end
