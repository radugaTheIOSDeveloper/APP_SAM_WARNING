//
//  MenuViewController.m
//  SAM
//
//  Created by User on 14.10.16.
//  Copyright © 2016 freshtech. All rights reserved.
//

#import "MenuViewController.h"
#import "API.h"
#import "SWRevealViewController.h"
#import <Security/Security.h>
#import <KeychainItemWrapper.h>


@implementation SWUITableViewCell
@end
@interface MenuViewController () <UITableViewDelegate ,UITableViewDataSource>

@end

@implementation MenuViewController{
    NSArray *menuItems;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:0 forKey:@"need_activate"];
    
        menuItems = @[@"map", @"myCoin", @"help", @"news",@"support",@"social"];
    
    NSLog(@"%@",[[API apiManager]getToken]);
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
    return menuItems.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [menuItems objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // Set the title of navigation bar by using the menu items
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    UINavigationController *destViewController = (UINavigationController*)segue.destinationViewController;
    destViewController.title = [[menuItems objectAtIndex:indexPath.row] capitalizedString];
    
    // Set the photo if it navigates to the PhotoView
//    if ([segue.identifier isEqualToString:@"showPhoto"]) {
//        UINavigationController *navController = segue.destinationViewController;
//        PhotoViewController *photoController = [navController childViewControllers].firstObject;
//        NSString *photoFilename = [NSString stringWithFormat:@"%@_photo", [menuItems objectAtIndex:indexPath.row]];
//        photoController.photoFilename = photoFilename;
//    }
}

- (IBAction)btnClose:(id)sender {
    [[API apiManager]setToken:NULL];
    [self performSegueWithIdentifier:@"closeApp" sender:self];
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:NULL forKey:@"token"];
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

@end
