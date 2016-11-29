//
//  ConfirmAuthorize.m
//  SAM
//
//  Created by User on 28.11.16.
//  Copyright © 2016 freshtech. All rights reserved.
//

#import "ConfirmAuthorize.h"

@interface ConfirmAuthorize ()

@end

@implementation ConfirmAuthorize

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)autoristionButton:(id)sender {
    [self performSegueWithIdentifier:@"newAutorisation" sender:self];
}

@end
