//
//  ViewController.m
//  SAM
//
//  Created by User on 05.09.16.
//  Copyright © 2016 freshtech. All rights reserved.
//

#import "ViewController.h"
#import "SAM-Swift.h"

@interface ViewController ()
    @property (weak, nonatomic) IBOutlet UILabel *tokenLabel;
@property (nonatomic, strong) PaymentController  *pVC;
    
@end

@implementation ViewController

- (void) dealloc
    {
        // If you don't remove yourself as an observer, the Notification Center
        // will continue to try and send notification objects to the deallocated
        // object.
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect frame = self.segment.frame;
    [self.segment setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 100)];


    NSDictionary* userInfo = @{@"total": @"11123"};

    NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:@"eRXReceived" object:self userInfo:userInfo];
    
    
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotification:)
                                                 name:@"tokenChanged"
                                               object:nil];

}

- (IBAction)btnSelectClicked:(id)sender {
    
    
//
//    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    PaymentController *pvc = [mainStoryboard instantiateViewControllerWithIdentifier:@"paymentController"];
//  //  [self presentViewController:pvc animated:YES completion:nil];
//
//
//    [self addChildViewController: pvc];
//    pvc.view.frame = self.view.frame;
//    pvc.count = @"MAKS =";
//
//    [self.view addSubview:pvc.view];
//    [pvc didMoveToParentViewController: self];
    
    [self performSegueWithIdentifier:@"next" sender:self];

    
}

- (void) receiveNotification:(NSNotification *) notification
    {
        if ([[notification name] isEqualToString:@"tokenChanged"]) {
            NSDictionary * dict = [notification userInfo];
            NSString *token = [dict objectForKey:@"token"];
            dispatch_async(dispatch_get_main_queue(), ^(void){
                [self.tokenLabel setText:token];
            });
        }
    }

//
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    PaymentController * segueMyBuy;
    if ([[segue identifier] isEqualToString:@"next"]){
   
        segueMyBuy = [segue destinationViewController];
        segueMyBuy.modalPresentationStyle = UIModalPresentationFullScreen;

        segueMyBuy.count = @"Maks chleb";

        
    }
}



@end

