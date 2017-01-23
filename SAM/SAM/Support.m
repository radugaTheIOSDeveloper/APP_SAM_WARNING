//
//  Support.m
//  SAM
//
//  Created by User on 07.11.16.
//  Copyright © 2016 freshtech. All rights reserved.
//

#import "Support.h"
#import "SWRevealViewController.h"
#import <MessageUI/MessageUI.h>

@interface Support () <UITextViewDelegate, MFMailComposeViewControllerDelegate>

@end

@implementation Support

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    NSMutableAttributedString * str = [[NSMutableAttributedString alloc] initWithString:@"Если у Вас возникли проблемы, отправьте письмо на\n support@pomoysam.ru\n Спасибо ждем Вас снова!"];
    [str addAttribute: NSLinkAttributeName value: @"mailto:" range: NSMakeRange(51, 19)];
    self.textView.attributedText = str;
    [self.textView  setFont: [UIFont fontWithName:@"Optima" size:16]];
    [self.textView setTextColor:[UIColor colorWithRed:40.0/255 green:40.0/255 blue:40.0/255 alpha:1.0]];
    self.textView.selectable = YES;
    [self.textView setTextAlignment:NSTextAlignmentCenter];
    
    UITapGestureRecognizer *listener = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self.textView addGestureRecognizer:listener];

    SWRevealViewController * revealViewController = self.revealViewController;
    
    if ( revealViewController )
    {
        [self.revealButtonItem setTarget: self.revealViewController];
        [self.revealButtonItem setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
}
- (void)tapAction:(UITapGestureRecognizer *)sender

{
    if ([MFMailComposeViewController canSendMail])
    {
        NSString *messageBody = @"";
        NSArray *toRecipents = [NSArray arrayWithObject:@"support@pomoysam.ru"];
        
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
        mc.mailComposeDelegate = self;
        [mc setMessageBody:messageBody isHTML:NO];
        [mc setToRecipients:toRecipents];
        
        [self presentViewController:mc animated:YES completion:NULL];    }
    else
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Ошибка отправления"
                                     message:@"На Вашем устройстве не добавлена почта в iCloud"
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
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    
    switch (result) {
        case MFMailComposeResultSent:
            NSLog(@"You sent the email.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"You saved a draft of this email");
            break;
        case MFMailComposeResultCancelled:
            NSLog(@"You cancelled sending this email.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed:  An error occurred when trying to compose this email");
            break;
        default:
            NSLog(@"An error occurred when trying to compose this email");
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
