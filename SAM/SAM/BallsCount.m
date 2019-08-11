//
//  BallsCount.m
//  SAM
//
//  Created by Георгий Зуев on 10/08/2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import "BallsCount.h"

@interface BallsCount ()

@end

@implementation BallsCount{
    
    NSInteger two;
    NSInteger sizeBall;
    NSInteger totalMinuts;
    NSInteger totalBalls;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    two = 0;
    totalBalls = 220;
    totalMinuts = 0;
    
    self.infoMinuts.text = [NSString stringWithFormat:@"%ld минут", totalMinuts];
    self.infoBalls.text = [NSString stringWithFormat:@"%ld баллов",totalBalls];
    
    
}



- (IBAction)getActionButton:(id)sender {
    
    [self performSegueWithIdentifier:@"goodBalls" sender:self];
}

- (IBAction)buttonPlusAct:(id)sender {
    
    if (totalBalls < 50) {
        
    }else{
        totalMinuts = totalMinuts +2;
        totalBalls = totalBalls - 50;
        two++;
        
        self.scizeBalls.text = [NSString stringWithFormat:@"%ld",(long)two];
    }
    
    
    self.infoMinuts.text = [NSString stringWithFormat:@"%ld минут", totalMinuts];
    self.infoBalls.text = [NSString stringWithFormat:@"%ld баллов", totalBalls];
    
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
    
    self.infoMinuts.text = [NSString stringWithFormat:@"%ld минут", totalMinuts];
    self.infoBalls.text = [NSString stringWithFormat:@"%ld баллов", totalBalls];
    
    
    
}

@end
