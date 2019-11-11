//
//  API.m
//  SAM
//
//  Created by User on 03.10.16.
//  Copyright © 2016 freshtech. All rights reserved.
//

#import "API.h"
#import <Security/Security.h>
#import "KeychainItemWrapper.h"

@implementation API



+(API*) apiManager{
    
    static API * manager = nil;
    static  dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[API alloc]init];
    });
    return manager;
}

-(id)init{
    self = [super init];
    if (self) {
        NSURL * url = [NSURL URLWithString:@"https://app.pomoysam.ru/api/v0/"];
        self.sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    }
    return self;
}

//#pragma mark Token

-(void) setToken:(NSString *) token{
    
    KeychainItemWrapper * wraper = [[KeychainItemWrapper alloc]initWithIdentifier:@"token" accessGroup:nil];
    [wraper setObject:token forKey:(id)kSecValueData];
   // NSLog(@"%@",[wraper objectForKey:(id)kSecValueData]);
    
}

-(NSString *) getToken{
    KeychainItemWrapper * wraper = [[KeychainItemWrapper alloc]initWithIdentifier:@"token" accessGroup:nil];
    return [wraper objectForKey:(id)kSecValueData];
}


-(void) setPushToken:(NSString *)pushToken{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:pushToken forKey:@"token_push"];
    
    
}
-(NSString *) getPushToken{
    
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    return  [userDefaults stringForKey:@"token_push"];
}


//#pragma mark Register and Auth

-(void) prepareForRegister:(NSString *)numPhone
           onSuccess:(void(^)(NSDictionary * responseObject)) success
           onFailure:(void(^)(NSError * error, NSInteger statusCode)) failure{
    
        NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:
                             numPhone, @"phone",nil];
    
    
    [self.sessionManager POST:@"prepareForRegister/"
                   parameters:params
                     progress:nil
                      success:^(NSURLSessionTask *task, NSDictionary*  responseObject) {
                          
                          if (success) {
                              success(responseObject);
                          }
                      }
                      failure: ^(NSURLSessionTask *operation, NSError *error) {
                          
                          if (failure) {
                              NSHTTPURLResponse *response = (NSHTTPURLResponse *)operation.response;
                              failure(error, response.statusCode);
                          }
                      }];
    
}

-(void) confirmRegistr:(NSString *)numPhone
               confirm:(NSString *)confirm
             onSuccess:(void(^)(NSDictionary * responseObject)) success
             onFailure:(void(^)(NSError * error, NSInteger statusCode)) failure{
    
    
    NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:
                             numPhone, @"phone",
                             confirm,  @"confirm_code",nil];
    NSLog(@"%@",params);
    
    [self.sessionManager POST:@"confirmRegister/"
                   parameters:params
                     progress:nil
                      success:^(NSURLSessionTask *task, NSDictionary*  responseObject) {
                          
                          if (success) {
                              success(responseObject);
                          }
                      }
                      failure: ^(NSURLSessionTask *operation, NSError *error) {
                          
                          if (failure) {
                              NSHTTPURLResponse *response = (NSHTTPURLResponse *)operation.response;
                              failure(error, response.statusCode);
                          }
                      }];
    
}

-(void) authUser:(NSString *)username
        password:(NSString *)password
       onSuccess:(void (^)(NSDictionary *))success
       onFailure:(void (^)(NSError *, NSInteger))failure{
    
    NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:
                             username, @"username",
                             password,  @"password",nil];

    [self.sessionManager POST:@"login/"
                   parameters:params
                     progress:nil
                      success:^(NSURLSessionTask *task, NSDictionary*  responseObject) {
                          
                          if (success) {
                              success(responseObject);
                          }
                      }
                      failure: ^(NSURLSessionTask *operation, NSError *error) {
                          
                          if (failure) {
                              NSHTTPURLResponse *response = (NSHTTPURLResponse *)operation.response;
                              failure(error, response.statusCode);
                          }
                      }];
    
}

// getUserQr
-(void) getUserQR:(void(^)(NSDictionary * responceObject))success
        onFailure:(void(^)(NSError * error, NSInteger statusCode))failure{
    
    //returnCacheDataElseLoad
   // [manager.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    
    [self.sessionManager.requestSerializer setValue:[self getToken] forHTTPHeaderField:@"Authorization"];
    
    NSLog(@"%@",[self getToken]);
    
    [self.sessionManager.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];
    [self.sessionManager GET:@"getUserQR/"
                  parameters:nil
                    progress:nil
                     success:^(NSURLSessionTask *task, NSDictionary*  responseObject) {
                         
                         if(success){
                             success(responseObject);
                           //  NSLog(@"Nenenene%@",responseObject);
                         }
                     }
                     failure:^(NSURLSessionTask *operation, NSError *error) {
                       //  NSLog(@"error%@",error);
                         if(failure){
                             NSHTTPURLResponse *response = (NSHTTPURLResponse *)operation.response;
                             failure(error, response.statusCode);
                         }
                     }];
}

-(void) getRefreshUserQR:(void(^)(NSDictionary * responceObject))success
               onFailure:(void(^)(NSError * error, NSInteger statusCode))failure{
    
    [self.sessionManager.requestSerializer setValue:[self getToken] forHTTPHeaderField:@"Authorization"];
    [self.sessionManager.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];
    [self.sessionManager GET:@"getUserQR/"
                  parameters:nil
                    progress:nil
                     success:^(NSURLSessionTask *task, NSDictionary*  responseObject) {
                         
                         if(success){
                             success(responseObject);
                       //      NSLog(@"%@",responseObject);
                         }
                     }
                     failure:^(NSURLSessionTask *operation, NSError *error) {
                     //    NSLog(@"error%@",error);
                         if(failure){
                             NSHTTPURLResponse *response = (NSHTTPURLResponse *)operation.response;
                             failure(error, response.statusCode);
                         }
                     }];

}

// METHOD DELETE

-(void) deleteUsedQR:(NSString *) qrCodeID
           onSuccess:(void(^)(NSDictionary * responseObject)) success
           onFailure:(void(^)(NSError * error, NSInteger statusCode)) failure{
    
    
    [self.sessionManager.requestSerializer setValue:[self getToken] forHTTPHeaderField:@"Authorization"];
    self.sessionManager.requestSerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithObjects:@"GET", @"HEAD", nil];
    
    NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:
                             qrCodeID, @"qrCodeID",nil];
                           
    
    [self.sessionManager DELETE:@"deleteUsedQR/"
                     parameters:params
                        success:^(NSURLSessionTask *task, NSDictionary*  responseObject) {
                            
                            if(success){
                                success(responseObject);
                            }
                        }
     
                        failure:^(NSURLSessionTask *operation, NSError *error) {
                            
                            if(failure){
                                NSHTTPURLResponse *response = (NSHTTPURLResponse *)operation.response;
                                failure(error, response.statusCode);
                            }
                        }];
}

//getEvents

-(void)getEvents:(void (^)(NSDictionary *))success onFailure:(void (^)(NSError *, NSInteger))failure{
    
    [self.sessionManager.requestSerializer setCachePolicy:NSURLRequestReturnCacheDataElseLoad];
    
    [self.sessionManager GET:@"getEvents/"
                  parameters:nil
                    progress:nil
                     success:^(NSURLSessionTask *task, NSDictionary*  responseObject) {
                         
                         if(success){
                             success(responseObject);
                         }
                     }
     
                     failure:^(NSURLSessionTask *operation, NSError *error) {
                       //  NSLog(@"error%@",error);
                         if(failure){
                             NSHTTPURLResponse *response = (NSHTTPURLResponse *)operation.response;
                             failure(error, response.statusCode);
                         }
                     }];

}

-(void) getRefreshEvents:(void(^)(NSDictionary * responceObject))success
               onFailure:(void(^)(NSError * error, NSInteger statusCode))failure{
    
      [self.sessionManager.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];
    [self.sessionManager GET:@"getEvents/"
                  parameters:nil
                    progress:nil
                     success:^(NSURLSessionTask *task, NSDictionary*  responseObject) {
                         
                         if(success){
                             success(responseObject);
                         }
                     }
     
                     failure:^(NSURLSessionTask *operation, NSError *error) {
                         //  NSLog(@"error%@",error);
                         if(failure){
                             NSHTTPURLResponse *response = (NSHTTPURLResponse *)operation.response;
                             failure(error, response.statusCode);
                             
                         }
                     }];

}

/////

-(void) passRegistr:(NSString *)numPhone
           password:(NSString *)password
          onSuccess:(void(^)(NSDictionary * responseObject)) success
          onFailure:(void(^)(NSError * error, NSInteger statusCode)) failure{
    
    NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:
                             numPhone, @"phone",
                             password, @"password",nil];
    
    [self.sessionManager POST:@"register/"
                   parameters:params
                     progress:nil
                      success:^(NSURLSessionTask *task, NSDictionary*  responseObject) {
                          
                          if (success) {
                              success(responseObject);
                          }
                      }
                      failure: ^(NSURLSessionTask *operation, NSError *error) {
                          
                          if (failure) {
                              NSHTTPURLResponse *response = (NSHTTPURLResponse *)operation.response;
                              failure(error, response.statusCode);
                          }
                      }];
}

//restartPassword

-(void) prepareForResetPassword:(NSString *)numPhone
                      onSuccess:(void (^)(NSDictionary *))success
                      onFailure:(void (^)(NSError *, NSInteger))failure {
    
    NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:
                             numPhone, @"user_phone",nil];
    
    [self.sessionManager POST:@"prepareForResetPassword/"
                   parameters:params
                     progress:nil
                      success:^(NSURLSessionTask *task, NSDictionary*  responseObject) {
                          
                          if (success) {
                              success(responseObject);
                          }
                      }
                      failure: ^(NSURLSessionTask *operation, NSError *error) {
                          
                          if (failure) {
                              NSHTTPURLResponse *response = (NSHTTPURLResponse *)operation.response;
                              failure(error, response.statusCode);
                          }
                      }];

}
-(void) confirmResetPassword:(NSString *)numPhone
                 confirmCode:(NSString *)confirmCode
                   onSuccess:(void (^)(NSDictionary *))success
                   onFailure:(void (^)(NSError *, NSInteger))failure {
    
    NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:
                             numPhone, @"user_phone",
                             confirmCode,@"confirm_code", nil];
    
    [self.sessionManager POST:@"confirmResetPassword/"
                   parameters:params
                     progress:nil
                      success:^(NSURLSessionTask *task, NSDictionary*  responseObject) {
                          
                          if (success) {
                              success(responseObject);
                          }
                      }
                      failure: ^(NSURLSessionTask *operation, NSError *error) {
                          
                          if (failure) {
                              NSHTTPURLResponse *response = (NSHTTPURLResponse *)operation.response;
                              failure(error, response.statusCode);
                          }
                      }];

}

-(void) setNewPassword:(NSString *)newPassword
              numPhone:(NSString *)numPhone
             onSuccess:(void (^)(NSDictionary *))success
             onFailure:(void (^)(NSError *, NSInteger))failure {
    
    NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:
                             newPassword, @"password",
                             numPhone, @"user_phone", nil];

    [self.sessionManager POST:@"setNewPassword/"
                   parameters:params
                     progress:nil
                      success:^(NSURLSessionTask *task, NSDictionary*  responseObject) {
                          
                          if (success) {
                              success(responseObject);
                          }
                      }
                      failure: ^(NSURLSessionTask *operation, NSError *error) {
                          
                          if (failure) {
                              NSHTTPURLResponse *response = (NSHTTPURLResponse *)operation.response;
                              failure(error, response.statusCode);
                          }
                      }];

}
// saveAPNSToken

-(void) saveAPNSToken:(NSString *)token
            onSuccess:(void (^)(NSDictionary *))success
            onFailure:(void (^)(NSError *, NSInteger))failure{
    
    
    NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:
                             token, @"ios_token", nil];
    
    [self.sessionManager.requestSerializer setValue:[self getToken] forHTTPHeaderField:@"Authorization"];
    self.sessionManager.requestSerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithObjects:@"GET", @"HEAD", nil];

    [self.sessionManager POST:@"saveAPNSToken/"
                   parameters:params
                     progress:nil
                      success:^(NSURLSessionTask *task, NSDictionary*  responseObject) {
                          
                          if (success) {
                              success(responseObject);
                          }
                      }
                      failure: ^(NSURLSessionTask *operation, NSError *error) {
                          
                          if (failure) {
                              NSHTTPURLResponse *response = (NSHTTPURLResponse *)operation.response;
                              failure(error, response.statusCode);
                          }
                      }];
    
}

// cardBind
-(void) checkCardBind:(void(^)(NSDictionary * responceObject))success
            onFailure:(void(^)(NSError * error, NSInteger statusCode))failure{
    
    [self.sessionManager.requestSerializer setValue:[self getToken] forHTTPHeaderField:@"Authorization"];
    
    [self.sessionManager POST:@"checkCardBind/"
                   parameters:nil
                     progress:nil
                      success:^(NSURLSessionTask *task, NSDictionary*  responseObject) {
                          
                          if (success) {
                              success(responseObject);
                          }
                      }
                      failure: ^(NSURLSessionTask *operation, NSError *error) {
                          
                          if (failure) {
                              NSHTTPURLResponse *response = (NSHTTPURLResponse *)operation.response;
                              failure(error, response.statusCode);
                          }
                      }];

    
}

-(void) cancelCardBind:(void(^)(NSDictionary * responceObject))success
             onFailure:(void(^)(NSError * error, NSInteger statusCode))failure{
    
    [self.sessionManager.requestSerializer setValue:[self getToken] forHTTPHeaderField:@"Authorization"];
    
    [self.sessionManager POST:@"cancelCardBind/"
                   parameters:nil
                     progress:nil
                      success:^(NSURLSessionTask *task, NSDictionary*  responseObject) {
                          
                          if (success) {
                              success(responseObject);
                          }
                      }
                      failure: ^(NSURLSessionTask *operation, NSError *error) {
                          
                          if (failure) {
                              NSHTTPURLResponse *response = (NSHTTPURLResponse *)operation.response;
                              failure(error, response.statusCode);
                          }
                      }];

}
//repeatCardPayment

-(void) repeatCardPayment:(NSString *)article
                onSuccess:(void(^)(NSDictionary * responseObject)) success
                onFailure:(void(^)(NSError * error, NSInteger statusCode)) failure{
    
    NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:
                             article, @"article",nil];
    
    [self.sessionManager.requestSerializer setValue:[self getToken] forHTTPHeaderField:@"Authorization"];
    
    [self.sessionManager POST:@"repeatCardPayment/"
                   parameters:params
                     progress:nil
                      success:^(NSURLSessionTask *task, NSDictionary*  responseObject) {
                          
                          if (success) {
                              success(responseObject);
                          }
                      }
                      failure: ^(NSURLSessionTask *operation, NSError *error) {
                          
                          if (failure) {
                              NSHTTPURLResponse *response = (NSHTTPURLResponse *)operation.response;
                              failure(error, response.statusCode);
                          }
                      }];

    
}

-(void) getNews:(void(^)(NSDictionary * responceObject))success
      onFailure:(void(^)(NSError * error, NSInteger statusCode))failure{
    
    
    [self.sessionManager.requestSerializer setCachePolicy:NSURLRequestReturnCacheDataElseLoad];
    
    [self.sessionManager GET:@"news/"
                  parameters:nil
                    progress:nil
                     success:^(NSURLSessionTask *task, NSDictionary*  responseObject) {
                         
                         if(success){
                             success(responseObject);
                         }
                     }
     
                     failure:^(NSURLSessionTask *operation, NSError *error) {
                           NSLog(@"error%@",error);
                         if(failure){
                             NSHTTPURLResponse *response = (NSHTTPURLResponse *)operation.response;
                             failure(error, response.statusCode);
                         }
                     }];

    
}


-(void) getFAQ:(void(^)(NSDictionary * responceObject))success
     onFailure:(void(^)(NSError * error, NSInteger statusCode))failure{
    
    
    [self.sessionManager.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];

       [self.sessionManager GET:@"faq/"
                     parameters:nil
                       progress:nil
                        success:^(NSURLSessionTask *task, NSDictionary*  responseObject) {
                            
                            if(success){
                                success(responseObject);
                            }
                        }
        
                        failure:^(NSURLSessionTask *operation, NSError *error) {
                              NSLog(@"error%@",error);
                            if(failure){
                                NSHTTPURLResponse *response = (NSHTTPURLResponse *)operation.response;
                                failure(error, response.statusCode);
                            }
                        }];
}


-(void) userBalance:(void(^)(NSDictionary * responceObject))success
     onFailure:(void(^)(NSError * error, NSInteger statusCode))failure{
    
    
    //[self.sessionManager.requestSerializer setCachePolicy:NSURLRequestReturnCacheDataElseLoad];
       
    
    NSLog(@"token = %@",[self getToken]);
    
       [self.sessionManager.requestSerializer setValue:[self getToken] forHTTPHeaderField:@"Authorization"];
    
       [self.sessionManager GET:@"userBalance/"
                     parameters:nil
                       progress:nil
                        success:^(NSURLSessionTask *task, NSDictionary*  responseObject) {
                            
                            if(success){
                                success(responseObject);
                            }
                        }
        
                        failure:^(NSURLSessionTask *operation, NSError *error) {
                              NSLog(@"error%@",error);
                            if(failure){
                                NSHTTPURLResponse *response = (NSHTTPURLResponse *)operation.response;
                                failure(error, response.statusCode);
                            }
                        }];
}




-(void)promo:(NSString *)promocode onSuccess:(void (^)(NSDictionary *))success onFailure:(void (^)(NSError *, NSInteger))failure{
    
    NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:
                             promocode, @"code",nil];
        [self.sessionManager.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];

          [self.sessionManager.requestSerializer setValue:[self getToken] forHTTPHeaderField:@"Authorization"];
          
          [self.sessionManager POST:@"tryPromo/"
                         parameters:params
                           progress:nil
                            success:^(NSURLSessionTask *task, NSDictionary*  responseObject) {
                                
                                if (success) {
                                    success(responseObject);
                                    
                                }
                            }
                            failure: ^(NSURLSessionTask *operation, NSError *error) {
                                
                                if (failure) {
                                    NSHTTPURLResponse *response = (NSHTTPURLResponse *)operation.response;
                                    failure(error, response.statusCode);
                                }
                            }];
       
}


-(void) getPercent:(void(^)(NSDictionary * responceObject))success
         onFailure:(void(^)(NSError * error, NSInteger statusCode))failure{
    [self.sessionManager.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];

    [self.sessionManager GET:@"cashBackSetting/"
                       parameters:nil
                         progress:nil
                          success:^(NSURLSessionTask *task, NSDictionary*  responseObject) {
                              
                              if(success){
                                  success(responseObject);
                              }
                          }
          
                          failure:^(NSURLSessionTask *operation, NSError *error) {
                                NSLog(@"error%@",error);
                              if(failure){
                                  NSHTTPURLResponse *response = (NSHTTPURLResponse *)operation.response;
                                  failure(error, response.statusCode);
                              }
                          }];
    
}

-(void)cashBackPay:(NSString *)cnt onSuccess:(void (^)(NSDictionary *))success onFailure:(void (^)(NSError *, NSInteger))failure{
    
    NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:
                             cnt, @"cnt",nil];
        [self.sessionManager.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];

          [self.sessionManager.requestSerializer setValue:[self getToken] forHTTPHeaderField:@"Authorization"];
          
          [self.sessionManager POST:@"cashBackPay/"
                         parameters:params
                           progress:nil
                            success:^(NSURLSessionTask *task, NSDictionary*  responseObject) {
                                
                                if (success) {
                                    success(responseObject);
                                    
                                }
                            }
                            failure: ^(NSURLSessionTask *operation, NSError *error) {
                                
                                if (failure) {
                                    NSHTTPURLResponse *response = (NSHTTPURLResponse *)operation.response;
                                    failure(error, response.statusCode);
                                }
                            }];
    
}



-(void) getCarWash:(void(^)(NSDictionary * responceObject))success
         onFailure:(void(^)(NSError * error, NSInteger statusCode))failure{
    
    [self.sessionManager.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];

    [self.sessionManager GET:@"car-wash/"
                       parameters:nil
                         progress:nil
                          success:^(NSURLSessionTask *task, NSDictionary*  responseObject) {
                              
                              if(success){
                                  success(responseObject);
                              }
                          }
          
                          failure:^(NSURLSessionTask *operation, NSError *error) {
                                NSLog(@"error%@",error);
                              if(failure){
                                  NSHTTPURLResponse *response = (NSHTTPURLResponse *)operation.response;
                                  failure(error, response.statusCode);
                              }
                          }];
    
    
}


-(void) setQuestion:(NSString *)problem
              carWashId:(NSString *)carWashID
          onSuccess:(void(^)(NSDictionary * responseObject)) success
          onFailure:(void(^)(NSError * error, NSInteger statusCode)) failure{
    
    
        NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:
                             problem, @"problem",
                            carWashID,@"car_wash_id",nil];
        [self.sessionManager.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];

          [self.sessionManager.requestSerializer setValue:[self getToken] forHTTPHeaderField:@"Authorization"];
          
          [self.sessionManager POST:@"user-request/"
                         parameters:params
                           progress:nil
                            success:^(NSURLSessionTask *task, NSDictionary*  responseObject) {
                                
                                if (success) {
                                    success(responseObject);
                                    
                                }
                            }
                            failure: ^(NSURLSessionTask *operation, NSError *error) {
                                
                                if (failure) {
                                    NSHTTPURLResponse *response = (NSHTTPURLResponse *)operation.response;
                                    failure(error, response.statusCode);
                                }
                            }];
    
    
}


-(void) pushToken:(void(^)(NSDictionary * responseObject)) success
        onFailure:(void(^)(NSError * error, NSInteger statusCode)) failure{
    
    
    
    NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:
                             [self getPushToken],@"fcm_token",nil];
         [self.sessionManager.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];

           [self.sessionManager.requestSerializer setValue:[self getToken] forHTTPHeaderField:@"Authorization"];
           
           [self.sessionManager POST:@"updateFcmToken/"
                          parameters:params
                            progress:nil
                             success:^(NSURLSessionTask *task, NSDictionary*  responseObject) {
                                 
                                 if (success) {
                                     success(responseObject);
                                     
                                 }
                             }
                             failure: ^(NSURLSessionTask *operation, NSError *error) {
                                 
                                 if (failure) {
                                     NSHTTPURLResponse *response = (NSHTTPURLResponse *)operation.response;
                                     failure(error, response.statusCode);
                                 }
                             }];
    
    
}



@end
