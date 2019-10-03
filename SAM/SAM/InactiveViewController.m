//
//  InactiveViewController.m
//  SAM
//
//  Created by User on 09.08.2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import "InactiveViewController.h"
#import "QREncoder.h"
#import "API.h"
#import  <Reachability.h>

@interface InactiveViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) UIRefreshControl * refreshControl;
@property (assign, nonatomic) BOOL statusInternet;
@property (strong, nonatomic) NSMutableArray * inactiveCount;
@property (strong, nonatomic) UIView * entFailedView;
@property (strong, nonatomic) UILabel * entLabel;
@end

@implementation InactiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.view addSubview:self.activityIndicator];
    self.activityIndicator.center = CGPointMake([[UIScreen mainScreen]bounds].size.width/2, [[UIScreen mainScreen]bounds].size.height/2);
    self.activityIndicator.color = [UIColor redColor];
    
    self.activityIndicator.alpha = 1.f;
    [self.view setUserInteractionEnabled:NO];
    [self.activityIndicator startAnimating];
    
    
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
    
    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(refreshView:) forControlEvents:UIControlEventValueChanged];
    self.refreshControl.tintColor = [UIColor redColor];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.title = @"Мои покупки";
    
    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable)
    {
        [self getUserQRCode];
        
    }
    else
    {
        [self getRefreshUserQR];
        
        
    }
}
    
   

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(void) getUserQRCode {
    
    
    [[API apiManager]getUserQR:^(NSDictionary *responceObject) {
        
        [self  stopActivityIndicator];
        NSMutableArray * active = [responceObject valueForKey:@"inactive"];
        self.inactiveCount = active;
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

-(void)getRefreshUserQR{
    
    
    [[API apiManager] getRefreshUserQR:^(NSDictionary *responceObject) {
        
        [self  stopActivityIndicator];
        
        NSMutableArray * inactive = [responceObject valueForKey:@"inactive"];
        self.inactiveCount = inactive;
        [self.refreshControl endRefreshing];
        self.statusInternet = true;
        [self.tableView reloadData];
        
        
    } onFailure:^(NSError *error, NSInteger statusCode) {
        
        [self  stopActivityIndicator];
        [self.tableView reloadData];
        
    }];
    
}

#pragma mark Refresh

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
        [self getRefreshUserQR];
    }
}

- (NSInteger)numberOfSectionsInTableView: (UITableView *) tableView{
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 85.f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ([self.inactiveCount count] == 0) {
        return  1;
    } else {
        return [self.inactiveCount count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * ideActive = @"cellinactivetrue";
    static NSString * ideNo = @"cellinactivefalse";
    
    
    self.tableView.allowsSelection = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if ([self.inactiveCount count] == 0) {
        
        UITableViewCell * cellNoBuy = [tableView dequeueReusableCellWithIdentifier:ideNo];
        UILabel * nonLabel = (UILabel *)[cellNoBuy.contentView viewWithTag:402];
        nonLabel.text = @"У вас нет покупок.";

        
        return cellNoBuy;
        
    } else {
        

        NSDictionary * curCoinActive = [self.inactiveCount objectAtIndex:indexPath.row];
        UITableViewCell * cellACtive = [tableView dequeueReusableCellWithIdentifier:ideActive];
        UIImageView * imageCoin = (UIImageView *)[cellACtive.contentView viewWithTag:564];
        UIImageView * imageClock = (UIImageView *)[cellACtive.contentView viewWithTag:563];
        
        UILabel * nameSam = (UILabel *)[cellACtive.contentView viewWithTag:560];
        UILabel * date = (UILabel *)[cellACtive.contentView viewWithTag:562];
        UILabel * detailLabel = (UILabel *)[cellACtive.contentView viewWithTag:561];
        detailLabel.text = [NSString stringWithFormat:@"Жетонов на 4 минуты: %@ Жетонов на 2 минуты: %@",[curCoinActive objectForKey:@"4minutes_str"],[curCoinActive objectForKey:@"2minutes_str"]];
        imageClock.image = [UIImage imageNamed:@"lightClock"];
        imageCoin.image = [UIImage imageNamed:@"loghtMybu"];
        //nameSam.textColor = [UIColor colorWithRed:111/255.0f green:113/255.0f blue:121/255.0f alpha:1];
        nameSam.text = [curCoinActive objectForKey:@"minutes_str"];
        date.text = [curCoinActive objectForKey:@"pay_date"];
        
        return cellACtive;
    }
    
}



- (IBAction)byBtn:(id)sender {
}
@end
