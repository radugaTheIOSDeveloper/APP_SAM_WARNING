//
//  PageContentViewControllerNews.m
//  SAM
//
//  Created by Георгий Зуев on 10/08/2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import "PageContentViewControllerNews.h"

@interface PageContentViewControllerNews ()

@end

@implementation PageContentViewControllerNews



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageNews.image= [UIImage imageNamed:self.imageBG];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
