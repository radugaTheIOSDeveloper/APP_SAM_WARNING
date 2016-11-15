//
//  ChoosePaymentMethod.m
//  SAM
//
//  Created by User on 04.10.16.
//  Copyright © 2016 freshtech. All rights reserved.
//

#import "ChoosePaymentMethod.h"
#import "PaymentWebView.h"

@interface ChoosePaymentMethod () <UITableViewDelegate, UITabBarDelegate>

@end

@implementation ChoosePaymentMethod

- (void)viewDidLoad {
    [super viewDidLoad];
    
        self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LogoMenu"]];
    [self backButton];

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
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation

*/

- (IBAction)yandexBtn:(id)sender {
    self.typePyment = @"yandex";
   // [self performSegueWithIdentifier:@"choosePayment" sender:self];
}

- (IBAction)bancBtn:(id)sender {
    self.typePyment = @"AC";
    [self performSegueWithIdentifier:@"choosePayment" sender:self];
}

- (IBAction)mobBtn:(id)sender {
    self.typePyment = @"mobyle";
 //   [self performSegueWithIdentifier:@"choosePayment" sender:self];
}

- (IBAction)qiwiBtn:(id)sender {
    self.typePyment = @"qiwi";
  //  [self performSegueWithIdentifier:@"choosePayment" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    PaymentWebView * payment;
    if ([[segue identifier] isEqualToString:@"choosePayment"]){
        payment = [segue destinationViewController];
        payment.pymentType = self.typePyment;
        
    }
}

@end
