//
//  SocialController.m
//  SAM
//
//  Created by User on 25.11.16.
//  Copyright © 2016 freshtech. All rights reserved.
//

#import "SocialController.h"
#import "SWRevealViewController.h"

@interface SocialController ()

@end

@implementation SocialController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
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
    // Dispose of any resources that can be recreated.
}

- (IBAction)shareBtn:(id)sender {
    
    NSString * message = @"Я рекомендую сеть автомоек самообслуживания САМ\nБудь вкурсе всех новостей:\nНаш сайт: https://pomoysam.ru\nМы в VK: https://vk.com/pomoysamru\nМы в Одноклассниках: http://ok.ru/group/54177483260148\nМы в Инстаграмме: https://www.instagram.com/moykasam/\nСкачайте приложение:\nApp Store: https://itunes.apple.com/us/app/mojka-sam/id1166195716?l=ru&ls=1&mt=8\nGoogle Play: https://play.google.com/store/apps/details?id=ru.pomoysam.itstack";
    
    UIImage * image = [UIImage imageNamed:@"screenSocial"];
    
    NSArray * shareItems = @[message, image];
    
    UIActivityViewController * avc = [[UIActivityViewController alloc] initWithActivityItems:shareItems applicationActivities:nil];
    
    [self presentViewController:avc animated:YES completion:nil];
    
}
@end
