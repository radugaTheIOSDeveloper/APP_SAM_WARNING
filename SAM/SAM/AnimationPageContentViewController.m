//
//  AnimationPageContentViewController.m
//  SAM
//
//  Created by User on 28.09.16.
//  Copyright © 2016 freshtech. All rights reserved.
//

#import "AnimationPageContentViewController.h"

@interface AnimationPageContentViewController ()

@end

@implementation AnimationPageContentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageOne = [[UIImageView alloc]init];
    self.imageTwo = [[UIImageView alloc]init];
    self.imageTree = [[UIImageView alloc]init];
    
    self.titleLabel = [[UILabel alloc]init];
    self.detailLabel = [[UILabel alloc]init];
    
    self.imageOne.image = [UIImage imageNamed:self.nameImageOne];
    self.imageTwo.image = [UIImage imageNamed:self.nameImageTwo];
    self.imageTree.image = [UIImage imageNamed:self.nameImageTree];
    
    self.titleLabel.text = self.titleText;
    self.detailLabel.text = self.detailText;
    
    self.imageOne.alpha = 0.f;
    self.imageTwo.alpha = 0.f;
    self.imageTree.alpha = 0.f;
    self.titleLabel.alpha = 0.f;
    self.detailLabel.alpha = 0.f;
    
    [self.view addSubview:self.imageOne];
    [self.view addSubview:self.imageTwo];
    [self.view addSubview:self.imageTree];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.detailLabel];
    
    //title Lable :
    self.titleLabel.frame = CGRectMake(self.view.frame.size.width /2 -100,self.view.frame.size.height/2 + 60, 200, 40);
    self.titleLabel.textColor = [UIColor colorWithRed:40/255.0f green:40/255.0f blue:40/255.0f alpha:1];
    UIFont * customFont = [UIFont fontWithName:@"Roboto-Medium" size:24];
     self.titleLabel.font = customFont;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;

    //detail Label
    
    self.detailLabel.frame = CGRectMake(self.view.frame.size.width /2 -160,self.view.frame.size.height/2 + 110, 320, 60);
    self.detailLabel.textColor = [UIColor colorWithRed:111/255.0f green:113/255.0f blue:121/255.0f alpha:1];
    UIFont * customFontTwo = [UIFont fontWithName:@"Roboto-Regular" size:20];
    self.detailLabel.font = customFontTwo;
    self.detailLabel.textAlignment = NSTextAlignmentCenter;
    self.detailLabel.numberOfLines = 3;

    // image one
    
    self.imageOne.frame = CGRectMake(self.view.frame.size.width /2 - 90, self.view.frame.size.height / 2 - 200, 180, 180);
    
    // image two]
    
    self.imageTwo.frame = CGRectMake(320,400, 60, 70);
    
    // imge tree
    
//    self.imageTree.frame = CGRectMake(, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    
    NSLog(@"Индекс %ld",self.pageIndex);
    
    if (self.pageIndex == 0) {
        
        [UIView animateWithDuration:1.6 animations:^{
            self.imageOne.alpha = 1.f;
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:2.2 animations:^{
                
                self.imageTwo.alpha = 1.f;
                self.imageTwo.frame = CGRectMake(212,256, 60, 70);
                
            } completion:^(BOOL finished) {
                
                [UIView animateWithDuration:2.1 animations:^{
                    self.titleLabel.alpha = 1.f;
                    
                } completion:^(BOOL finished) {
                    self.detailLabel.alpha = 1.f;
                }];
                
            }];
            
        }];

    }else if (self.pageIndex == 1){
        
        self.imageOne.frame = CGRectMake(0, self.view.frame.size.height / 2 - 200, 200, 160);
        
        [UIView animateWithDuration:2.6 animations:^{
            self.imageOne.alpha = 1.f;
                self.imageOne.frame = CGRectMake(self.view.frame.size.width /2 - 100, self.view.frame.size.height / 2 - 200, 200, 160);
            
        } completion:^(BOOL finished) {
            
                [UIView animateWithDuration:2.1 animations:^{
                    self.titleLabel.alpha = 1.f;
                    
                } completion:^(BOOL finished) {
                    self.detailLabel.alpha = 1.f;
                
            }];
            
        }];

    }else if (self.pageIndex == 2){
        
        NSLog(@"INDEX 2");
        [UIView animateWithDuration:1.0 animations:^{
            self.imageOne.alpha = 1.f;
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:2.2 animations:^{
                
                self.imageTwo.alpha = 1.f;
                self.imageTwo.frame = CGRectMake(self.view.frame.size.width /2 - 75,150, 150, 150);
                
            } completion:^(BOOL finished) {
                
                [UIView animateWithDuration:2.1 animations:^{
                    self.titleLabel.alpha = 1.f;
                    
                } completion:^(BOOL finished) {
                    self.detailLabel.alpha = 1.f;
                    
                }];
                
            }];
            
        }];
        
    }else {
        
        self.imageOne.frame = CGRectMake(0 , 0, 80, 80);
        self.imageOne.alpha = 1.f;

        [UIView animateWithDuration:1.0 animations:^{
            
        self.imageOne.frame = CGRectMake(self.view.frame.size.width /2 - 60, 230 , 110, 110);
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:2.2 animations:^{
                
                self.imageTwo.alpha = 1.f;
                self.imageTwo.frame = CGRectMake(self.view.frame.size.width /2 - 100,180, 120, 120);
                
            } completion:^(BOOL finished) {
                
                [UIView animateWithDuration:2.1 animations:^{
                    self.imageTree.alpha = 1.f;
                    self.imageTree.frame = CGRectMake(self.view.frame.size.width /2 +20 ,160, 90, 90);
                    
                } completion:^(BOOL finished) {
                    
                    [UIView animateWithDuration:2.1 animations:^{
                        self.titleLabel.alpha = 1.f;

                    } completion:^(BOOL finished) {
                        self.detailLabel.alpha = 1.f;

                    }];
                }];
            }];
        }];
    }

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
