//
//  MyTabBarController.h
//  SAM
//
//  Created by User on 09.08.2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTabBarController : UITabBarController

@property(strong,nonatomic) NSString * indexSelctedTab;
- (IBAction)actionExit:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *exit;

@end
