//
//  MenuViewController.m
//  SAM
//
//  Created by User on 14.10.16.
//  Copyright © 2016 freshtech. All rights reserved.
//

#import "MenuViewController.h"
#import "API.h"

@implementation SWUITableViewCell
@end
@interface MenuViewController () <UITableViewDelegate ,UITableViewDataSource>

@end

@implementation MenuViewController

- (void) prepareForSegue: (UIStoryboardSegue *) segue sender: (id) sender
{
    // configure the destination view controller:
    if ( [sender isKindOfClass:[UITableViewCell class]] )
    {
//        UILabel* c = [(SWUITableViewCell *)sender label];
//        UINavigationController *navController = segue.destinationViewController;
//        ColorViewController* cvc = [navController childViewControllers].firstObject;
//        if ( [cvc isKindOfClass:[ColorViewController class]] )
//        {
//            cvc.color = c.textColor;
//            cvc.text = c.text;
//        }
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.f;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    switch ( indexPath.row )
    {
        case 0:
            CellIdentifier = @"map";
            break;
            
        case 1:
            CellIdentifier = @"myCoin";
            break;
            
        case 2:
            CellIdentifier = @"help";
            break;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier forIndexPath: indexPath];
    
    return cell;
}

#pragma mark state preservation / restoration
- (void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    // TODO save what you need here
    
    [super encodeRestorableStateWithCoder:coder];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    // TODO restore what you need here
    
    [super decodeRestorableStateWithCoder:coder];
}

- (void)applicationFinishedRestoringState {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
}

- (IBAction)btnClose:(id)sender {
    [self performSegueWithIdentifier:@"closeApp" sender:self];
}
@end
