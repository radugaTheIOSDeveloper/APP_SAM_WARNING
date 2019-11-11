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
}

- (void) dealloc
    {
        // If you don't remove yourself as an observer, the Notification Center
        // will continue to try and send notification objects to the deallocated
        // object.
        //self.navigationController?.popViewController(animated: false)
         //  self.navigationController?.popToRootViewController(animated: true)


         // 
//        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.backButtonOutl.alpha = 0.f;

    
    [self succesPay];
    
    float sum = [[Payment save]getMySum];
    
    self.tilteSucces.text = @"Спасибо, что используете приложение автомойка САМ, для продолжения операции нажмите кнопку оплатить.";
    self.summ.text = [NSString stringWithFormat:@" %.1f рублей",sum];
    self.SiceCoins.text = [NSString stringWithFormat:@"%ld",[[Payment save]getMyCNtCoin]];
    
    
    
}

- (IBAction)btnSelectClicked:(id)sender {
    
    
 //   [self performSegueWithIdentifier:@"showPaymentView" sender:self];

    
}

-(void)viewWillAppear:(BOOL)animated{
    
}


- (IBAction)unwindFromPayment:(UIStoryboardSegue *)segue {
    
    canReturnFrompaymentView = NO;

//
        dispatch_async(dispatch_get_main_queue(), ^(void){
            NSLog(@"%@",self.returnedString);
            
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
                self.btnOutlet.alpha = 0.f;
                self.backButtonOutl.alpha = 1.f;
              self.summ.alpha = 0.f;
                            self.sumLabel.alpha = 0.f;
                
//                UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//                                            UIViewController *pvc = [mainStoryboard instantiateViewControllerWithIdentifier:@"payControlller"];
//                                            pvc.modalPresentationStyle = UIModalPresentationFullScreen;
//                                            [self presentViewController:pvc animated:YES completion:nil];
                  
//
//                self.backButtonOutl.alpha = 1.f;
//                self.LabelInfo.text =@"Оплата по банковской карте прошла успешно";
//                self.btnOutlet.alpha = 0.f;
                
            }else if([self.returnedString isEqualToString:@"1"]){
                
            
               // self.LabelInfo.text =@"Оплата по apple pay прошла успешно";
                
                self.summ.alpha = 0.f;
                self.sumLabel.alpha = 0.f;
                
                self.btnOutlet.alpha = 0.f;
                self.backButtonOutl.alpha = 1.f;
                
                
                
            }else if([self.returnedString isEqualToString:@"2"]){
                
                self.summ.alpha = 1.f;
                self.sumLabel.alpha = 1.f;
                self.tilteSucces.text = @"Во время операции оплаты произошла ошибка, Попробуйте повторить операцию позднее";
                self.backButtonOutl.alpha = 1.f;
                self.btnOutlet.titleLabel.text = @"Повторить";
             //   self.LabelInfo.text =@"Произошла ошибка";
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
        
    }
}




- (IBAction)actBackButton:(id)sender {

    [[Payment save]setBackIndex:@"indexTwo"];
    
    
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                              PaymentController *pvc = [mainStoryboard instantiateViewControllerWithIdentifier:@"payControlller"];
                              pvc.modalPresentationStyle = UIModalPresentationFullScreen;
                              [self presentViewController:pvc animated:YES completion:nil];
    
}
@end

