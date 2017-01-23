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
    
    NSLog(@"shopId=71175 \nscid=68953 type =%@\n sum =%@\narticle =%@\nphone = %@",self.pymentType,[[Payment save]getMySum],[[Payment save]getMyArticle],[[Payment save]getPhoneNumber]);

    NSString *urlString = @"https://money.yandex.ru/eshop.xml";
    NSURL *url = [NSURL URLWithString:urlString];
    NSString *body = [NSString stringWithFormat: @"shopId=%@&scid=%@&sum=%@&customerNumber=%@&paymentType=%@&article=%@", @"71175",@"68953",[[Payment save]getMySum],[[Payment save]getPhoneNumber],self.pymentType,[[Payment save]getMyArticle]];

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

    NSLog(@"%@",currentURL);
    
    NSMutableString *stringRange = [currentURL mutableCopy];
    NSRange range = NSMakeRange(32, currentURL.length - 32);
    [stringRange deleteCharactersInRange:range];
    NSString * str = stringRange;
    
    
    if ([str isEqualToString:@"https://app.pomoysam.ru/success/"]) {
        
        [self performSegueWithIdentifier:@"success" sender:self];
        
    } else if ([str isEqualToString:@"https://app.pomoysam.ru/fail/?or"]) {
        [self performSegueWithIdentifier:@"fail" sender:self];
    }
  }

- (void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"yes");//1345
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
