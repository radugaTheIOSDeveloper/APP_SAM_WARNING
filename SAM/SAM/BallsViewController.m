//
//  BallsViewController.m
//  SAM
//
//  Created by User on 09.08.2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import "BallsViewController.h"
#import "API.h"
#import "BallsCount.h"

@interface BallsViewController ()
@property (weak, nonatomic) UIViewController *currentViewController;
@property (assign, nonatomic) NSInteger indexBtn;
@property (retain) NSNumber * mBalls;


@end

@implementation BallsViewController
    





- (void)viewDidLoad {
    [super viewDidLoad];
    
   // self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated{
    [self ballances];

}


-(void)ballances{
        
    [[API apiManager]userBalance:^(NSDictionary *responceObject) {
        NSLog(@"%@",responceObject);
        
        self.titleLable.text = [NSString stringWithFormat:@"С каждой покупки Вам зачисляется %@%% от оплаченной суммы в виде баллов",[responceObject objectForKey:@"cash_back_percent"]];
        self.ballance.text = [NSString stringWithFormat:@"На вашем счете \n%@",[responceObject objectForKey:@"str_balance"]];
        
        _mBalls = [responceObject objectForKey:@"balance"];
    
        int s = [_mBalls intValue]/50;
        int m = s*2;
        
        
        self.sizeMinutsBalls.text = [NSString stringWithFormat:@"%d %@", m , [self getNumEnding:m obj:1]];
        _sizeCoinsBalls.text = [NSString stringWithFormat:@"%d %@",s, [self getNumEnding:s obj:0]];

        

    } onFailure:^(NSError *error, NSInteger statusCode) {
        NSLog(@"%@",error);
    }];
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    BallsCount * segueMyBuy;
    if ([[segue identifier] isEqualToString:@"ball"]){
        
        
        
        segueMyBuy = [segue destinationViewController];
        
        segueMyBuy.ball = _mBalls;

        
    }
}


-(NSString *) getNumEnding:(NSInteger) num obj:(NSInteger)index {
    
    NSArray * endings;
    
    if (index == 1) {
       endings = @[@"минута",@"минуты",@"минут"];

    }else if(index == 0){
        endings = @[@"жетон",@"жетона",@"жетонов"];

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




- (IBAction)balls:(id)sender {
    
    [self performSegueWithIdentifier:@"ball" sender:self];
}
@end
