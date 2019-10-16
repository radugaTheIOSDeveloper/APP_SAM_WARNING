//
//  SwitchMap.m
//  SAM
//
//  Created by User on 23.01.17.
//  Copyright © 2017 freshtech. All rights reserved.
//

#import "SwitchMap.h"


@interface SwitchMap ()

@property (weak, nonatomic) UIViewController *currentViewController;
@property (assign, nonatomic) NSInteger indexBtn;

@end

@implementation SwitchMap

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LogoMenu"]];
    
    self.listView.backgroundColor = [UIColor redColor];
    self.mapView.backgroundColor = [UIColor whiteColor];
    self.indexBtn = 0;
    
    self.currentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ComponentA"];
    self.currentViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self addChildViewController:self.currentViewController];
    [self addSubview:self.currentViewController.view toView:self.containerView];
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];


}

-(void)viewWillAppear:(BOOL)animated{
    [self.tabBarController setTitle:@"Карта"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)cycleFromViewController:(UIViewController*) oldViewController
               toViewController:(UIViewController*) newViewController {
    [oldViewController willMoveToParentViewController:nil];
    [self addChildViewController:newViewController];
    [self addSubview:newViewController.view toView:self.containerView];
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

- (IBAction)listBtnAct:(id)sender {
    
    self.listView.backgroundColor = [UIColor redColor];
    self.mapView.backgroundColor = [UIColor whiteColor];
    self.indexBtn = 0;
    
    UIViewController *newViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ComponentA"];
    newViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self cycleFromViewController:self.currentViewController toViewController:newViewController];
    self.currentViewController = newViewController;
    
}

- (IBAction)maoBtnAct:(id)sender {
    
    self.listView.backgroundColor = [UIColor whiteColor];
    self.mapView.backgroundColor = [UIColor redColor];
    self.indexBtn = 1;
    
    UIViewController *newViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ComponentB"];
    newViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self cycleFromViewController:self.currentViewController toViewController:newViewController];
    self.currentViewController = newViewController;
    
}
@end
