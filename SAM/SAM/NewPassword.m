//
//  NewPassword.m
//  SAM
//
//  Created by User on 16.11.16.
//  Copyright © 2016 freshtech. All rights reserved.
//

#import "NewPassword.h"

@interface NewPassword ()

@end

@implementation NewPassword

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) dismissKeyboard{
    [self.password resignFirstResponder];
}

-(void) textFieldDidBeginEditing:(UITextField *)textField{
    
    self.logo.alpha = 0.f;
    CGPoint scrollPoint = CGPointMake(0, 130);
    [self.scrollView setContentOffset:scrollPoint animated:YES];
    
}

-(void)textFieldDidEndEditing:(UITextField*)textField{
    
    self.logo.alpha = 1.f;
    [self.scrollView setContentOffset:CGPointZero animated:YES];
}

- (IBAction)btnConfirm:(id)sender {
    //[self performSegueWithIdentifier:@"name" sender:self];
}


@end
