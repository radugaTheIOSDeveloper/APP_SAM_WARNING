//
//  Payment.m
//  SAM
//
//  Created by User on 12.10.16.
//  Copyright © 2016 freshtech. All rights reserved.
//

#import "Payment.h"

@implementation Payment


+(Payment*) save{
    
    static Payment * manager = nil;
    static  dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[Payment alloc]init];
    });
    return manager;
}

-(id)init{
    self = [super init];
    return self;
}


//article
-(void)setMyArticle:(NSString *) myArticle{
    self.article = myArticle;
}
-(NSString *)getMyArticle{
    return self.article;
}

//sum
-(void) setMySum:(NSString *) mySum{
    self.sum = mySum;
}
-(NSString *)getMySum{
    return  self.sum;
}


//phoneNumber
-(void)setPhoneNumber:(NSString *)phoneNumber{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:phoneNumber forKey:@"user_phone"];
}
-(NSString *)getPhoneNumber{
    
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:@"user_phone"];
}

@end
