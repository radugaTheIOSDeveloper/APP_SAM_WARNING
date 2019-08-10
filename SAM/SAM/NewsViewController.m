//
//  NewsViewController.m
//  SAM
//
//  Created by User on 31.10.16.
//  Copyright © 2016 freshtech. All rights reserved.
//

#import "NewsViewController.h"
#import "SWRevealViewController.h"
#import "API.h"
#import <UIImageView+AFNetworking.h>
#import  <Reachability.h>


@interface NewsViewController () <UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) NSArray * groupArr;
@property (strong, nonatomic) UIRefreshControl * refreshControl;
@property (strong, nonatomic) NSArray * newsArr;
@property (assign, nonatomic) BOOL statusInternet;
@property (strong, nonatomic) UIView * entFailedView;
@property (strong, nonatomic) UILabel * entLabel;

@end

@implementation NewsViewController{
    
}

-(void) getRefreshEvents {
    
    [[API apiManager]getRefreshEvents:^(NSDictionary *responceObject) {
        [self stopActivityIndicator];
        self.statusInternet = true;
        [self.refreshControl endRefreshing];
        NSArray * arResponseNews = [[NSArray alloc] initWithObjects:responceObject, nil];
        self.newsArr = [arResponseNews objectAtIndex:0];
        
        [self.tableView reloadData];

        
    } onFailure:^(NSError *error, NSInteger statusCode) {
        [self.refreshControl endRefreshing];

        [self stopActivityIndicator];
        self.statusInternet = false;

    }];
}


-(void) getEvents {
    
    [[API apiManager]getEvents:^(NSDictionary *responceObject) {
        [self.refreshControl endRefreshing];
        [self stopActivityIndicator];
        NSArray * arResponseNews = [[NSArray alloc] initWithObjects:responceObject, nil];
        self.newsArr = [arResponseNews objectAtIndex:0];
        [self.tableView reloadData];
        self.statusInternet = true;

    } onFailure:^(NSError *error, NSInteger statusCode) {
        [self.refreshControl endRefreshing];

        [self stopActivityIndicator];
        self.statusInternet = false;

    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.revealButtonItem setTarget: self.revealViewController];
        [self.revealButtonItem setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.view addSubview:self.activityIndicator];
    self.activityIndicator.center = CGPointMake([[UIScreen mainScreen]bounds].size.width/2, [[UIScreen mainScreen]bounds].size.height/2);
    self.activityIndicator.color = [UIColor redColor];
    
    self.activityIndicator.alpha = 1.f;
    [self.view setUserInteractionEnabled:NO];
    [self.activityIndicator startAnimating];
    
    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(refreshView:) forControlEvents:UIControlEventValueChanged];
    self.refreshControl.tintColor = [UIColor redColor];
    
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

    self.newsArr = [[NSArray alloc]init];
    
    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable)
    {
        [self getEvents];
        
    }
    else
    {
        [self getRefreshEvents];
        
        
    }

    
}

-(void) stopActivityIndicator {
    
    self.activityIndicator.alpha = 0.f;
    [self.view setUserInteractionEnabled:YES];
    [self.activityIndicator stopAnimating];
    
}

-(void) refreshView: (UIRefreshControl *) refresh{
    
    // refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Идет обновление..."];
    
    
    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable)
    {
        
        [UIView animateWithDuration:0.8 animations:^{
            self.entFailedView.alpha = 1.0;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:2.0 animations:^{
                self.entFailedView.alpha = 0.0;
            }];
        }];
        
        [self.refreshControl endRefreshing];
        
    }else{
        self.entFailedView.alpha = 0.f;
        [self getRefreshEvents];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.5f;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *tempView=[[UIView alloc]init];
    
    tempView.backgroundColor=[UIColor lightGrayColor];
    return tempView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ([self.newsArr count] == 0) {
        return 1;
    }else{
        return [self.newsArr count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.newsArr count] == 0) {
        return 50.f;
    } else{
        return 520.f;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.newsArr count] == 0) {
        
        static NSString * ide = @"nill";
        UITableViewCell * cellNill = [tableView dequeueReusableCellWithIdentifier:ide];
        UILabel * title = (UILabel *)[cellNill.contentView viewWithTag:874];
        title.text = @"Нет новых событий";
        
        return cellNill;
        
    } else {
        
        NSDictionary * curNews = [self.newsArr objectAtIndex:indexPath.row];
        NSLog(@"%@",curNews);
        
        static NSString * ide = @"news";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ide];
        UILabel * title = (UILabel *)[cell.contentView viewWithTag:872];
        UITextView * detail = (UITextView *)[cell.contentView viewWithTag:870];
        title.text = [curNews objectForKey:@"eventName"];
        detail.text = [curNews objectForKey:@"eventDescription"];
        
        UIImageView * images = (UIImageView *)[cell.contentView viewWithTag:871];
        NSString * strUrl;
        NSURL *url;
        NSURLRequest *imageRequest;
        
        strUrl = [curNews objectForKey:@"eventImage"];
        url = [NSURL URLWithString:strUrl];
        imageRequest = [NSURLRequest requestWithURL:url
                                        cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                    timeoutInterval:60];
        
        [images setImageWithURLRequest:imageRequest
                      placeholderImage:nil
                               success:nil
                               failure:nil];
        
        return cell;
    }
    
}
@end
