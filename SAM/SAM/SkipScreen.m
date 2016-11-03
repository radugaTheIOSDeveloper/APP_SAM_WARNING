//
//  SkipScreen.m
//  SAM
//
//  Created by User on 16.10.16.
//  Copyright © 2016 freshtech. All rights reserved.
//

#import "SkipScreen.h"

@interface SkipScreen ()

@end

@implementation SkipScreen

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.pageTitles = @[@"Оплатите жетоны",@"На автомойке САМ",@"Просканируйте QR код",@"Получите жетоны"];
    
    self.pageDetail = @[@"",
                        @"Подойдите к разменному аппарату и получите жетоны с помощью QR кода",
                        @"Поднесите смартфон к считывающему устройству на разменном аппарате",
                        @"Жетоны можно использовать на всех атомойках САМ "];
    
    self.pageImages = @[@"rPos5",@"carPos4",@"qrPos4",@"coinPos3"];
    
    NSMutableArray * animationOne = [NSMutableArray arrayWithObjects:[UIImage imageNamed:@"rPos0"],[UIImage imageNamed:@"rPos1"],[UIImage imageNamed:@"rPos2"],[UIImage imageNamed:@"rPos3"],[UIImage imageNamed:@"rPos4"],[UIImage imageNamed:@"rPos5"], nil];
    
    NSMutableArray * animationTree = [NSMutableArray arrayWithObjects:[UIImage imageNamed:@"qrPos0"],[UIImage imageNamed:@"qrPos1"],[UIImage imageNamed:@"qrPos2"],[UIImage imageNamed:@"qrPos3"],[UIImage imageNamed:@"qrPos4"], nil];
    
    NSMutableArray * animationTwo = [NSMutableArray arrayWithObjects:[UIImage imageNamed:@"carPos0"],[UIImage imageNamed:@"carPos1"],[UIImage imageNamed:@"carPos2"],[UIImage imageNamed:@"carPos3"],[UIImage imageNamed:@"carPos4"], nil];
    
    NSMutableArray * animationFour = [NSMutableArray arrayWithObjects:[UIImage imageNamed:@"coinPos0"],[UIImage imageNamed:@"coinPos1"],[UIImage imageNamed:@"coinPos2"],[UIImage imageNamed:@"coinPos3"], nil];
    
    self.arrayImages = [NSMutableArray arrayWithObjects:animationOne,animationTwo,animationTree,animationFour, nil];
    
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MyPageController"];
    self.pageViewController.dataSource = self;
    
    PageContentController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 30);
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
    self.nextOtl.alpha = 0.f;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (PageContentController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.pageTitles count] == 0) || (index >= [self.pageTitles count])) {
        return nil;
    }
    
    PageContentController *pageContentController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentController"];
    pageContentController.imageName = self.pageImages[index];
    pageContentController.titleText = self.pageTitles[index];
    pageContentController.detailText = self.pageDetail[index];
    pageContentController.arrayImage = self.arrayImages[index];
    pageContentController.pageIndex = index;
    self.index = index;
    
    if (index == 1) {
        self.nextOtl.alpha = 1.f;
    }
    
    
    return pageContentController;
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentController*) viewController).pageIndex;
    
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



- (IBAction)skipBtn:(id)sender {
    
    if (self.index <= 2) {
        PageContentController *startingViewController = [self viewControllerAtIndex:self.index + 1];
        NSArray *viewControllers = @[startingViewController];
        [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];

    } else {
        [self performSegueWithIdentifier:@"enterScreen" sender:self];

    }
}


- (IBAction)nextBtn:(id)sender {
    [self performSegueWithIdentifier:@"enterScreen" sender:self];

}
@end
