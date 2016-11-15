//
//  Support.m
//  SAM
//
//  Created by User on 07.11.16.
//  Copyright © 2016 freshtech. All rights reserved.
//

#import "Support.h"
#import "SWRevealViewController.h"


@interface Support () <UITextViewDelegate>

@end

@implementation Support

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//
    NSMutableAttributedString * str = [[NSMutableAttributedString alloc] initWithString:@"Если у вас возникли проблемы, отправьте письмо на\n support@pomoysam.ru\n Спасибо ждем вас снова!"];
    [str addAttribute: NSLinkAttributeName value: @"http://support@pomoysam.ru" range: NSMakeRange(51, 19)];
    self.textView.attributedText = str;
    
    [self.textView setDataDetectorTypes:UIDataDetectorTypeLink];
    self.textView.selectable = YES;
    [self.textView setTextAlignment:NSTextAlignmentCenter];

    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.revealButtonItem setTarget: self.revealViewController];
        [self.revealButtonItem setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
