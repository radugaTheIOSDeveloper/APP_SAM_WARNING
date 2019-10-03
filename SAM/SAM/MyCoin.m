//
//  MyCoin.m
//  SAM
//
//  Created by User on 05.09.16.
//  Copyright © 2016 freshtech. All rights reserved.
//

#import "MyCoin.h"
#import "BuyCoins.h"
#import "QREncoder.h"
#import "API.h"
#import  <Reachability.h>


@interface MyCoin () <UITableViewDelegate, UITableViewDataSource>

@property (assign, nonatomic) NSInteger indexBtn;
@property (strong, nonatomic) NSMutableArray * activeCount;
@property (strong, nonatomic) NSMutableArray * pastCount;
@property (strong, nonatomic) NSString * typeQR;
@property (strong, nonatomic) UIButton * buyCoin;
@property (strong, nonatomic) UIRefreshControl * refreshControl;
@property (assign, nonatomic) BOOL statusInternet;
@property (strong, nonatomic) UIView * entFailedView;
@property (strong, nonatomic) UILabel * entLabel;
@end

@implementation MyCoin

#pragma mark ViewDidLoad

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationController.navigationItem.backBarButtonItem = false;
    
    self.activeView.backgroundColor = [UIColor redColor];
    self.pastView.backgroundColor = [UIColor whiteColor];
    self.indexBtn = 0;
    
    self.activeCount = [NSMutableArray array];
    self.pastCount = [NSMutableArray array];
    
    self.buyCoin = [UIButton buttonWithType:UIButtonTypeCustom];
    self.buyCoin.frame = CGRectMake(self.view.frame.size.width/2 + 80, self.view.frame.size.height/2 + 170, 80, 80);
    [self.buyCoin addTarget:self action:@selector(buyCoinBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.buyCoin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.buyCoin setBackgroundImage:[UIImage imageNamed:@"btnBuy"] forState:UIControlStateNormal];
    [self.view addSubview:self.buyCoin];
    
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
    
    //refresh
    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(refreshView:) forControlEvents:UIControlEventValueChanged];
    self.refreshControl.tintColor = [UIColor redColor];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.title = @"Мои покупки";
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.view addSubview:self.activityIndicator];
    self.activityIndicator.center = CGPointMake([[UIScreen mainScreen]bounds].size.width/2, [[UIScreen mainScreen]bounds].size.height/2);
    self.activityIndicator.color = [UIColor redColor];
    
   // [self.tableView reloadData];
    
    self.activityIndicator.alpha = 1.f;
    [self.view setUserInteractionEnabled:NO];
    [self.activityIndicator startAnimating];
    
    
    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable)
    {
        [self getUserQRCode];
      
    }
    else
    {
        [self getRefreshUserQR];


    }

    
}

#pragma marl API DELETE

-(void) stopActivityIndicator {
    
    self.activityIndicator.alpha = 0.f;
    [self.view setUserInteractionEnabled:YES];
    [self.activityIndicator stopAnimating];
    
}

-(void) deleteUsedQR:(NSString *) qrCodeID {
    
    [[API apiManager] deleteUsedQR:qrCodeID
                         onSuccess:^(NSDictionary *responseObject) {
                             [self getRefreshUserQR];
                             if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable)
                             {
                                 [self alerts];
                             }
                             else
                             {
                                 [self getRefreshUserQR];
                                 
                                 
                             }

                             [self.activityIndicator startAnimating];
                             [self.tableView reloadData];
                         } onFailure:^(NSError *error, NSInteger statusCode) {
                             [self alerts];
                         }];
}

-(void) alerts{
    
    UIAlertController * alert = [UIAlertController
                          alertControllerWithTitle:@"Ошибка удаления"
                                 message:@"Ошибка соединения"
                                    preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"OK"
                                          style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    
                                }];
    
    [alert addAction:yesButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark API "GET USER QR"

-(void) getUserQRCode {

    
    [[API apiManager]getUserQR:^(NSDictionary *responceObject) {
    
        [self  stopActivityIndicator];
        NSMutableArray * active = [responceObject valueForKey:@"active"];
        self.activeCount = active;
        NSMutableArray * nonActive = [responceObject valueForKey:@"inactive"];
        self.pastCount = nonActive;
        [self.refreshControl endRefreshing];
        self.statusInternet = true;
        [self.tableView reloadData];

    } onFailure:^(NSError *error, NSInteger statusCode) {
        
        [self  stopActivityIndicator];
        self.statusInternet = false;
        [self.tableView reloadData];
        
    }];
}



-(void)getRefreshUserQR{
    
    
        [[API apiManager] getRefreshUserQR:^(NSDictionary *responceObject) {
            
            [self  stopActivityIndicator];

            NSMutableArray * active = [responceObject valueForKey:@"active"];
            self.activeCount = active;
            NSMutableArray * nonActive = [responceObject valueForKey:@"inactive"];
            self.pastCount = nonActive;
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



#pragma mark TableView DataSource/Delegate

- (NSInteger)numberOfSectionsInTableView: (UITableView *) tableView{
    return 1;
}

-(void)buyCoinBtn:(UIButton *)sender {
    
    [self performSegueWithIdentifier:@"buyCoins" sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 85.f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.indexBtn == 0) {
            
        if ([self.activeCount count] == 0) {
            return  1;
        } else {
            return [self.activeCount count];
        }

    } else if (self.indexBtn == 1) {
            
        if ([self.pastCount count] == 0) {
            return  1;
        } else {
            return [self.pastCount count];
        }
        
    } else {
        return 0;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * ideActive = @"cell";
    static NSString * idePast = @"callPast";
    static NSString * ideNo = @"cellNoBuy";
//    static NSString * ideInternet = @"errorCell";
    
    if (self.indexBtn == 0) {
        
        if ([self.activeCount count] == 0) {
                
            UITableViewCell * cellNoBuy = [tableView dequeueReusableCellWithIdentifier:ideNo];
            UILabel * nonLabel = (UILabel *)[cellNoBuy.contentView viewWithTag:97];
            nonLabel.text = @"У вас нет покупок.Чтобы приобрести жетоны нажмите на \"+\"";
            self.tableView.allowsSelection = NO;
            self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
                
            return cellNoBuy;
            
        } else {
                
            self.tableView.scrollEnabled = YES;
            self.tableView.allowsSelection = YES;
            self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
            NSDictionary * curCoinActive = [self.activeCount objectAtIndex:indexPath.row];
            UITableViewCell * cellACtive = [tableView dequeueReusableCellWithIdentifier:ideActive];
            UIImageView * imageCoin = (UIImageView *)[cellACtive.contentView viewWithTag:10];
            UILabel * nameSam = (UILabel *)[cellACtive.contentView viewWithTag:11];
            UILabel * date = (UILabel *)[cellACtive.contentView viewWithTag:12];
            UILabel * detailLabel = (UILabel *)[cellACtive.contentView viewWithTag:60];
            detailLabel.text = [NSString stringWithFormat:@"Жетонов на 4 минуты: %@ Жетонов на 2 минуты: %@",[curCoinActive objectForKey:@"4minutes_str"],[curCoinActive objectForKey:@"2minutes_str"]];
                
            imageCoin.image = [UIImage imageNamed:@"coinPast"];
            nameSam.textColor = [UIColor colorWithRed:111/255.0f green:113/255.0f blue:121/255.0f alpha:1];
            nameSam.text = [curCoinActive objectForKey:@"minutes_str"];
            date.text = [curCoinActive objectForKey:@"pay_date"];
                
            return cellACtive;
        }
        
        
    } else if (self.indexBtn == 1) {
        
        if ([self.pastCount count] == 0) {
                    
            UITableViewCell * cellNoBuys = [tableView dequeueReusableCellWithIdentifier:ideNo];
            UILabel * nonLabel = (UILabel *)[cellNoBuys.contentView viewWithTag:97];
            nonLabel.text = @"У вас нет использованных жетонов";
            self.tableView.allowsSelection = NO;
            self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
                    
            return cellNoBuys;
                    
        } else {
                    
            self.tableView.scrollEnabled = YES;
            self.tableView.allowsSelection = YES;
            self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
            NSDictionary * curCoinPast = [self.pastCount objectAtIndex:indexPath.row];
            UITableViewCell * cellPast = [tableView dequeueReusableCellWithIdentifier:idePast];
            UIImageView * imageCoin = (UIImageView *)[cellPast.contentView viewWithTag:20];
            UILabel * nameSam = (UILabel *)[cellPast.contentView viewWithTag:21];
            UILabel * date = (UILabel *)[cellPast.contentView viewWithTag:22];
            UILabel * detailLabel = (UILabel *)[cellPast.contentView viewWithTag:61];
            detailLabel.text = [NSString stringWithFormat:@"Жетонов на 4 минуты: %@ Жетонов на 2 минуты: %@",[curCoinPast objectForKey:@"4minutes_str"],[curCoinPast objectForKey:@"2minutes_str"]];
            imageCoin.image = [UIImage imageNamed:@"coinPast"];
            nameSam.textColor = [UIColor colorWithRed:236/255.0f green:88/255.0f blue:98/255.0f alpha:1];
            nameSam.text = [curCoinPast objectForKey:@"minutes_str"];
            date.text = [curCoinPast objectForKey:@"pay_date"];
                    
            return cellPast;
        }
            
    } else {
        return nil;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
     if (self.indexBtn == 0) {
         NSDictionary * curCoinPast = [self.activeCount objectAtIndex:indexPath.row];
         self.stringQR = [curCoinPast objectForKey:@"qr_code"];
     }else {
         NSDictionary * curCoinPast = [self.pastCount objectAtIndex:indexPath.row];
         self.stringQR = [curCoinPast objectForKey:@"qr_code"];
     }
        [self performSegueWithIdentifier:@"myBuy" sender:self];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.indexBtn == 0) {
        return NO;
    } else  if ([self.pastCount count]==0){
        return NO;
    } else {
        return YES;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary * curCoinPast = [self.pastCount objectAtIndex:indexPath.row];
    if (self.indexBtn == 1) {
        
        NSLog(@"%@",[curCoinPast objectForKey:@"qr_code_id"]);
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            [self deleteUsedQR:[curCoinPast objectForKey:@"qr_code_id"]];
    }
        
    }
}

    
- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0) __TVOS_PROHIBITED{
    return @"УДАЛИТЬ";
}

#pragma mark Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    QREncoder * segueMyBuy;
    BuyCoins * buyCoin;
    if ([[segue identifier] isEqualToString:@"myBuy"]){
        
        segueMyBuy = [segue destinationViewController];

        if (self.indexBtn == 0) {
            segueMyBuy.stringQR = self.stringQR;
            
        } else {
            segueMyBuy.stringQR = @"nonActive";
        }

        } else if ([[segue identifier] isEqualToString:@"buyCoins"]) {
            buyCoin = [segue destinationViewController];
            buyCoin.titleStr = @"MyCoin";
    }
}

#pragma mark Button Action

- (IBAction)btnActiveBuy:(id)sender {
    
    self.activeView.backgroundColor = [UIColor redColor];
    self.pastView.backgroundColor = [UIColor whiteColor];
    self.indexBtn = 0;
    [self.tableView reloadData];
}

- (IBAction)btnPastBuy:(id)sender {
    self.activeView.backgroundColor = [UIColor whiteColor];
    self.pastView.backgroundColor = [UIColor redColor];
    self.indexBtn = 1;
    [self.tableView reloadData];
    
}

@end
