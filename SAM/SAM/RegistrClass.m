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


-(void) registerUser:(NSString *)numTel
            password:(NSString *)password{
    
    [[API apiManager]registerUser:numTel
                        password:password
                        onSuccess:^(NSDictionary *responseObject) {
        NSLog(@"%@",responseObject);
                            
            if ([responseObject objectForKey:@"confirm_code"]) {
                self.demoString = [responseObject objectForKey:@"confirm_code"];
            }
                            
            if ([responseObject objectForKey:@"phone"]) {
                self.demoTel = [responseObject objectForKey:@"phone"];
            }
            NSLog(@"%@",self.demoString);
                            
        [self performSegueWithIdentifier:@"confirm" sender:self];
    } onFailure:^(NSError *error, NSInteger statusCode) {
        
        NSLog(@"%@",error);
        [self alerts];
    }];
}


-(void) alerts{
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Ошибка регистрации!"
                                  message:@"Печалька"
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

//
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:NO];

    self.textField.placeholder = @"Номер телефона";
    self.pasTextField.placeholder = @"Придумайте пароль";

    //self.textField.text = @"+7";
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];

    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:1 forKey:@"show_animated"];
}

-(void) dismissKeyboard{
    [self.textField resignFirstResponder];
    [self.pasTextField resignFirstResponder];
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

-(BOOL)textFieldShouldClear:(UITextField *)textField{
    textField.text = @"+7";
    return NO;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
   // NSUInteger currentLength = textField.text.length;
    
    return YES;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if ([textField isEqual:self.textField]) {
        [self.pasTextField becomeFirstResponder];
    }else if([textField isEqual:self.pasTextField]){
        
        if (self.textField.text.length <= 0) {
            [self registerUser:self.textField.text password:self.pasTextField.text];
        } else {
            NSMutableString *stringRange = [self.textField.text mutableCopy];
            NSRange range = NSMakeRange(0, 1);
            [stringRange deleteCharactersInRange:range];
            
            [self registerUser:stringRange password:self.pasTextField.text];
            
        }
        
    }
    return YES;
}

- (IBAction)actBtnRegistr:(id)sender {
    
    if (self.textField.text.length <= 0) {
        [self registerUser:self.textField.text password:self.pasTextField.text];
    } else {
        NSMutableString *stringRange = [self.textField.text mutableCopy];
        NSRange range = NSMakeRange(0, 1);
        [stringRange deleteCharactersInRange:range];
        
        [self registerUser:stringRange password:self.pasTextField.text];

    }

}

- (IBAction)actTextField:(id)sender {
    self.textField.text = @"+7";

    NSLog(@"%@",self.textField.text);
}

- (IBAction)actPasTextField:(id)sender {
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
        ConfirmRegister * conReg;

    if ([[segue identifier] isEqualToString:@"confirm"]){
        conReg = [segue destinationViewController];
        conReg.saveTelephone = self.demoTel;
        NSLog(@"%@",self.demoString);
    }
}

@end
