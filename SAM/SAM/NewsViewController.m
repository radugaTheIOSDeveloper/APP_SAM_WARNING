//
//  NewsViewController.m
//  SAM
//
//  Created by User on 31.10.16.
//  Copyright © 2016 freshtech. All rights reserved.
//

#import "NewsViewController.h"
#import "SWRevealViewController.h"


@interface NewsViewController () <UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) NSArray * groupArr;
@property (strong, nonatomic) NSArray * array;

@end

@implementation NewsViewController

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
    
    _array  = [[NSArray alloc]initWithObjects:@"Акция", nil];
    _groupArr = [[NSArray alloc] initWithObjects:_array, nil];
    
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

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *tempView=[[UIView alloc]initWithFrame:CGRectMake(self.tableView.frame.origin.x,self.tableView.frame.origin.y,self.self.tableView.frame.origin.x,50)];
//    tempView.backgroundColor=[UIColor whiteColor];
//    
//    UILabel *tempLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.tableView.frame.size.width/2-50,tempView.frame.origin.y/2,100,34)];
//    tempLabel.backgroundColor=[UIColor whiteColor];
//    tempLabel.textAlignment = NSTextAlignmentCenter;
//    tempLabel.textColor = [UIColor blackColor];
//    [tempLabel setFont:[UIFont fontWithName:@"Roboto-Bold" size:16.f]];
//
//    tempLabel.text= @"События";
//    [tempView addSubview:tempLabel];
//    
//    return tempView;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 480.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * ide = @"news";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ide];
    UILabel * title = (UILabel *)[cell.contentView viewWithTag:872];
    UITextView * detail = (UITextView *)[cell.contentView viewWithTag:870];
    title.text = @"Заголовок";
    detail.text = @"Разнообразный и богатый опыт постоянный количественный рост и сфера нашей активности в значительной степени.";
    
    UIImageView * images = (UIImageView *)[cell.contentView viewWithTag:871];
    images.image = [UIImage imageNamed:@"news"];
    
    return cell;
    
}
@end
