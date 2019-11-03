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



- (IBAction)balls:(id)sender {
    
    [self performSegueWithIdentifier:@"ball" sender:self];
}
@end
