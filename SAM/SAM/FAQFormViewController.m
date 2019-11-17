//
//  FAQFormViewController.m
//  SAM
//
//  Created by Георгий Зуев on 16/09/2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import "FAQFormViewController.h"
#import <CCDropDownMenus/CCDropDownMenus.h>
#import "API.h"

@interface FAQFormViewController () <CCDropDownMenuDelegate , UITextViewDelegate>
@property (strong, nonatomic) NSMutableArray * textArrs;
@property (strong, nonatomic) NSMutableArray * idArrs;
@property (strong, nonatomic) NSString * idWash;

@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;





@end

ManaDropDownMenu * menu;
NSArray * arrs;
@implementation FAQFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textArrs = [NSMutableArray array];
    self.idArrs = [NSMutableArray array];

    
    menu =  [[ManaDropDownMenu alloc] initWithFrame:CGRectMake(50 ,180, 300, 50) title:@"Выберите мойку"];
    menu.delegate = self;

    menu.indicator = [UIImage imageNamed:@"support"];
    menu.activeColor = [UIColor redColor];
        
    [self.view addSubview:menu];
    
    
    self.textView.text = @"Опишите ваш вопрос...";
    self.textView.textColor = [UIColor lightGrayColor];
    
    
        self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
       self.activityIndicator.alpha = 0.f;
       [self.view addSubview:self.activityIndicator];
       self.activityIndicator.center = CGPointMake([[UIScreen mainScreen]bounds].size.width/2, [[UIScreen mainScreen]bounds].size.height/2);
       self.activityIndicator.color = [UIColor whiteColor];
       [self.view setUserInteractionEnabled:YES];
    
    self.activityIndicator.alpha = 1.f;
    [self.activityIndicator startAnimating];
    
//    
//    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
//    [self.view addGestureRecognizer:tap];
    
    
    [self getCarWash];

}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {

    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }

    return YES;
}

-(void) dismissKeyboard{
    [self.textView resignFirstResponder];
}



-(void)getCarWash{
    
    
    
    [[API apiManager]getCarWash:^(NSDictionary *responceObject) {

        self.activityIndicator.alpha = 0.f;
        [self.activityIndicator startAnimating];
        
        
        NSLog(@"%@",responceObject);
    
        NSMutableArray * active = [responceObject valueForKey:@"car_wash_addr"];
        self.idArrs = [responceObject valueForKey:@"id"];
        self.textArrs = active;
        menu.numberOfRows = self.textArrs.count;
        menu.textOfRows = self.textArrs;

        
    } onFailure:^(NSError *error, NSInteger statusCode) {
        
        self.activityIndicator.alpha = 0.f;
        [self.activityIndicator startAnimating];

        
        NSLog(@"%@",error);
    }];
    
}


- (void)dropDownMenu:(CCDropDownMenu *)dropDownMenu didSelectRowAtIndex:(NSInteger)index {
    

    NSLog(@"%ld",index);
    self.idWash = [_idArrs objectAtIndex:index];

    
}

-(void) setQuestion {
    
    [[API apiManager]setQuestion:self.textView.text carWashId:self.idWash onSuccess:^(NSDictionary *responseObject) {
        
        
        self.activityIndicator.alpha = 0.f;
        [self.activityIndicator startAnimating];

        NSLog(@"%@",responseObject);
        
        [self performSegueWithIdentifier:@"question" sender:self];
        
    } onFailure:^(NSError *error, NSInteger statusCode) {
        
        self.activityIndicator.alpha = 0.f;
        [self.activityIndicator startAnimating];

        NSLog(@"%@",error);
    }];
    
}



- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"Опишите ваш вопрос..."]) {
         textView.text = @"";
         textView.textColor = [UIColor blackColor]; //optional
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"Опишите ваш вопрос...";
        textView.textColor = [UIColor lightGrayColor]; //optional
    }
    [textView resignFirstResponder];
}



- (IBAction)goodBtn:(id)sender {
    
    
    if (self.idWash == NULL || [self.textView.text isEqualToString:@"Опишите ваш вопрос..."]) {
        
        [self alerts];
        
    }else{
        
        self.activityIndicator.alpha = 1.f;
        [self.activityIndicator startAnimating];

        
        [self setQuestion];
    }
    
    
   
    
}


-(void) alerts{
    
    UIAlertController * alert = [UIAlertController
                                  alertControllerWithTitle:@"Форма не заполненна"
                                  message:NULL
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


@end
