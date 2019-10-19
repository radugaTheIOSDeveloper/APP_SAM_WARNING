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
#import "API.h"

@interface BuyCoins ()<UITextFieldDelegate>

@property (strong, nonatomic) NSString * buy;
@property (strong, nonatomic) NSString * priceTitle;
@property (strong, nonatomic) NSString * messageAlert;

@end

@implementation BuyCoins{
    
    NSInteger two;
    NSInteger buy50;
    NSInteger twoMinuts;
    NSInteger totalPrice;
    NSInteger totalMinuts;
    NSString * promocode;
    NSInteger * type;
    NSInteger  discount;
    NSInteger cahBack;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LogoMenu"]];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
       [self.view addGestureRecognizer:tap];

    two = 0;
    buy50 = 0;

    totalPrice = 0;
    totalMinuts = 0;
    
    discount = 0;
    
    self.summInfo.text = [NSString stringWithFormat:@"0 рублей"];
    self.minutsInfo.text = [NSString stringWithFormat:@"0 минут"];
    self.ballsInfo.text = [NSString stringWithFormat:@"0 баллов"];
    
    self.buyCoinsOtl.enabled = NO;
    
    self.activityIndicator.alpha = 0.f;
    [self.activityIndicator stopAnimating];

  //  [self backButton];
    
    [self getPercent];
    
}

-(void)getPercent{
    
    [[API apiManager]getPercent:^(NSDictionary *responceObject) {
        
        NSLog(@"%@",responceObject);
        NSNumber * i = [responceObject objectForKey:@"cash_back_percent"];
        cahBack = [i integerValue];
        
        
    } onFailure:^(NSError *error, NSInteger statusCode) {
        NSLog(@"%@",error);
    }];
}



-(void) backButton {
    
    UIBarButtonItem * btn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"backImage"] style:UIBarButtonItemStylePlain target:self action:@selector(backTapped:)];
    self.navigationItem.leftBarButtonItem = btn;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
}

- (void)backTapped:(id)sender {
//
//    if ([self.titleStr isEqualToString:@"MyCoin"]) {
//        [self performSegueWithIdentifier:@"backBuyCoin" sender:self];
//    }else {
//        [self.navigationController popViewControllerAnimated:YES];
//    }
    
        [self performSegueWithIdentifier:@"backBuyCoin" sender:self];

    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    promocode =[NSString stringWithFormat:@"%@%@",textField.text,string];

    
    if (promocode.length == 8) {
        
        NSLog(@"replacemant string =  %@",promocode);

        self.activityIndicator.alpha = 1.f;
        [self.activityIndicator startAnimating];
        [self promocod:promocode];
     //   [self dismissKeyboard];
    

        return YES;
        
    }else{
        
        NSLog(@"long - %ld",promocode.length);
        
        return YES;

    }
    
    
//#pragma mark API
  

}

-(void) promocod:(NSString *)promo{
    
    [[API apiManager]promo:promo onSuccess:^(NSDictionary *responseObject) {
    
        
        NSLog(@"respoce typev =  %@",responseObject);
        self.activityIndicator.alpha = 0.f;
        [self.activityIndicator stopAnimating];
        [self dismissKeyboard];
        
        NSNumber * i = [responseObject objectForKey:@"type"];
        NSInteger quantity = [i integerValue];
    
        if (quantity == 0) {
            
            self.messageAlert = @"Бесплатный QR-Code дступен в разделе Мои покупки!";
            [self alerts];
            self.promoText.text = @"";
                
        }else if(quantity == 1){
            
            NSNumber * disNum = [responseObject objectForKey:@"discount_percent"];
            discount = [disNum integerValue];
            
            NSInteger cahs = totalPrice - ((totalPrice * discount)/100);
            
            self.summInfo.text = [NSString stringWithFormat:@"%ld рублей",cahs];
            self.ballsInfo.text = [NSString stringWithFormat:@"%ld %@",(totalPrice * cahBack)/100,[self getNumEnding:(totalPrice * cahBack)/100 obj:0]];

                self.messageAlert = [NSString stringWithFormat:@"Вам доступна скидка %ld%%" , discount];
                [self alerts];
            
        }
        
        
    } onFailure:^(NSError *error, NSInteger statusCode) {
        
        NSString * errResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
                                        self.activityIndicator.alpha = 0.f;
                                        [self.activityIndicator stopAnimating];
                                        [self dismissKeyboard];
                                        self.promoText.text = @"";
                             
                                        NSData *data = [errResponse dataUsingEncoding:NSUTF8StringEncoding];
                                        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                        
                                        NSLog(@"%@",[json objectForKey:@"message"]);
                                        
                                        self.messageAlert = [json objectForKey:@"message"];
                                        [self alerts];
        
    }];
    
}


//-(void)tryPromo {
//
//    [[API apiManager]tryPromo:promocode
//    onSuccess:^(NSDictionary *responseObject) {
//
//        NSLog(@"responce promo = %@", responseObject);
//        s
//
//

////
////        self.promoText.text = @"";
//        NSLog(@"%@",[responseObject objectForKey:@"type"]);
//
//
//
//    } onFailure:^(NSError *error, NSInteger statusCode) {
//
//        self.activityIndicator.alpha = 0.f;
//              [self.activityIndicator stopAnimating];
//                NSLog(@"responce promo error = %@", error);
//
//    }];
//
//}

-(void) alerts{
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:self.messageAlert
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) dismissKeyboard{
    [self.promoText resignFirstResponder];
}



- (IBAction)promoTouch:(id)sender {
    
    
    NSLog(@"%@",_promoText.text);
    
}


- (IBAction)minusTwo:(id)sender {
    
    if (two == 0) {
        two = 0;
        
        twoMinuts = 0;
        _quantityTokenTwo.text = [NSString stringWithFormat:@"%ld",(long)two];
        
    }else{
        buy50 =buy50 - 50;
        totalPrice =  buy50;
        twoMinuts =twoMinuts - 2;
        two--;
        totalMinuts =  twoMinuts;
        
        totalPrice =(totalPrice - ((totalPrice * discount)/100));
        
        self.summInfo.text = [NSString stringWithFormat:@"%ld рублей",totalPrice];
        _quantityTokenTwo.text = [NSString stringWithFormat:@"%ld",(long)two];

        self.ballsInfo.text = [NSString stringWithFormat:@"%ld %@",(totalPrice * cahBack)/100,[self getNumEnding:(totalPrice * cahBack)/100 obj:0]];

        [self titleButton:totalPrice];
        
    }
    self.minutsInfo.text = [NSString stringWithFormat:@"%ld %@",totalMinuts, [self getNumEnding:totalMinuts obj:1]];
    self.ballsInfo.text = [NSString stringWithFormat:@"%ld %@",(totalPrice * cahBack)/100,[self getNumEnding:(totalPrice * cahBack)/100 obj:0]];

    self.summInfo.text = [NSString stringWithFormat:@"%ld рублей",totalPrice];

}



- (IBAction)plusTwo:(id)sender {
    buy50 = buy50 + 50;
    totalPrice =  buy50;
    two++;
    twoMinuts = twoMinuts +2;
    totalMinuts =   twoMinuts;
    totalPrice =(totalPrice - ((totalPrice * discount)/100));

    _quantityTokenTwo.text = [NSString stringWithFormat:@"%ld",(long)two];
    
    [self titleButton:totalPrice];
    self.summInfo.text = [NSString stringWithFormat:@"%ld рублей",totalPrice];

    self.minutsInfo.text = [NSString stringWithFormat:@"%ld %@",totalMinuts,[self getNumEnding:totalMinuts obj:1]];
    
    self.ballsInfo.text = [NSString stringWithFormat:@"%ld %@",(totalPrice * cahBack)/100,[self getNumEnding:(totalPrice * cahBack)/100 obj:0]];

}

-(void)titleButton:(NSInteger)buttonTitle{
    
    if (buttonTitle == 0) {
        self.buyCoinsOtl.enabled = NO;
        [self.buyCoinsOtl setTitle:@"Купить жетоны" forState:UIControlStateNormal

         ];

    }else{
        self.buyCoinsOtl.enabled = YES;
      //  [self.buyCoinsOtl setTitle:@"" forState:UIControlStateNormal];
    }
}


-(NSString *) getNumEnding:(NSInteger) num obj:(NSInteger)index {
    
    NSArray * endings;
    
    if (index == 1) {
       endings = @[@"минута",@"минуты",@"минут"];

    }else if(index == 0){
        endings = @[@"балл",@"балла",@"баллов"];

    }
    
    num = num%100;
    NSString * result;
    
    if (num >= 11 && num <=19) {
        
        result = endings[2];
        
    }else{
    
        int i = num % 10;
        
            if (i == 1) {
                
                result = endings[0];
                
            }else if( i== 4 || i == 2 || i == 3){
                    
                result = endings[1];
                    
            }else {
                result = endings[2];
            }
        
    }
    
    return result;
}


- (IBAction)buyCoins:(id)sender {
    if (totalPrice == 0) {
    }else{
    
//        NSString * article = [NSString stringWithFormat:@"%ld*%ld",(long)four,(long)two];
//        [[Payment save]setMySum:@"123"];
//        [[Payment save]setMyArticle:article];
        
  //      [self performSegueWithIdentifier:@"choosePayment" sender:nil];
        
    }
    
}@end
