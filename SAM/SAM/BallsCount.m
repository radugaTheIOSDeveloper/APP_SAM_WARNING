//
//  BallsCount.m
//  SAM
//
//  Created by Георгий Зуев on 10/08/2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import "BallsCount.h"
#import "BallsViewController.h"
#import "API.h"
#import "BallsGood.h"

@interface BallsCount ()

@end

@implementation BallsCount{
    
    NSInteger two;
    NSInteger sizeBall;
    NSInteger totalMinuts;
    float totalBalls;
    
    
}

-(void)viewWillAppear:(BOOL)animated{

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    two = 0;
    
    ///На Вашем счете 220 баллов. Вы можете приобрести максимум 4 жетона
    
    NSInteger i;
    
    if ([_ball intValue] >= 50) {
        
        i = [_ball intValue]/50;

    }else{
        i = 0;

    }
    
    [self titleButton:two];

    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.alpha = 0.f;
    [self.view addSubview:self.activityIndicator];
    self.activityIndicator.center = CGPointMake([[UIScreen mainScreen]bounds].size.width/2, [[UIScreen mainScreen]bounds].size.height/2);
    self.activityIndicator.color = [UIColor redColor];
    [self.view setUserInteractionEnabled:YES];
    
    
    self.titleLable.text = [NSString stringWithFormat:@"На Вашем счете %.2f баллов. Вы можете приобрести максимум %ld жетонов",[_ball floatValue], i];
    
    NSLog(@"%.2f",[_ball floatValue]);

    
    totalBalls = [self.ball floatValue];
    totalMinuts = 0;
    
    self.infoMinuts.text = [NSString stringWithFormat:@"%ld минут", totalMinuts];
    self.infoBalls.text = [NSString stringWithFormat:@"%.2f баллов",totalBalls];
    
    
}


-(void)cashBackPay:(NSString *) cnt{
    
    [[API apiManager]cashBackPay:cnt onSuccess:^(NSDictionary *responseObject) {
        
        self.activityIndicator.alpha = 0.f;
        [self.activityIndicator stopAnimating];

        [self performSegueWithIdentifier:@"goodBalls" sender:self];
        NSLog(@"%@",responseObject);
    } onFailure:^(NSError *error, NSInteger statusCode) {
        
        self.activityIndicator.alpha = 0.f;
        [self.activityIndicator stopAnimating];


        NSString * errResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
                                                          
                                        NSData *data = [errResponse dataUsingEncoding:NSUTF8StringEncoding];
                                        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                        
                                        NSLog(@"%@",[json objectForKey:@"message"]);
                                        
                                        self.messageAlert = [json objectForKey:@"message"];
                                        [self alerts];
        
        
    }];
    
}

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


- (IBAction)getActionButton:(id)sender {
    
    NSString * t = [NSString stringWithFormat:@"%ld",two];
    
    self.activityIndicator.alpha = 1.f;
    [self.activityIndicator startAnimating];
    
    [self cashBackPay:t];
}

- (IBAction)buttonPlusAct:(id)sender {
    
    if (totalBalls < 50) {
        
    }else{
        totalMinuts = totalMinuts +2;
        totalBalls = totalBalls - 50;
        two++;
        
        self.scizeBalls.text = [NSString stringWithFormat:@"%ld",(long)two];
    }
    
    [self titleButton:two];
    self.infoMinuts.text = [NSString stringWithFormat:@"%ld %@",totalMinuts, [self getNumEnding:totalMinuts obj:1]];
    self.infoBalls.text = [NSString stringWithFormat:@"%.2f %@",totalBalls, [self getNumEnding:totalBalls obj:0]];
    
}

- (IBAction)buttonMinusAction:(id)sender {
    if (two == 0) {
        two = 0;
        totalMinuts = 0;
        self.scizeBalls.text = [NSString stringWithFormat:@"%ld",(long)two];

    }else{
        
        totalBalls = totalBalls +50;
        two--;
        totalMinuts = totalMinuts -2;
        self.scizeBalls.text = [NSString stringWithFormat:@"%ld",(long)two];

    }
    
    //self.infoMinuts.text =[NSMutableArray arrayWithCapacity:28];
    [self titleButton:two];

  self.infoMinuts.text = [NSString stringWithFormat:@"%ld %@",totalMinuts, [self getNumEnding:totalMinuts obj:1]];
       self.infoBalls.text = [NSString stringWithFormat:@"%.2f %@",totalBalls, [self getNumEnding:totalBalls obj:0]];
    

}


-(void)titleButton:(NSInteger)buttonTitle{
    
    if (buttonTitle == 0) {
        self.getButton.enabled = NO;
        [self.getButton setTitle:@"Купить жетоны" forState:UIControlStateNormal

         ];

    }else{
        self.getButton.enabled = YES;
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


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    BallsGood * segueMyBuy;
    if ([[segue identifier] isEqualToString:@"goodBalls"]){
        
        

        segueMyBuy = [segue destinationViewController];
        
        segueMyBuy.sizeTime = totalMinuts;
        
    }
}

@end
