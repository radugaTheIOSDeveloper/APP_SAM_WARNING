//
//  ChoosePaymentMethod.m
//  SAM
//
//  Created by User on 04.10.16.
//  Copyright © 2016 freshtech. All rights reserved.
//

#import "ChoosePaymentMethod.h"
#import "PaymentWebView.h"
#import "API.h"
#import "Payment.h"
#import "SelectCardView.h"


@interface ChoosePaymentMethod () <UITableViewDelegate, UITabBarDelegate>

@property (strong, nonatomic) NSString * cardMask;

@end

@implementation ChoosePaymentMethod



#pragma mark API

-(void) checkCardBind {
    
    [[API apiManager]checkCardBind:^(NSDictionary *responceObject) {
        
        [self stopLoad];
        
       // NSLog(@"%@",responceObject);
        
        if ([[responceObject objectForKey:@"status"] isEqualToString:@"ok"]) {
            
            self.cardMask = [responceObject valueForKey:@"card_mask"];
            [self performSegueWithIdentifier:@"repatPayment" sender:self];
            
        } else {
            [self performSegueWithIdentifier:@"choosePayment" sender:self];
        }
        
    } onFailure:^(NSError *error, NSInteger statusCode) {
     //   NSLog(@"%@",error);
        [self stopLoad];

    }];
}

#pragma mark ViewDidLoad

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:NO];

    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LogoMenu"]];
    [self backButton];

    NSLog(@"%@",[[Payment save]getMyArticle]);
    self.viewCheck.alpha = 0.f;

}

-(void) startLoad {
    self.viewCheck.alpha = 0.6f;
    self.activityIndicator.alpha = 1.f;
    [self.activityIndicator startAnimating];
    [self.view setUserInteractionEnabled:NO];
}

-(void) stopLoad{
    self.activityIndicator.alpha = 0.f;
    self.viewCheck.alpha = 0.f;
    [self.activityIndicator stopAnimating];
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

- (IBAction)yandexBtn:(id)sender {
    
    self.typePyment = @"PC";
    [self performSegueWithIdentifier:@"choosePayment" sender:self];
}

- (IBAction)bancBtn:(id)sender {
    
    [self startLoad];
    self.typePyment = @"AC";
    [self checkCardBind];
}

- (IBAction)mobBtn:(id)sender {
    self.typePyment = @"mobyle";
}

- (IBAction)qiwiBtn:(id)sender {
    self.typePyment = @"qiwi";
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    PaymentWebView * payment;
    SelectCardView * selectCardView;
    
    if ([[segue identifier] isEqualToString:@"choosePayment"]){
        payment = [segue destinationViewController];
        payment.pymentType = self.typePyment;
        
    }else if ([[segue identifier] isEqualToString:@"repatPayment"]){
        selectCardView = [segue destinationViewController];
        selectCardView.cardMaskStr = self.cardMask;
    }
}


@end
