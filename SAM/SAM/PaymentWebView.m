//
//  PaymentWebView.m
//  SAM
//
//  Created by User on 07.10.16.
//  Copyright © 2016 freshtech. All rights reserved.
//

#import "PaymentWebView.h"
#import "Payment.h"

@interface PaymentWebView () <UIWebViewDelegate>

@end

@implementation PaymentWebView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LogoMenu"]];
    
    NSLog(@"type =%@",self.pymentType);
    NSLog(@"sum =%@",[[Payment save]getMySum]);
    NSLog(@"article =%@",[[Payment save]getMyArticle]);
    NSLog(@"phone = %@",[[Payment save]getPhoneNumber]);
    
    NSString *urlString = @"https://demomoney.yandex.ru/eshop.xml";
    NSURL *url = [NSURL URLWithString:urlString];
    NSString *body = [NSString stringWithFormat: @"shopId=%@&scid=%@&sum=%@&customerNumber=%@&paymentType=%@&article=%@", @"71175",@"541436",[[Payment save]getMySum],[[Payment save]getPhoneNumber],self.pymentType,[[Payment save]getMyArticle]];

    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60.0];
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody: [body dataUsingEncoding: NSUTF8StringEncoding]];
    [self.webView loadRequest: request];
    
    [self backButton];
    [self.indicatorView startAnimating];
    [self.view setUserInteractionEnabled:NO];

}

-(void) backButton {
    
    UIBarButtonItem * btn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"backImage"] style:UIBarButtonItemStylePlain target:self action:@selector(backTapped:)];
    self.navigationItem.leftBarButtonItem = btn;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
}

- (void)backTapped:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [self.indicatorView stopAnimating];
    self.indicatorLabel.alpha = 0.f;
    self.indicatorView.alpha = 0.f;
    [self.view setUserInteractionEnabled:YES];

    
    NSString *currentURL = webView.request.URL.absoluteString;
    NSMutableString *stringRange = [currentURL mutableCopy];
    NSRange range = NSMakeRange(33, currentURL.length - 33);
    [stringRange deleteCharactersInRange:range];
    NSLog(@"%@",stringRange);
    if ([stringRange isEqualToString:@"http://5.200.55.169:8080/success/"]) {
    [self performSegueWithIdentifier:@"success" sender:self];
}
}
//}
//
//- (void)webViewDidStartLoad:(UIWebView *)webView{
//    NSLog(@"yes");
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
