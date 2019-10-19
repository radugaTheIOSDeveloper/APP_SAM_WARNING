//
//  FAQFormViewController.m
//  SAM
//
//  Created by Георгий Зуев on 16/09/2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import "FAQFormViewController.h"
#import <CCDropDownMenus/CCDropDownMenus.h>

@interface FAQFormViewController () <CCDropDownMenuDelegate>

@end

@implementation FAQFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];

 
    ManaDropDownMenu * menu =  [[ManaDropDownMenu alloc] initWithFrame:CGRectMake(20  , 200, 300, 50) title:@"Hellow"];
    menu.delegate = self;
    menu.numberOfRows = 3;

    menu.indicator = [UIImage imageNamed:@"support"];
    menu.textOfRows = @[@"123", @"123", @"123"];
    
    [self.view addSubview:menu];

}

//- (void)dropDownMenu:(CCDropDownMenu *)dropDownMenu didSelectRowAtIndex:(NSInteger)index {
//
//
//
//}

@end
