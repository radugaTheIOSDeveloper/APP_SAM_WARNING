//
//  Payment.h
//  SAM
//
//  Created by User on 12.10.16.
//  Copyright © 2016 freshtech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Payment : NSObject

+(Payment*)save;

@property (strong, nonatomic) NSString * article;
@property (assign, nonatomic) float  sum;
@property (strong, nonatomic) NSString * phoneNumber;
@property (assign, nonatomic) NSInteger  cntCoin;
@property (assign, nonatomic) NSString * discount;
@property (strong, nonatomic) NSString * backIndex;




//article
-(void)setMyArticle:(NSString *) myArticle;
-(NSString *)getMyArticle;

//sum
-(void) setMySum:(float ) mySum;
-(float )getMySum;

//phoneNumber
-(void)setPhoneNumber:(NSString *)phoneNumber;
-(NSString *)getPhoneNumber;


-(void)setMyCntCoin:(NSInteger )myCoin;
-(NSInteger )getMyCNtCoin;

//-(void)setMyDiscount:(NSString *)myDiscount;
//-(NSString *)getMyDiscount;


-(void)setMyDiscount:(NSString *)myDiscount;
-(NSString *)getMydiscount;


-(void)setMyBack:(NSString *)myBackIndex;
-(NSString *)getMyBack;



@end
