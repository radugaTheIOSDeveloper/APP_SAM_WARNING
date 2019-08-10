//
//  SelectCardView.m
//  SAM
//
//  Created by User on 23.01.17.
//  Copyright © 2017 freshtech. All rights reserved.
//

#import "SelectCardView.h"
#import "API.h"
#import "Payment.h"
#import "PaymentWebView.h"


@interface SelectCardView ()

@end

@implementation SelectCardView

-(void) cancelCardBind {
    
    [[API apiManager] cancelCardBind:^(NSDictionary *responceObject) {
        
        [self stopLoad];
    //    NSLog(@"%@",responceObject);
        if ([[responceObject objectForKey:@"status"] isEqualToString:@"ok"]) {
            [self performSegueWithIdentifier:@"notRepeat" sender:self];
        }
        
    } onFailure:^(NSError *error, NSInteger statusCode) {
      //  NSLog(@"%@",error);
        [self stopLoad];
        
    }];
}


-(void) repeatCardPayment:(NSString *) article {
    
    
    [[API apiManager]repeatCardPayment:article onSuccess:^(NSDictionary *responseObject) {
        
      //  NSLog(@"%@",responseObject);
        [self stopLoad];
        if ([[responseObject objectForKey:@"status"] isEqualToString:@"0"]) {
            [self performSegueWithIdentifier:@"repeatCardPayment" sender:self];
        } else {
            [self performSegueWithIdentifier:@"failSegue" sender:self];
        }
        
    } onFailure:^(NSError *error, NSInteger statusCode) {
        [self stopLoad];
    //    NSLog(@"%@",error);
        
    }];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LogoMenu"]];
    
   // NSLog(@"%@",self.cardMaskStr);
    
    self.cardLabel.text = self.cardMaskStr;

    self.activityInd.alpha = 0.f;
    self.viewLoad.alpha = 0.f;
    
    [self backButton];
}

-(void) startLoad {
    self.viewLoad.alpha = 0.6f;
    self.activityInd.alpha = 1.f;
    [self.activityInd startAnimating];
    [self.view setUserInteractionEnabled:NO];
}
-(void) stopLoad{
    self.viewLoad.alpha = 0.f;
    self.activityInd.alpha = 0.f;
    [self.activityInd stopAnimating];
    [self.view setUserInteractionEnabled:YES];
}

-(void) backButton {
    
    UIBarButtonItem * btn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"backImage"] style:UIBarButtonItemStylePlain target:self action:@selector(backTapped:)];
    self.navigationItem.leftBarButtonItem = btn;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
}

- (void)backTapped:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)buyBtn:(id)sender {
    [self startLoad];
    [self repeatCardPayment:[[Payment save]getMyArticle]];
}

- (IBAction)buyEnotherBtn:(id)sender {
    
    [self startLoad];
    [self cancelCardBind];
    NSLog(@"Использовать другую карту");
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    PaymentWebView * payment;
    
    if ([[segue identifier] isEqualToString:@"notRepeat"]){
        payment = [segue destinationViewController];
        payment.pymentType = @"AC";
        
    }
    
}


@end
