//
//  FAQViewController.m
//  SAM
//
//  Created by Георгий Зуев on 11/08/2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import "FAQViewController.h"
//#import "UIColor+AppColors.h"
#import "API.h"


static int const kHeaderSectionTag = 6900;

@interface FAQViewController ()

@property (assign) NSInteger expandedSectionHeaderNumber;
@property (assign) UITableViewHeaderFooterView *expandedSectionHeader;
//@property (strong) NSArray *sectionItems;
@property (strong) NSArray *sectionNames;
@property (strong, nonatomic) NSMutableArray * sectionItems;
//@property (strong, nonatomic) NSMutableArray * sectionNames;


@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation FAQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.sectionItems = [NSMutableArray array];
    
  // self.sectionItems = [NSMutableArray array];
    
//    self.sectionNames = @[ @"Вопрос 1", @"Вопрос 2", @"Вопрос 3" ];
//    self.sectionItems = @[ @[@"Это ответ 1"],
//                           @[@"Это ответ 2"],
//                           @[@"Это ответ 3 и он невероятно огромен нахуй так что ты не пизди и смотри в оба чухонец ебаный"]
//                           ];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    self.expandedSectionHeaderNumber = -1;
    
    [self getFAQ];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [self.tabBarController setTitle:@"Обратная связь"];

}



-(void) getFAQ {
    
    
    [[API apiManager]getFAQ:^(NSDictionary *responceObject) {
//
        NSLog(@"faq responce = %@", responceObject);
        NSArray * questions = [responceObject valueForKey:@"question"];
        self.sectionNames = questions;
        
        NSArray * answers = [responceObject valueForKey:@"answer"];
        
   
        for (int i= 0; i<answers.count; i++) {
            
            [self.sectionItems addObject:@[[answers objectAtIndex:i]]];
        }
        
      //  self.sectionItems = @[questions];
//
//
     //   self.sectionItems = @[@[@"This will d add:"],@[@"231312312"]];
        
        
        [self.tableView reloadData];
        [self.expandedSectionHeader reloadInputViews];
        
    
        
    } onFailure:^(NSError *error, NSInteger statusCode) {
       
    }];
    

}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    if (self.sectionNames.count > 0) {
        self.tableView.backgroundView = nil;
        return self.sectionNames.count;
    } else {
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        
        messageLabel.text = @"Retrieving data.\nPlease wait.";
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
        [messageLabel sizeToFit];
        self.tableView.backgroundView = messageLabel;
        
        return 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.expandedSectionHeaderNumber == section) {
        NSMutableArray *arrayOfItems = [self.sectionItems objectAtIndex:section];
        return arrayOfItems.count;
    } else {
        return 0;
    }
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    if (self.sectionNames.count) {
//        return [self.sectionNames objectAtIndex:section];
//    }
//
//    return @"";
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section; {

    return [self heightForText:[self.sectionNames objectAtIndex:section]] + 20;

}


-(CGFloat) heightForText:(NSString*) text {
    
    CGFloat offset = 1.0;
    
    UIFont* font = [UIFont systemFontOfSize:14.f];
    
    NSMutableParagraphStyle* paragraph = [[NSMutableParagraphStyle alloc] init];
    [paragraph setLineBreakMode:NSLineBreakByWordWrapping];
    
    NSDictionary* attributes =
    [NSDictionary dictionaryWithObjectsAndKeys:
     font , NSFontAttributeName,
     paragraph, NSParagraphStyleAttributeName, nil];
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(320 - 2 * offset, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil];
    
    return CGRectGetHeight(rect) + 2 * offset;
    
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
    
    view.backgroundColor = [UIColor clearColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, tableView.frame.size.width - 50, [self heightForText:[self.sectionNames objectAtIndex:section]] + 20)];
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 0;

    label.backgroundColor = [UIColor clearColor];
    
    //[label setFont:[UIFont boldSystemFontOfSize:14]];
    
    [label setFont:[UIFont fontWithName:@"Avenir Next" size:14]];
    
     NSString *string =[self.sectionNames objectAtIndex:section];
    /* Section header is in 0th index... */
    [label setText:string];
    [view addSubview:label];
    return view;
}


- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {

    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;

    header.backgroundColor = [UIColor whiteColor];
    
//    header.contentView.backgroundColor =  [UIColor whiteColor];
//    header.textLabel.textColor = [UIColor blackColor];
//    header.textLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
//
//
//    UIImageView *viewWithTag = [self.view viewWithTag:kHeaderSectionTag + section];
//    if (viewWithTag) {
//        [viewWithTag removeFromSuperview];
//    }
//    // add the arrow image
    UIImageView *theImageView = [[UIImageView alloc] initWithFrame:CGRectMake(260, 17, 10 , 5)];
    theImageView.image = [UIImage imageNamed:@"support"];
    theImageView.tag = kHeaderSectionTag + section;
    [header addSubview:theImageView];
//
//    NSLog(@" view controller");

    // make headers touchable
    header.tag = section;
    UITapGestureRecognizer *headerTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionHeaderWasTouched:)];
    [header addGestureRecognizer:headerTapGesture];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableCell" forIndexPath:indexPath];
    NSArray *section = [self.sectionItems objectAtIndex:indexPath.section];
    
    cell.contentView.backgroundColor =[UIColor colorWithRed:231.0f/255.0f
           green:51.0f/255.0f
            blue:54.0f/255.0f
           alpha:0.2f];

    cell.textLabel.text = [section objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)updateTableViewRowDisplay:(NSArray *)arrayOfIndexPaths {
    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:arrayOfIndexPaths withRowAnimation: UITableViewRowAnimationFade];
    [self.tableView endUpdates];
}

#pragma mark - Expand / Collapse Methods

- (void)sectionHeaderWasTouched:(UITapGestureRecognizer *)sender {
    UITableViewHeaderFooterView *headerView = (UITableViewHeaderFooterView *)sender.view;


    NSInteger section = headerView.tag;
    UIImageView *eImageView = (UIImageView *)[headerView viewWithTag:kHeaderSectionTag + section];
    self.expandedSectionHeader = headerView;
    
    if (self.expandedSectionHeaderNumber == -1) {
        
        headerView.backgroundColor = [UIColor colorWithRed:231.0f/255.0f
                                                     green:51.0f/255.0f
                                                      blue:54.0f/255.0f
                                                     alpha:0.2f];

        self.expandedSectionHeaderNumber = section;
        [self tableViewExpandSection:section withImage: eImageView];
    } else {
        
        headerView.backgroundColor = [UIColor whiteColor];
        
        
        
        if (self.expandedSectionHeaderNumber == section) {
            [self tableViewCollapeSection:section withImage: eImageView];
            self.expandedSectionHeader = nil;
        } else {
            UIImageView *cImageView  = (UIImageView *)[self.view viewWithTag:kHeaderSectionTag + self.expandedSectionHeaderNumber];
            [self tableViewCollapeSection:self.expandedSectionHeaderNumber withImage: cImageView];
            [self tableViewExpandSection:section withImage: eImageView];
        }
        
    }
}

- (void)tableViewCollapeSection:(NSInteger)section withImage:(UIImageView *)imageView {
    NSArray *sectionData = [self.sectionItems objectAtIndex:section];
    
    self.expandedSectionHeaderNumber = -1;
    if (sectionData.count == 0) {
        return;
    } else {
        

        [UIView animateWithDuration:0.4 animations:^{
            imageView.transform = CGAffineTransformMakeRotation((0.0 * M_PI) / 180.0);
        }];
        NSMutableArray *arrayOfIndexPaths = [NSMutableArray array];
        for (int i=0; i< sectionData.count; i++) {
            NSIndexPath *index = [NSIndexPath indexPathForRow:i inSection:section];
            [arrayOfIndexPaths addObject:index];
        }
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:arrayOfIndexPaths withRowAnimation: UITableViewRowAnimationFade];
        [self.tableView endUpdates];
    }
}

- (void)tableViewExpandSection:(NSInteger)section withImage:(UIImageView *)imageView {
    NSArray *sectionData = [self.sectionItems objectAtIndex:section];
    
    if (sectionData.count == 0) {
        self.expandedSectionHeaderNumber = -1;
        return;
    } else {
        [UIView animateWithDuration:0.4 animations:^{
            imageView.transform = CGAffineTransformMakeRotation((180.0 * M_PI) / 180.0);
        }];
        NSMutableArray *arrayOfIndexPaths = [NSMutableArray array];
        for (int i=0; i< sectionData.count; i++) {
            NSIndexPath *index = [NSIndexPath indexPathForRow:i inSection:section];
            [arrayOfIndexPaths addObject:index];
        }
        self.expandedSectionHeaderNumber = section;
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:arrayOfIndexPaths withRowAnimation: UITableViewRowAnimationFade];
        [self.tableView endUpdates];
    }
}



- (IBAction)unwindToThisViewController:(UIStoryboardSegue *)unwindSegue
{
    
}

@end
