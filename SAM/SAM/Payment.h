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
@property (strong, nonatomic) NSString * sum;
@property (strong, nonatomic) NSString * phoneNumber;


//article
-(void)setMyArticle:(NSString *) myArticle;
-(NSString *)getMyArticle;

//sum
-(void) setMySum:(NSString *) mySum;
-(NSString *)getMySum;

//phoneNumber
-(void)setPhoneNumber:(NSString *)phoneNumber;
-(NSString *)getPhoneNumber;

@end
