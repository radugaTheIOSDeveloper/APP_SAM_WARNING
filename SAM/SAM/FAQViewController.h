//
//  FAQViewController.h
//  SAM
//
//  Created by Георгий Зуев on 11/08/2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FAQViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
//- (IBAction)linkMail:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@end

NS_ASSUME_NONNULL_END
