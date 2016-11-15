//
//  RecoveryPassword.m
//  SAM
//
//  Created by User on 15.11.16.
//  Copyright © 2016 freshtech. All rights reserved.
//

#import "RecoveryPassword.h"

@interface RecoveryPassword () <UITextFieldDelegate>

@end

@implementation RecoveryPassword

- (void)viewDidLoad {
    [super viewDidLoad];
    
   // self.smsTextField.alpha = 0.f;

    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) dismissKeyboard{
    
    [self.textFieldNum resignFirstResponder];
}

-(void) textFieldDidBeginEditing:(UITextField *)textField{
    
    self.logo.alpha = 0;
    CGPoint scrollPoint = CGPointMake(0, 130);
    [self.scrollView setContentOffset:scrollPoint animated:NO];
    
}

-(void)textFieldDidEndEditing:(UITextField*)textField{
    
    self.logo.alpha = 1;
    [self.scrollView setContentOffset:CGPointZero animated:NO];
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    self.textFieldNum.text = @"+7";
    return NO;
}
//
//- (BOOL)textFieldShouldReturn:(UITextField *)textField{

//    
//    if ([textField isEqual:self.textFieldNumber]) {
//        [self.textFieldPassword becomeFirstResponder];
//    } else {
//        [self.view setUserInteractionEnabled:NO];
//        self.activityIndicator.alpha = 1.f;
//        [self.activityIndicator startAnimating];
//        
//        if (self.textFieldNumber.text.length <= 0) {
//            [self authUser:self.textFieldNumber.text password:self.textFieldPassword.text];
//            NSLog(@"%@,%@",self.textFieldNumber.text,self.textFieldPassword.text);
//        } else {
//            NSMutableString *stringRange = [self.textFieldNumber.text mutableCopy];
//            NSRange range = NSMakeRange(0, 1);
//            [stringRange deleteCharactersInRange:range];
//            [self authUser:stringRange password:self.textFieldPassword.text];
//            NSLog(@"%@,%@",stringRange,self.textFieldPassword.text);
//            
//        }
//    }
//    return YES;
//}

//
//-(void) animatedText {
//    
//    [UIView animateWithDuration:0.6f animations:^{
//        self.telTextField.alpha = 0.f;
//    } completion:^(BOOL finished) {
//        [UIView animateWithDuration:0.8f animations:^{
//            self.smsTextField.alpha = 1.f;
//            
//        } completion:^(BOOL finished) {
//            NSLog(@"finish");
//        }];
//    }];
//    
//}

- (IBAction)recoveryAct:(id)sender {
  //  [self animatedText];
}


- (IBAction)textFieldActTel:(id)sender {
    self.textFieldNum.text = @"+7";
}
@end
