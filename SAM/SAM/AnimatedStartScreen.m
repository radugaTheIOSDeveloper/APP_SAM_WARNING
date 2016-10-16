//
//  AnimatedStartScreen.m
//  SAM
//
//  Created by User on 29.09.16.
//  Copyright © 2016 freshtech. All rights reserved.
//

#import "AnimatedStartScreen.h"

@interface AnimatedStartScreen () <UIScrollViewDelegate>

@end

@implementation AnimatedStartScreen

- (void)viewDidLoad {
    
    [super viewDidLoad];

    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logoMenu"]];
    
    self.scrollView.frame = CGRectMake(0, 0, self.view.frame.size.width + 100, self.view.frame.size.height);
    
    [self.view addSubview:self.scrollView];
    self.pageImageOne = @[@"r@",@"car",@"scan",@"animFour"];
    self.pageImageTwo = @[@"arrow",@"arrow",@"_QR",@"animFive"];
    self.costl = 0;
    
    self.pageTitle = @[@"Оплатите жетоны",@"Приехай на мойку САМ",@"Просканируйте QR код",@"Получите жетоны"];
    self.pageDetail = @[@"Жетоны нужны для получения услуг автомойки самообслуживания САМ",@"Подойдите к разменному аппарату и получите жетоны с помощью QR кода",@"Поднесите смартфон к считывающему устройству на разменном аппарате",@"Спасибо за пользование автомойкой самообслуживания САМ"];
    
    self.imageOne = [[UIImageView alloc]init];
    self.imageTwo = [[UIImageView alloc]init];
    self.imageTree = [[UIImageView alloc]init];
    
    [self alphaObjZero];
    
    self.scrollView.contentSize = CGSizeMake(320 * 4, 436);

    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.pagingEnabled = true;
    //   self.scrollView.scrollEnabled = false;
    self.scrollView.showsHorizontalScrollIndicator = NO;


    [self.view addSubview:self.imageOne];
    [self.view addSubview:self.imageTwo];
    [self.view addSubview:self.imageTree];
    
    self.pageController.currentPage = 0;
    
    self.statusArray = [NSArray array];
    
    self.animStatusOne = false;
    self.animStatusTwo = false;
    self.animStatusTree = false;
    self.animStatusFour = false;
    
//
//    self.statusArray = [[NSArray alloc]initWithObjects:self.animStatusOne,self.animStatusTwo,self.animStatusTree,self.animStatusFour, nil];
    
    
    [self startAnimation];

//    [userDefaults setBool:true forKey:@"startAnimated"];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

-(void) startAnimation {

    self.positionScroll = self.scrollView.contentOffset.x;
    
    if (self.costl == 1) {
        NSLog(@"costl 1");
    }else {
        
        if (self.pageController.currentPage == 0) {
            
            NSLog(@"curent Page 0");
            self.imageOne.frame = CGRectMake(self.view.frame.size.width /2 - 90, self.view.frame.size.height / 2 - 200, 180, 180);
            self.imageTwo.frame = CGRectMake(self.imageOne.frame.size.width +120,self.imageOne.frame.size.height +160, 60, 70);

            self.imageOne.image = [UIImage imageNamed:[self.pageImageOne objectAtIndex:self.pageController.currentPage]];
            self.imageTwo.image = [UIImage imageNamed:[self.pageImageTwo objectAtIndex:self.pageController.currentPage]];
            self.titleLabel.text = [self.pageTitle objectAtIndex:self.pageController.currentPage];
            self.detailLablel.text = [self.pageDetail objectAtIndex:self.pageController.currentPage];
            
            
            [self animatedOne];
            
        }else if (self.pageController.currentPage == 1) {
            
            NSLog(@"curent page 1");
            self.imageOne.frame = CGRectMake(0, self.view.frame.size.height / 2 - 200, 200, 160);
            self.imageOne.image = [UIImage imageNamed:[self.pageImageOne objectAtIndex:self.pageController.currentPage]];
            self.titleLabel.text = [self.pageTitle objectAtIndex:self.pageController.currentPage];
            self.detailLablel.text = [self.pageDetail objectAtIndex:self.pageController.currentPage];
            
            [self animatedTwo];
            
        }else if (self.pageController.currentPage == 2){
            
            NSLog(@"curen page 2");
            self.imageOne.frame = CGRectMake(self.view.frame.size.width /2 - 90, self.view.frame.size.height / 2 - 200, 180, 180);
            self.imageTwo.frame = CGRectMake(self.view.frame.size.width /2 - 75,self.view.frame.size.height/2 - 184, 150, 150);
            
            self.imageOne.image = [UIImage imageNamed:[self.pageImageOne objectAtIndex:self.pageController.currentPage]];
            self.imageTwo.image = [UIImage imageNamed:[self.pageImageTwo objectAtIndex:self.pageController.currentPage]];
            self.titleLabel.text = [self.pageTitle objectAtIndex:self.pageController.currentPage];
            self.detailLablel.text = [self.pageDetail objectAtIndex:self.pageController.currentPage];
            
            [self animatedTree];
            
        }else if (self.pageController.currentPage == 3){
            
            NSLog(@"curent page 3");
            self.imageOne.frame = CGRectMake(self.view.frame.size.width /2 - 60, 0 , 110, 110);
            self.imageTwo.frame = CGRectMake(self.view.frame.size.width /2 - 100,-300, 120, 120);
            self.imageTree.frame = CGRectMake(self.view.frame.size.width /2 +20 ,-100, 90, 90);
            
            self.imageOne.image = [UIImage imageNamed:[self.pageImageOne objectAtIndex:self.pageController.currentPage]];
            self.imageTwo.image = [UIImage imageNamed:[self.pageImageTwo objectAtIndex:self.pageController.currentPage]];
            self.imageTree.image = [UIImage imageNamed:@"animFour"];
            self.titleLabel.text = [self.pageTitle objectAtIndex:self.pageController.currentPage];
            self.detailLablel.text = [self.pageDetail objectAtIndex:self.pageController.currentPage];
            
            [self animatedFour];
        }
    }
}

-(void)alphaObjZero{
    
    self.imageOne.alpha = 0.f;
    self.imageTwo.alpha = 0.f;
    self.imageTree.alpha = 0.f;
    self.titleLabel.alpha = 0.f;
    self.detailLablel.alpha = 0.f;
    self.nextBtn.alpha = 0.f;
    self.scrollView.scrollEnabled = false;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) animatedOne {
    
    [UIView animateWithDuration:0.8 animations:^{
        
        self.imageOne.alpha = 1.f;
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:1.6 animations:^{
            
            self.imageTwo.alpha = 1.f;
            self.imageTwo.frame = CGRectMake(self.view.frame.size.width/2 + 22,self.view.frame.size.height /2 - 77, 60, 70);
            self.titleLabel.alpha = 1.f;
            self.detailLablel.alpha = 1.f;
            
        }  completion:^(BOOL finished) {
               
                [UIView animateWithDuration:0.4 animations:^{
                    
                    self.nextBtn.alpha = 1.f;

                } completion:^(BOOL finished) {
                    self.scrollView.scrollEnabled = true;

                    
                }];
            }];
        }];
}

-(void)animatedTwo {
    
    [UIView animateWithDuration:1.6 animations:^{
        self.imageOne.alpha = 1.f;
        self.imageOne.frame = CGRectMake(self.view.frame.size.width /2 - 100, self.view.frame.size.height / 2 - 200, 200, 160);
        self.titleLabel.alpha = 1.f;
        self.detailLablel.alpha = 1.f;
        
    }  completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.4 animations:^{
                self.nextBtn.alpha = 1.f;
            } completion:^(BOOL finished) {
                self.scrollView.scrollEnabled = true;

            }];
        }];
}

-(void) animatedTree {
    
    [UIView animateWithDuration:0.8 animations:^{
        self.imageOne.alpha = 1.f;
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:1.2 animations:^{
            
            self.imageTwo.alpha = 1.f;
            self.imageTwo.frame = CGRectMake(self.view.frame.size.width /2 - 75,self.view.frame.size.height/2 - 184, 150, 150);
            self.titleLabel.alpha = 1.f;
            self.detailLablel.alpha = 1.f;
            
        } completion:^(BOOL finished) {
                
                [UIView animateWithDuration:0.4 animations:^{
                    self.nextBtn.alpha = 1.f;
                } completion:^(BOOL finished) {
                    self.scrollView.scrollEnabled = true;

                    
                }];
            }];
        }];
}

-(void) animatedFour {
    
    [UIView animateWithDuration:0.2f animations:^{
        self.imageOne.alpha = 1.f;

    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.6f animations:^{
    
            self.imageTwo.alpha = 1.f;
            self.imageTree.alpha = 1.f;
        [UIView animateWithDuration:2.0 animations:^{
            self.imageOne.frame = CGRectMake(self.view.frame.size.width /2 - 60, 230 , 110, 110);
            self.imageTwo.frame = CGRectMake(self.view.frame.size.width /2 - 100,180, 120, 120);
            self.imageTree.frame = CGRectMake(self.view.frame.size.width /2 +20 ,160, 90, 90);
            self.titleLabel.alpha = 1.f;
            self.detailLablel.alpha = 1.f;
        }  completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.4 animations:^{
            self.nextBtn.alpha = 1.f;
                
        } completion:^(BOOL finished) {
            self.scrollView.scrollEnabled = true;


                }];
            }];
        }];
    }];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.x > self.positionScroll) {
        if (self.pageController.currentPage == 3) {
            
       
        [self performSegueWithIdentifier:@"enterScreen" sender:self];
            
        } else {
            self.pageController.currentPage ++;
            
            [UIView animateWithDuration:0.2 animations:^{
                
                [self alphaObjZero];
                
            } completion:^(BOOL finished) {
                [self startAnimation];
            }];
        }
    } else if (scrollView.contentOffset.x < self.positionScroll){
        
        if (self.pageController.currentPage == 0) {
            
            NSLog(@"Все дальше нельзя");
         
        } else {
            self.pageController.currentPage --;
            
            [UIView animateWithDuration:0.2 animations:^{
                
                [self alphaObjZero];
                
            } completion:^(BOOL finished) {
                [self startAnimation];
            }];
        }
    }
    
    NSLog(@"%2f",scrollView.contentOffset.x);
}
- (IBAction)skipBtn:(id)sender {
    
    self.costl = 1;
    [self performSegueWithIdentifier:@"enterScreen" sender:self];
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   
   // BuyCoins * coins;
   // NSLog(@"%@",self.titleStr);
    if ([[segue identifier] isEqualToString:@"enterScreen"]){
        NSLog(@"plus");
    }}

- (IBAction)actNextBtn:(id)sender {
    
    if (self.pageController.currentPage == 3) {
        
        [self performSegueWithIdentifier:@"enterScreen" sender:self];
        
    } else {
        
        [UIView animateWithDuration:0.2 animations:^{
            
            [self alphaObjZero];
            
        } completion:^(BOOL finished) {
            
            self.pageController.currentPage ++;
            [self startAnimation];
    
        }];
    }

}
@end
