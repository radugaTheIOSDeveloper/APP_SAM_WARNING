//
//  SwitchMap.h
//  SAM
//
//  Created by User on 23.01.17.
//  Copyright © 2017 freshtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwitchMap : UIViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *revealButtonItem;
@property (weak, nonatomic) IBOutlet UIView *containerView;

- (IBAction)listBtnAct:(id)sender;

- (IBAction)maoBtnAct:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *listView;
@property (weak, nonatomic) IBOutlet UIView *mapView;

@end
