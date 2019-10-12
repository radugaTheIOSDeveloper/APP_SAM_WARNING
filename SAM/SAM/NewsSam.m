//
//  NewsSam.m
//  SAM
//
//  Created by Георгий Зуев on 10/08/2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import "NewsSam.h"
#import "QREncoder.h"
#import "API.h"
#import  <Reachability.h>

@interface NewsSam ()  <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UIRefreshControl * refreshControl;
@property (assign, nonatomic) BOOL statusInternet;
@property (strong, nonatomic) NSMutableArray * activeCount;
@property (strong, nonatomic) UIView * entFailedView;
@property (strong, nonatomic) UILabel * entLabel;


@end

@implementation NewsSam

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"news view controller");
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.view addSubview:self.activityIndicator];
    self.activityIndicator.center = CGPointMake([[UIScreen mainScreen]bounds].size.width/2, [[UIScreen mainScreen]bounds].size.height/2);
    self.activityIndicator.color = [UIColor redColor];
    
    self.activityIndicator.alpha = 1.f;
    [self.view setUserInteractionEnabled:NO];
    [self.activityIndicator startAnimating];
    self.pageBGImage = [NSMutableArray array];
    
    self.entFailedView = [[UIView alloc] init];
    self.entFailedView.frame = CGRectMake(self.view.frame.size.width/2 - 100 ,self.view.frame.size.height/2 + 100,200, 50);
    self.entFailedView.backgroundColor = [UIColor colorWithRed:228/255.0f green:0/255.0f blue:11/255.0f alpha:1];
    [self.view addSubview:self.entFailedView];
    self.entFailedView.layer.cornerRadius = 25.0f;
    self.entFailedView.alpha = 0.f;
    
    self.entLabel = [[UILabel alloc]init];
    self.entLabel.frame = CGRectMake(self.entFailedView.frame.size.width/2 - 60, 15, 120, 20);
    [self.entFailedView addSubview:self.entLabel];
    self.entLabel.textColor = [UIColor whiteColor];
    self.entLabel.text = @"Нет доступа к сети";
    self.entLabel.textAlignment = NSTextAlignmentCenter;
    UIFont * customFont = [UIFont fontWithName:@"Optima" size:12];
    [self.entLabel setFont:customFont];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.title = @"Новости";
    
    [self getUserQRCode];
    [self getNews];
#pragma mark PageViewControllelr
    
//
   
    
    
}

-(void)pageContentViewControllerNews{
    
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewControllerB"];
    self.pageViewController.dataSource = self;
    
    
    PageContentViewControllerNews *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    self.pageViewController.view.frame = CGRectMake(0, 0, self.viewPage.frame.size.width, self.viewPage.frame.size.height );
    
    [self addChildViewController:_pageViewController];
    [self.viewPage addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
}


- (PageContentViewControllerNews *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.pageBGImage count] == 0) || (index >= [self.pageBGImage count])) {
        return nil;
    }
    PageContentViewControllerNews *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewControlB"];
    pageContentViewController.imageBG = self.pageBGImage[index];
    pageContentViewController.pageIndex = index;
    
    return pageContentViewController;
}



- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewControllerNews*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewControllerNews*) viewController).pageIndex;
    
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

-(void) getNews{
    
    [[API apiManager]getNews:^(NSDictionary *responceObject) {
        
        NSLog(@"%@",responceObject);
        
        
        [self stopActivityIndicator];
        NSMutableArray * active = [responceObject valueForKey:@"image"];
        NSString * strUrl;
        for (int i = 0; i < active.count; i++) {
            strUrl = [NSString stringWithFormat:@"https://app.pomoysam.ru%@",[active objectAtIndex:i]];
            [self.pageBGImage addObject:strUrl];
        }
        
        [self pageContentViewControllerNews];
        
    } onFailure:^(NSError *error, NSInteger statusCode) {
        NSLog(@"%@",error);
    }];
}

-(void) getUserQRCode {
    
    
    [[API apiManager]getUserQR:^(NSDictionary *responceObject) {
        
        [self  stopActivityIndicator];
        NSMutableArray * active = [responceObject valueForKey:@"active"];
        self.activeCount = active;
        [self.refreshControl endRefreshing];
        self.statusInternet = true;
        [self.tableView reloadData];
        
    } onFailure:^(NSError *error, NSInteger statusCode) {
        
        [self  stopActivityIndicator];
        self.statusInternet = false;
        [self.tableView reloadData];
        
    }];
}


-(void) stopActivityIndicator {
    
    self.activityIndicator.alpha = 0.f;
    [self.view setUserInteractionEnabled:YES];
    [self.activityIndicator stopAnimating];
    
}


- (NSInteger)numberOfSectionsInTableView: (UITableView *) tableView{
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 85.f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ([self.activeCount count] == 0) {
        return  1;
    } else {
        return 1;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * ideActive = @"cellnewsactive";
    static NSString * ideNo = @"cellnewsfalse";
    
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.scrollEnabled = NO;
    
    if ([self.activeCount count] == 0) {
        self.tableView.allowsSelection = NO;

        UITableViewCell * cellNoBuy = [tableView dequeueReusableCellWithIdentifier:ideNo];
        UILabel * nonLabel = (UILabel *)[cellNoBuy.contentView viewWithTag:410];
        nonLabel.text = @"У вас нет покупок.";
   
        return cellNoBuy;
        
    } else {
        

        self.tableView.allowsSelection = YES;

        
        NSDictionary * curCoinActive = [self.activeCount objectAtIndex:0];
        UITableViewCell * cellACtive = [tableView dequeueReusableCellWithIdentifier:ideActive];
        UIImageView * imageCoin = (UIImageView *)[cellACtive.contentView viewWithTag:574];
        UIImageView * imageClock = (UIImageView *)[cellACtive.contentView viewWithTag:573];
        
        UILabel * nameSam = (UILabel *)[cellACtive.contentView viewWithTag:570];
        UILabel * date = (UILabel *)[cellACtive.contentView viewWithTag:572];
        UILabel * detailLabel = (UILabel *)[cellACtive.contentView viewWithTag:571];
        detailLabel.text = [NSString stringWithFormat:@"Жетонов на 4 минуты: %@ Жетонов на 2 минуты: %@",[curCoinActive objectForKey:@"4minutes_str"],[curCoinActive objectForKey:@"2minutes_str"]];
        imageClock.image = [UIImage imageNamed:@"iconClock"];
        imageCoin.image = [UIImage imageNamed:@"iconMyBy"];
        //nameSam.textColor = [UIColor colorWithRed:111/255.0f green:113/255.0f blue:121/255.0f alpha:1];
        nameSam.text = [curCoinActive objectForKey:@"minutes_str"];
        date.text = [curCoinActive objectForKey:@"pay_date"];
        
        return cellACtive;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary * curCoinPast = [self.activeCount objectAtIndex:indexPath.row];
    self.stringQR = [curCoinPast objectForKey:@"qr_code"];
    self.timeQR = [curCoinPast objectForKey:@"minutes_str"];
    
    [self performSegueWithIdentifier:@"qrcods" sender:self];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    QREncoder * segueMyBuy;
    if ([[segue identifier] isEqualToString:@"qrcods"]){
        
        segueMyBuy = [segue destinationViewController];
        
        segueMyBuy.stringQR = self.stringQR;
        segueMyBuy.timeQR = self.timeQR;
        
    }
}


- (IBAction)byCoinAct:(id)sender {
}
@end
