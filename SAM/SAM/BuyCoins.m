//
//  BuyCoins.m
//  SAM
//
//  Created by User on 05.09.16.
//  Copyright © 2016 freshtech. All rights reserved.
//

#import "BuyCoins.h"
#import "QREncoder.h"
#import "Payment.h"

@interface BuyCoins ()

@property (strong, nonatomic) NSString * buy;
@property (strong, nonatomic) NSString * priceTitle;

@end

@implementation BuyCoins{
    
    NSInteger four;
    NSInteger two;
    NSInteger buy100;
    NSInteger buy50;
    NSInteger totalPrice;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LogoMenu"]];
    
    four = 0;
    two = 0;
    buy50 = 0;
    buy100 = 0;
    totalPrice = 0;
    self.lableRub.alpha = 0.f;
    self.lableQuantity.alpha = 0.f;
  
    self.buyCoinsOtl.enabled = NO;
    [self backButton];
    
}

-(void) backButton {
    
    UIBarButtonItem * btn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"backImage"] style:UIBarButtonItemStylePlain target:self action:@selector(backTapped:)];
    self.navigationItem.leftBarButtonItem = btn;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
}

- (void)backTapped:(id)sender {

    if ([self.titleStr isEqualToString:@"MyCoin"]) {
        [self performSegueWithIdentifier:@"backBuyCoin" sender:self];
    }else {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)minusFour:(id)sender {
    
    if (four == 0) {
        
        four = 0;
        _quantityTokenFour.text = [NSString stringWithFormat:@"%ld",(long)four];
        
    }else{
        
        buy100 = buy100 -100;
        totalPrice = buy100 + buy50;
        four--;
        _quantityTokenFour.text = [NSString stringWithFormat:@"%ld",(long)four];
        [self titleButton:totalPrice];
        
    }
}

- (IBAction)plusFour:(id)sender {
    
    buy100 = buy100 +100;
    totalPrice = buy100 + buy50;
    four++;
    _quantityTokenFour.text = [NSString stringWithFormat:@"%ld",(long)four];
    [self titleButton:totalPrice];
    
}

- (IBAction)minusTwo:(id)sender {
    
    if (two == 0) {
        two = 0;
        _quantityTokenTwo.text = [NSString stringWithFormat:@"%ld",(long)two];
        
    }else{
        buy50 =buy50 - 50;
        totalPrice = buy100 + buy50;
        two--;
        _quantityTokenTwo.text = [NSString stringWithFormat:@"%ld",(long)two];
        [self titleButton:totalPrice];
        
    }
    
}

- (IBAction)plusTwo:(id)sender {
    buy50 = buy50 + 50;
    totalPrice = buy100 + buy50;
    two++;
    _quantityTokenTwo.text = [NSString stringWithFormat:@"%ld",(long)two];
    [self titleButton:totalPrice];
    
}

-(void)titleButton:(NSInteger)buttonTitle{
    
    if (buttonTitle == 0) {
        self.buyCoinsOtl.enabled = NO;
        [self.buyCoinsOtl setTitle:@"Купить жетоны" forState:UIControlStateNormal

         ];
        self.lableQuantity.alpha = 0.f;
        self.lableRub.alpha = 0.f;
    }else{
        self.lableQuantity.alpha = 1.f;
        self.lableRub.alpha = 1.f;
        self.buyCoinsOtl.enabled = YES;
        NSString * title = [NSString stringWithFormat:@"%ld",(long)buttonTitle];
        self.lableQuantity.text = title;
        [self.buyCoinsOtl setTitle:@"" forState:UIControlStateNormal];
    }
}

- (IBAction)buyCoins:(id)sender {
    if (totalPrice == 0) {
    }else{
        NSString * sum = self.lableQuantity.text;
        NSString * article = [NSString stringWithFormat:@"%ld*%ld",(long)four,(long)two];
        [[Payment save]setMySum:sum];
        [[Payment save]setMyArticle:article];
        [self performSegueWithIdentifier:@"choosePayment" sender:nil];    }
    
}@end
