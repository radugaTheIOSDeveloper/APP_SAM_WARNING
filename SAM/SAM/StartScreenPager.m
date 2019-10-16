//
//  StartScreenPager.m
//  SAM
//
//  Created by Георгий Зуев on 16/10/2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import "StartScreenPager.h"
#import "StartScreenPageContentViewController.h"

@interface StartScreenPager ()

@end

@implementation StartScreenPager

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageBGImage = @[@"cachBack",@"promo"];
    
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"startScreenPageContentViewController"];
    self.pageViewController.dataSource = self;
    
    StartScreenPageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height );
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
    
}

- (StartScreenPageContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.pageBGImage count] == 0) || (index >= [self.pageBGImage count])) {
        return nil;
    }
    StartScreenPageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"nypagecntrl"];
    pageContentViewController.imageBG = self.pageBGImage[index];
    pageContentViewController.pageIndex = index;
    
    return pageContentViewController;
}
#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((StartScreenPageContentViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((StartScreenPageContentViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageBGImage count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.pageBGImage count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
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
