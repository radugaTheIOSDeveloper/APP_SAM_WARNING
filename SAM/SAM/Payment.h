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
@property (assign, nonatomic) NSInteger  sum;
@property (strong, nonatomic) NSString * phoneNumber;
@property (assign, nonatomic) NSInteger  cntCoin;
@property (assign, nonatomic) NSString * discount;


//article
-(void)setMyArticle:(NSString *) myArticle;
-(NSString *)getMyArticle;

//sum
-(void) setMySum:(NSInteger ) mySum;
-(NSInteger )getMySum;

//phoneNumber
-(void)setPhoneNumber:(NSString *)phoneNumber;
-(NSString *)getPhoneNumber;


-(void)setMyCntCoin:(NSInteger )myCoin;
-(NSInteger )getMyCNtCoin;

//-(void)setMyDiscount:(NSString *)myDiscount;
//-(NSString *)getMyDiscount;


-(void)setMyDiscount:(NSString *)myDiscount;
-(NSString *)getMydiscount;

@end
