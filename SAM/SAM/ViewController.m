//
//  ViewController.m
//  SAM
//
//  Created by User on 05.09.16.
//  Copyright © 2016 freshtech. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()
    @property (weak, nonatomic) IBOutlet UILabel *tokenLabel;
    
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
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotification:)
                                                 name:@"tokenChanged"
                                               object:nil];

}

- (IBAction)btnSelectClicked:(id)sender {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *pvc = [mainStoryboard instantiateViewControllerWithIdentifier:@"paymentController"];
    
    [self addChildViewController: pvc];
    pvc.view.frame = self.view.frame;
    [self.view addSubview:pvc.view];
    [pvc didMoveToParentViewController: self];
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

@end

