//
//  FAQFormViewController.h
//  SAM
//
//  Created by Георгий Зуев on 16/09/2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FAQFormViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageBackground;
- (IBAction)goodBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

NS_ASSUME_NONNULL_END
