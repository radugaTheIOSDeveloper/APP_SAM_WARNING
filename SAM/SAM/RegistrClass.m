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
                            
                            [self.activityIndicator stopAnimating];
                            [self.view setUserInteractionEnabled:YES];
                            NSLog(@"%@",responseObject);
                            if ([responseObject objectForKey:@"phone"]) {
                                self.demoTel = [responseObject objectForKey:@"phone"];
                            }
                            
        [self performSegueWithIdentifier:@"confirm" sender:self];
    }                   onFailure:^(NSError *error, NSInteger statusCode) {
        
                            [self.activityIndicator stopAnimating];
                            [self.view setUserInteractionEnabled:YES];
                            NSLog(@"%@",error);
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

//
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:NO];

    self.textField.placeholder = @"Номер телефона";
    //self.textField.text = @"+7";
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];

    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:1 forKey:@"show_animated"];
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.alpha = 0.f;
    [self.view addSubview:self.activityIndicator];
    self.activityIndicator.center = CGPointMake([[UIScreen mainScreen]bounds].size.width/2, [[UIScreen mainScreen]bounds].size.height/2);
    self.activityIndicator.color = [UIColor whiteColor];
    [self.view setUserInteractionEnabled:YES];

}

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

-(BOOL)textFieldShouldClear:(UITextField *)textField{
    textField.text = @"+7";
    return NO;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
   // NSUInteger currentLength = textField.text.length;
    
    return YES;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
   
        if([textField isEqual:self.textField]){
        
        if (self.textField.text.length <= 0) {
            self.activityIndicator.alpha = 1.f;
            [self.activityIndicator startAnimating];
            [self registerUser:self.textField.text password:@"123456789"];
        } else {
            self.activityIndicator.alpha = 1.f;
            [self.activityIndicator startAnimating];
            NSMutableString *stringRange = [self.textField.text mutableCopy];
            NSRange range = NSMakeRange(0, 1);
            [stringRange deleteCharactersInRange:range];
            
            [self registerUser:stringRange password:@"123456789"];
            
        }
        
    }
    return YES;
}

- (IBAction)actBtnRegistr:(id)sender {
    
    if (self.textField.text.length <= 0) {
        self.activityIndicator.alpha = 1.f;
        [self.activityIndicator startAnimating];
        [self registerUser:self.textField.text password:@"123456789"];
    } else {
        self.activityIndicator.alpha = 1.f;
        [self.activityIndicator startAnimating];
        NSMutableString *stringRange = [self.textField.text mutableCopy];
        NSRange range = NSMakeRange(0, 1);
        [stringRange deleteCharactersInRange:range];
        
        [self registerUser:stringRange password:@"123456789"];

    }

}

- (IBAction)actTextField:(id)sender {
    self.textField.text = @"+7";

    NSLog(@"%@",self.textField.text);
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
        ConfirmRegister * conReg;

    if ([[segue identifier] isEqualToString:@"confirm"]){
        conReg = [segue destinationViewController];
        conReg.saveTelephone = self.demoTel;
    }
}

@end
