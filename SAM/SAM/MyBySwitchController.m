//
//  MyBySwitchController.m
//  SAM
//
//  Created by User on 09.08.2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import "MyBySwitchController.h"

@interface MyBySwitchController ()

@property (weak, nonatomic) UIViewController *currentViewController;
@property (assign, nonatomic) NSInteger indexBtn;

@end

@implementation MyBySwitchController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setHidesBackButton:YES];
    
    [self.tabBar setDelegate:self];

    self.currentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ComponentActive"];
    self.currentViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self addChildViewController:self.currentViewController];
    [self addSubview:self.currentViewController.view toView:self.containerMyBy];
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIFont boldSystemFontOfSize:12], NSFontAttributeName,
                                [UIColor lightGrayColor], NSForegroundColorAttributeName,
                                nil];
    [self.segmentCntr setTitleTextAttributes:attributes forState:UIControlStateNormal];
    NSDictionary *highlightedAttributes = [NSDictionary dictionaryWithObject:[UIColor blackColor] forKey:NSForegroundColorAttributeName];
    [self.segmentCntr setTitleTextAttributes:highlightedAttributes forState:UIControlStateSelected];
    

}

-(void)viewWillAppear:(BOOL)animated{
    [self.tabBarController setTitle:@"Мои покупки"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)cycleFromViewController:(UIViewController*) oldViewController
               toViewController:(UIViewController*) newViewController {
    [oldViewController willMoveToParentViewController:nil];
    [self addChildViewController:newViewController];
    [self addSubview:newViewController.view toView:self.containerMyBy];
    newViewController.view.alpha = 0;
    [newViewController.view layoutIfNeeded];
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         newViewController.view.alpha = 1;
                         oldViewController.view.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         [oldViewController.view removeFromSuperview];
                         [oldViewController removeFromParentViewController];
                         [newViewController didMoveToParentViewController:self];
                     }];
}

- (void)addSubview:(UIView *)subView toView:(UIView*)parentView {
    [parentView addSubview:subView];
    
    NSDictionary * views = @{@"subView" : subView,};
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[subView]|"
                                                                   options:0
                                                                   metrics:0
                                                                     views:views];
    [parentView addConstraints:constraints];
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[subView]|"
                                                          options:0
                                                          metrics:0
                                                            views:views];
    [parentView addConstraints:constraints];
}





-(void) tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    NSLog(@"working");
    
}


-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
    
    if (item.tag == 500) {
        UIViewController *newViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ComponentActive"];
        newViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
        [self cycleFromViewController:self.currentViewController toViewController:newViewController];
        self.currentViewController = newViewController;
    }else if(item.tag == 501){
        UIViewController *newViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ComponentInactive"];
        newViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
        [self cycleFromViewController:self.currentViewController toViewController:newViewController];
        self.currentViewController = newViewController;
    }else if (item.tag == 502) {
        
        UIViewController *newViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ComponentBallls"];
        newViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
        [self cycleFromViewController:self.currentViewController toViewController:newViewController];
        self.currentViewController = newViewController;
    }
    

    
    
    

    
}


- (IBAction)unvindPaymentToPayment:(UIStoryboardSegue *)unwindSegue
{
    
    self.segmentCntr.selectedSegmentIndex = 0;
    UIViewController *newViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ComponentActive"];
           newViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
           [self cycleFromViewController:self.currentViewController toViewController:newViewController];
           self.currentViewController = newViewController;
}



- (IBAction)unvindBalls:(UIStoryboardSegue *)unwindSegue
{
    
    self.segmentCntr.selectedSegmentIndex = 0;
    UIViewController *newViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ComponentActive"];
           newViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
           [self cycleFromViewController:self.currentViewController toViewController:newViewController];
           self.currentViewController = newViewController;
}


- (IBAction)active:(id)sender {
    
    UIViewController *newViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ComponentActive"];
        newViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
        [self cycleFromViewController:self.currentViewController toViewController:newViewController];
        self.currentViewController = newViewController;
}

- (IBAction)inactive:(id)sender {
    UIViewController *newViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ComponentInactive"];
           newViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
           [self cycleFromViewController:self.currentViewController toViewController:newViewController];
           self.currentViewController = newViewController;
}

- (IBAction)balls:(id)sender {
    
    UIViewController *newViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ComponentBallls"];
           newViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
           [self cycleFromViewController:self.currentViewController toViewController:newViewController];
           self.currentViewController = newViewController;
}
- (IBAction)actSegment:(id)sender {
    
    if (self.segmentCntr.selectedSegmentIndex == 0) {
        
     UIViewController *newViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ComponentActive"];
            newViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
            [self cycleFromViewController:self.currentViewController toViewController:newViewController];
            self.currentViewController = newViewController;
        
    }else  if (self.segmentCntr.selectedSegmentIndex == 1) {
        
        UIViewController *newViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ComponentInactive"];
               newViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
               [self cycleFromViewController:self.currentViewController toViewController:newViewController];
               self.currentViewController = newViewController;
    }else if   (self.segmentCntr.selectedSegmentIndex == 2) {
        UIViewController *newViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ComponentBallls"];
               newViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
               [self cycleFromViewController:self.currentViewController toViewController:newViewController];
               self.currentViewController = newViewController;
    }
}
@end
