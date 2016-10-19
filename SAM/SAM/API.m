//
//  API.m
//  SAM
//
//  Created by User on 03.10.16.
//  Copyright © 2016 freshtech. All rights reserved.
//

#import "API.h"

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
        NSURL * url = [NSURL URLWithString:@"http://5.200.55.169:8080/api/v0/"];
        self.sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
        
    }
    return self;
}
//
//#pragma mark Token

-(void) setToken:(NSString *) token{
    
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[NSString stringWithFormat:@"Token %@",token] forKey:@"token"];
    
}

-(NSString *) getToken{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:@"token"];
    
}

//#pragma mark Register and Auth
//
-(void) registerUser:(NSString *)numPhone
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
                          NSLog(@"JSON: %@", responseObject);
                          if (success) {
                              success(responseObject);
                          }
                      }
                      failure: ^(NSURLSessionTask *operation, NSError *error) {
                          NSLog(@"erorr: %@", error);
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
    
    [self.sessionManager POST:@"confirmRegister/"
                   parameters:params
                     progress:nil
                      success:^(NSURLSessionTask *task, NSDictionary*  responseObject) {
                          NSLog(@"JSON: %@", responseObject);
                          if (success) {
                              success(responseObject);
                          }
                      }
                      failure: ^(NSURLSessionTask *operation, NSError *error) {
                          NSLog(@"erorr: %@", error);
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
                          NSLog(@"JSON: %@", responseObject);
                          if (success) {
                              success(responseObject);
                          }
                      }
                      failure: ^(NSURLSessionTask *operation, NSError *error) {
                          NSLog(@"erorr: %@", error);
                          if (failure) {
                              NSHTTPURLResponse *response = (NSHTTPURLResponse *)operation.response;
                              failure(error, response.statusCode);
                          }
                      }];
    
}

// getUserQr
-(void) getUserQR:(void(^)(NSDictionary * responceObject))success
        onFailure:(void(^)(NSError * error, NSInteger statusCode))failure{
    
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    
    [self.sessionManager.requestSerializer setValue:[userDefaults objectForKey:@"token"] forHTTPHeaderField:@"Authorization"];
    [self.sessionManager GET:@"getUserQR/"
                  parameters:nil
                    progress:nil
                     success:^(NSURLSessionTask *task, NSDictionary*  responseObject) {
                         NSLog(@"responceObj%@",responseObject);
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

// METHOD DELETE

-(void) deleteUsedQR:(NSString *) qrCodeID
           onSuccess:(void(^)(NSDictionary * responseObject)) success
           onFailure:(void(^)(NSError * error, NSInteger statusCode)) failure{
    
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [self.sessionManager.requestSerializer setValue:[userDefaults objectForKey:@"token"] forHTTPHeaderField:@"Authorization"];
    self.sessionManager.requestSerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithObjects:@"GET", @"HEAD", nil];
    
    NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:
                             qrCodeID, @"qrCodeID",nil];
                           
    
    [self.sessionManager DELETE:@"deleteUsedQR/"
                     parameters:params
                        success:^(NSURLSessionTask *task, NSDictionary*  responseObject) {
                            NSLog(@"responceObj%@",responseObject);
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


@end
