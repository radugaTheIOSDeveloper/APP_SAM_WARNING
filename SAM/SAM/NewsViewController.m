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


@interface NewsViewController () <UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) NSArray * groupArr;
@property (strong, nonatomic) NSMutableArray * arNews;

@end

@implementation NewsViewController{
    
}

-(void) getEvents {
    
    [[API apiManager]getEvents:^(NSDictionary *responceObject) {
        NSLog(@"%@",responceObject);
        NSArray * arResponseNews = [[NSArray alloc] initWithObjects:responceObject, nil];
        [self.arNews addObjectsFromArray:[arResponseNews objectAtIndex:0]];
        [self.tableView reloadData];
        
    } onFailure:^(NSError *error, NSInteger statusCode) {
        NSLog(@"%@",error);
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
  //self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logoMenu"]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.revealButtonItem setTarget: self.revealViewController];
        [self.revealButtonItem setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    
    self.arNews = [NSMutableArray array];
      //  _groupArr = [[NSArray alloc] initWithObjects:_array, nil];
 
//    self.tableView.estimatedRowHeight = 400.0;
//    self.tableView.rowHeight = UITableViewAutomaticDimension;


    [self getEvents];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark UITableViewDelegate
//
//-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 50.f;
//}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.5f;
}



//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *tempView=[[UIView alloc]init];
    
    tempView.backgroundColor=[UIColor lightGrayColor];
    return tempView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ([self.arNews count] == 0) {
        return 1;
    }else{
        return [self.arNews count];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.arNews count] == 0) {
        return 50.f;
    } else{
        return  520.f;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if ([self.arNews count] == 0) {
        
        static NSString * ide = @"nill";
        UITableViewCell * cellNill = [tableView dequeueReusableCellWithIdentifier:ide];
        UILabel * title = (UILabel *)[cellNill.contentView viewWithTag:874];
        title.text = @"Нет новых событий";
        
        return cellNill;
        
    } else {
        
        NSDictionary * curNews = [self.arNews objectAtIndex:indexPath.row];
        NSLog(@"%@",curNews);
        
        static NSString * ide = @"news";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ide];
        UILabel * title = (UILabel *)[cell.contentView viewWithTag:872];
        UITextView * detail = (UITextView *)[cell.contentView viewWithTag:870];
        title.text = [curNews objectForKey:@"eventName"];
        detail.text = [curNews objectForKey:@"eventDescription"];
        
        UIImageView * images = (UIImageView *)[cell.contentView viewWithTag:871];
        //images.image = [UIImage imageNamed:@"news"];
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
