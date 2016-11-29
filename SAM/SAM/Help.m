//
//  Help.m
//  SAM
//
//  Created by User on 05.09.16.
//  Copyright © 2016 freshtech. All rights reserved.
//

#import "Help.h"
#import "SWRevealViewController.h"

@interface Help ()

@end

@implementation Help

- (void)viewDidLoad {
    [super viewDidLoad];
  //  self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logoMenu"]];
    
    self.pageTitles = @[@"1 ПРОГРАММА\n МОЙКА",
                        @"2 ПРОГРАММА\n ОПОЛАСКИВАНИЕ",
                        @"3 ПРОГРАММА\n ЗАЩИТА ЛАКОКРАСОЧНОГО ПОКРЫТИЯ",
                        @"4 ПРОГРАММА\n БЛЕСК",
                        @"ПЫЛЕСОС"];
    
    self.pageBGImage = @[@"bgOne",@"bgTwo",@"bgTree",@"bgFour",@"bgFive"];
    self.pageLogoImaage = @[@"logoOne",@"logoTwo",@"logoTree",@"logoFour",@"logoFive"];
    self.pageDetail = @[@"Смесь высококачественного моющего средства и горячей воды под давлением.",
                        @"Чистая вода под давлением.",
                        @"Воск и горячая вода под давлением.",
                        @"Деминерализованная водой с осушающим и обеспечивающим блеск средством.",
                        @"Мощный пылесос."];
    
    self.pageTextInfo = @[@"Тщательно вымойте автомобиль горизонтальными движениями снизу вверх. Мыть необходимо под углом 30-45 градусов от поверхности  автомобиля, а  наконечник моющего пистолета держать на расстоянии 15-30 см от автомобиля.",
                          
        @"Остатки загрязнений и моющего средства удаляются чистой водой под давлением. Мойте автомобиль сверху вниз. Данная программа позволяет максимально быстро смыть остатки грязи и моющего средства. (С данной задачей не может качественно справиться 3 и 4 программы, т.к. 3 программа – это воск и он не смоет, а наоборот покроет остатки грязи и моющего средства, а 4 программа – деминерализованная, умягчённая вода, которая  будет смывать на много дольше чем 2 программа).",
                          
        @"Обеспечивает защиту лакокрасочного покрытия, благодаря использованию горячего воска.\n60-ти градусная умягченная вода смешивается с воском и равномерно распределяется по поверхности вашего автомобиля. Таким образом, вы наносите стойкую защитную пленку, которая предохраняет кузов от последующих загрязнений, обладает водоотталкивающим эффектом. Наносить воск следует только на чистую поверхность! Обрабатывать сверху вниз.",
                          
        @"Тщательно ополосните автомобиль сверху вниз.\nНЕ ВЫТИРАЙТЕ!\nКузов промывается деминерализованной водой с осушающим и обеспечивающим блеск средством. Вода без минералов стаскивает за собой остатки солей. Высохшая поверхности остается без пятен и подтеков, а кузов машины – чистым, блестящим и защищенным от агрессивного воздействия окружающей среды.",
                          
        @"Есть возможность использования пылесоса, что позволяет привести в порядок салон Вашего автомобиля. \nОплата пылесоса возможна жетонами."];
    
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    
    PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height );
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.revealButtonItem setTarget: self.revealViewController];
        [self.revealButtonItem setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (PageContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.pageTitles count] == 0) || (index >= [self.pageTitles count])) {
        return nil;
    }
    PageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
    pageContentViewController.titleText = self.pageTitles[index];
    pageContentViewController.imageBG = self.pageBGImage[index];
    pageContentViewController.imageLogo = self.pageLogoImaage[index];
    pageContentViewController.detailText = self.pageDetail[index];
    pageContentViewController.textInfo = self.pageTextInfo[index];
    pageContentViewController.pageIndex = index;
    
    return pageContentViewController;
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
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
