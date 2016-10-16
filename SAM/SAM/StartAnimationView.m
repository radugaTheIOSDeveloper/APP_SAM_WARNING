//
//  StartAnimationView.m
//  SAM
//
//  Created by User on 28.09.16.
//  Copyright © 2016 freshtech. All rights reserved.
//

#import "StartAnimationView.h"

@interface StartAnimationView ()

@end

@implementation StartAnimationView

- (void)viewDidLoad {
    [super viewDidLoad];
    
      self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logoMenu"]];
    
    self.pageTitles = @[@"Оплатил Жетоны",@"Приехал",@"Просканил qr код",@"Получил жетоны"];
    self.pageDetail = @[@"Тут будет текст пояснения для понимания",@"Тут будет текст пояснения для понимания",@"Тут будет текст пояснения для понимания",@"Тут будет текст пояснения для понимания"];
    self.pageImageOne = @[@"r@",@"car",@"scan",@"coinTwo"];
    self.pageImageTwo = @[@"arrow",@"arrow",@"_QR",@"coinOne"];
    self.pageImageTree = @[@"1",@"1",@"1",@"coinTree"];
    
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AnimationPageViewController"];
    self.pageViewController.dataSource = self;
    
    self.btnNext.frame = CGRectMake(275 ,637,100, 10);
    [_btnNext setTitle:@"ДАЛЕЕ" forState:UIControlStateNormal];
    [_btnNext setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_btnNext addTarget:self action:@selector(actNext:) forControlEvents:UIControlEventTouchUpInside];
    
    AnimationPageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
    [self.pageViewController.view addSubview:_btnNext];

    //Пока так
    self.pageViewController.view.userInteractionEnabled = NO;
    _btnNext.alpha = 0.f;
   

}

- (void)actNext:(UIButton*)sender {
    
    AnimationPageContentViewController *startingViewController;
    
    if (_indexPlus <= 2) {
        startingViewController   = [self viewControllerAtIndex:_indexPlus+1];
        
    }else{
        startingViewController   = [self viewControllerAtIndex:3];
    }
    
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (AnimationPageContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.pageTitles count] == 0) || (index >= [self.pageTitles count])) {
        return nil;
    }
    
    AnimationPageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AnimationPageContentViewController"];
    
    pageContentViewController.titleText = self.pageTitles[index];
    pageContentViewController.detailText = self.pageDetail[index];
    pageContentViewController.nameImageOne = self.pageImageOne[index];
    pageContentViewController.nameImageTwo = self.pageImageTwo[index];
    pageContentViewController.nameImageTree = self.pageImageTree[index];
    pageContentViewController.pageIndex = index;
    self.indexPlus = index;
    
    return pageContentViewController;
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((AnimationPageContentViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((AnimationPageContentViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageTitles count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.pageTitles count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}



@end
