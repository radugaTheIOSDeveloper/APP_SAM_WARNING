//
//  ViewController.m
//  SAM
//
//  Created by User on 05.09.16.
//  Copyright © 2016 freshtech. All rights reserved.
//

#import "ViewController.h"
#import "SAM-Swift.h"
#import "BuyCoins.h"
#import "Payment.h"
#import "API.h"
#import "MyTabBarController.h"


@interface ViewController ()
    @property (weak, nonatomic) IBOutlet UILabel *tokenLabel;
@property (nonatomic, strong) PaymentController  *pVC;


    
@end

@implementation ViewController {
    BOOL canReturnFrompaymentView;
    NSString * paymntID;
    
    
}

- (void) dealloc
    {
     
    }

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.btnOutlet.titleLabel.text = @"Повторить";
    self.backButtonOutl.alpha = 0.f;

    
 //   [self succesPay];
    
    float sum = [[Payment save]getMySum];
    
    self.tilteSucces.text = @"Спасибо, что используете приложение автомойка САМ, для продолжения операции нажмите кнопку оплатить.";
    self.summ.text = [NSString stringWithFormat:@" %.1f рублей",sum];
    self.SiceCoins.text = [NSString stringWithFormat:@"%ld",[[Payment save]getMyCNtCoin]];
    
    
//    self.switChChecked.alpha = 0.f;
//    self.switchLabel.alpha = 0.f;
    
    [self savedCard];
}

- (IBAction)btnSelectClicked:(id)sender {
        
 //   [self performSegueWithIdentifier:@"showPaymentView" sender:self];

}




-(void) cancelCard {
    
    [[API apiManager]cancelSavedCard:^(NSDictionary *responseObject) {
        
        NSLog(@"%@",responseObject);
        [self savedCard];
        
    } onFailure:^(NSError *error, NSInteger statusCode) {
        NSLog(@"%@",error);
    }];
    
}


-(void) savedCard {
    
    [[API apiManager]checkSavadCard:^(NSDictionary *responseObject) {

        
        self.switchLabel.text = [NSString stringWithFormat:@"Использовать для оплаты: \n%@",[responseObject objectForKey:@"card_text"]];
            [self.switChChecked setOn:true];
        paymntID = [responseObject objectForKey:@"payment_id"];
        self.cancelCardOutlet.alpha = 1.f;

    } onFailure:^(NSError *error, NSInteger statusCode) {
        NSLog(@"status code - %ld",statusCode);
        
        if (statusCode == 400) {
            
            self.switchLabel.text = @"Сохранить платежные данные для последующих покупок";
            [self.switChChecked setOn:false];
        
            self.cancelCardOutlet.alpha = 0.f;
            
        }else{
            
            //dgnfug
            
        }

        
    }];
    
    
}



-(void)viewWillAppear:(BOOL)animated{
    
    self.btnOutlet.titleLabel.text = @"Оплатить";

   
    
    
}


- (IBAction)unwindFromPaymentTwo:(UIStoryboardSegue *)segue {
    
    canReturnFrompaymentView = NO;
    
    self.switChChecked.alpha = 0.f;
    self.switchLabel.alpha = 0.f;
    self.cancelCardOutlet.alpha = 0.f;
    self.cancelCardOutlet.enabled = false;

            self.navigationItem.leftBarButtonItem=nil;
            self.navigationItem.hidesBackButton=YES;
    
        dispatch_async(dispatch_get_main_queue(), ^(void){
            NSLog(@"%@",self.returnedString);
                
            self.navigationItem.hidesBackButton = YES;


            if (self.returnedString == NULL) {
                self.btnOutlet.alpha = 1.f;
                self.btnOutlet.titleLabel.text = @"Оплатить";
                self.backButtonOutl.alpha = 1.f;
                
                self.summ.alpha = 1.f;
                                     self.sumLabel.alpha = 1.f;
                
                self.tilteSucces.text = @"Операция покупки была отменена, для повтора операции нажмите на кнопку оплатить";
              //  self.LabelInfo.text = @"Наджали на кнопку назад";
                
                
            
            }else if([self.returnedString isEqualToString:@"0"]) {
                
                
                
            [self succesPay];
            self.tilteSucces.text = @"Вы уcпешно оплатили покупку жетонов. Ваша покупка может быть использована на любой мойке САМ";
            self.btnOutlet.alpha = 0.f;
            self.backButtonOutl.alpha = 1.f;
            self.summ.alpha = 0.f;
            self.sumLabel.alpha = 0.f;
                

                
            }else if([self.returnedString isEqualToString:@"1"]){
                
            
               // self.LabelInfo.text =@"Оплата по apple pay прошла успешно";
                
                    [self succesPay];
                     self.tilteSucces.text = @"Вы уcпешно оплатили покупку жетонов. Ваша покупка может быть использована на любой мойке САМ";
                     self.btnOutlet.alpha = 0.f;
                     self.backButtonOutl.alpha = 1.f;
                     self.summ.alpha = 0.f;
                     self.sumLabel.alpha = 0.f;
                
                
                
            }else if([self.returnedString isEqualToString:@"2"]){
                
                self.summ.alpha = 1.f;
                self.sumLabel.alpha = 1.f;
                self.tilteSucces.text = @"Во время операции оплаты произошла ошибка, Попробуйте повторить операцию позднее";
                self.backButtonOutl.alpha = 1.f;
                self.btnOutlet.titleLabel.text = @"Повторить";
             //   self.LabelInfo.text =@"Произошла ошибка";
                self.btnOutlet.alpha = 1.f;
                
            }else if([self.returnedString isEqualToString:@"8"]){
                
                self.summ.alpha = 1.f;
                self.sumLabel.alpha = 1.f;
                self.tilteSucces.text = @"Во время операции оплаты произошла ошибка, Попробуйте повторить операцию позднее";
                self.backButtonOutl.alpha = 1.f;
                self.btnOutlet.alpha = 1.f;
            }

            });

}


-(void)succesPay{
    
    self.logoSucces.alpha = 1.f;
    self.bacgroundSucces.alpha = 1.f;
    self.tilteSucces.alpha = 1.f;
    
    self.tilteSucces.text = @"Вы уcпешно оплатили покупку жетонов. Ваша покупка может быть использована на любой мойке САМ";
    
    
}




//- (void) receiveNotification:(NSNotification *) notification
//{
//    if ([[notification name] isEqualToString:@"paymentChanged"]) {
//        NSDictionary * dict = [notification userInfo];
//        NSString *code = [dict objectForKey:@"code"];
//        dispatch_async(dispatch_get_main_queue(), ^(void){
//            [self.tokenLabel setText:code];
//        });
//    }
//}

//
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"showPaymentView"]){
   
       canReturnFrompaymentView = YES;
        PaymentController *rvc = segue.destinationViewController;
        rvc.rubles = [[Payment save]getMySum];
        rvc.cntCoin = [[Payment save]getMyCNtCoin];
        rvc.tokenUser = [[API apiManager]getToken];
        rvc.promocode = [[Payment save]getMydiscount];
        if (self.switChChecked.on) {
            rvc.payment_id = paymntID;
            rvc.save_card = @"1";

        }else{
            rvc.save_card = @"0";
        }
        
    }
}




- (IBAction)actBackButton:(id)sender {

    [[Payment save]setBackIndex:@"indexTwo"];
    
    
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                              PaymentController *pvc = [mainStoryboard instantiateViewControllerWithIdentifier:@"payControlller"];
                              pvc.modalPresentationStyle = UIModalPresentationFullScreen;
                              [self presentViewController:pvc animated:YES completion:nil];
    
}

- (IBAction)switchAct:(id)sender {
    
    if(self.switChChecked.on){
        
        NSLog(@"checked card");

        
    }else{
        NSLog(@"no checed card");

    }
    
}

- (IBAction)cancelCardAct:(id)sender {
    
    [self cancelCard];
    
}
@end

