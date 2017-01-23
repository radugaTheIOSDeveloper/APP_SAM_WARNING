//
//  API.h
//  SAM
//
//  Created by User on 03.10.16.
//  Copyright © 2016 freshtech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import <Security/Security.h>


@interface API : NSObject

+(API*) apiManager;
@property (strong, nonatomic) AFHTTPSessionManager * sessionManager;

//token
-(void) setToken:(NSString *)token;
-(NSString *) getToken;

//registr

-(void) prepareForRegister:(NSString *)numPhone
           onSuccess:(void(^)(NSDictionary * responseObject)) success
           onFailure:(void(^)(NSError * error, NSInteger statusCode)) failure;


-(void) confirmRegistr:(NSString *)numPhone
               confirm:(NSString *)confirm
             onSuccess:(void(^)(NSDictionary * responseObject)) success
             onFailure:(void(^)(NSError * error, NSInteger statusCode)) failure;


-(void) passRegistr:(NSString *)numPhone
           password:(NSString *)password
          onSuccess:(void(^)(NSDictionary * responseObject)) success
          onFailure:(void(^)(NSError * error, NSInteger statusCode)) failure;

-(void) authUser:(NSString *)username
        password:(NSString *)password
       onSuccess:(void(^)(NSDictionary * responseObject)) success
       onFailure:(void(^)(NSError * error, NSInteger statusCode)) failure;
//getUserQR

-(void) getUserQR:(void(^)(NSDictionary * responceObject))success
        onFailure:(void(^)(NSError * error, NSInteger statusCode))failure;

-(void) getRefreshUserQR:(void(^)(NSDictionary * responceObject))success
        onFailure:(void(^)(NSError * error, NSInteger statusCode))failure;


//error
-(void) deleteUsedQR:(NSString *)qrCodeID
           onSuccess:(void(^)(NSDictionary * responseObject)) success
           onFailure:(void(^)(NSError * error, NSInteger statusCode)) failure;

//getEvents
-(void) getEvents:(void(^)(NSDictionary * responceObject))success
        onFailure:(void(^)(NSError * error, NSInteger statusCode))failure;
//resetPassword

-(void) prepareForResetPassword:(NSString *)numPhone
                      onSuccess:(void(^)(NSDictionary * responseObject)) success
                      onFailure:(void(^)(NSError * error, NSInteger statusCode)) failure;

-(void) confirmResetPassword:(NSString *)numPhone
                 confirmCode:(NSString *)confirmCode
                   onSuccess:(void(^)(NSDictionary * responseObject)) success
                   onFailure:(void(^)(NSError * error, NSInteger statusCode)) failure;

-(void) setNewPassword:(NSString *)newPassword
              numPhone:(NSString *)numPhone
             onSuccess:(void(^)(NSDictionary * responseObject)) success
             onFailure:(void(^)(NSError * error, NSInteger statusCode)) failure;

// saveAPNSToken

-(void) saveAPNSToken:(NSString *)token
            onSuccess:(void(^)(NSDictionary * responseObject)) success
            onFailure:(void(^)(NSError * error, NSInteger statusCode)) failure;

//checkCardBind

-(void) checkCardBind:(void(^)(NSDictionary * responceObject))success
            onFailure:(void(^)(NSError * error, NSInteger statusCode))failure;

-(void) cancelCardBind:(void(^)(NSDictionary * responceObject))success
             onFailure:(void(^)(NSError * error, NSInteger statusCode))failure;

//repeatCardPayment
-(void) repeatCardPayment:(NSString *)article
                onSuccess:(void(^)(NSDictionary * responseObject)) success
                onFailure:(void(^)(NSError * error, NSInteger statusCode)) failure;

@end
