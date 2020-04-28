//
//  FAQFormViewController.h
//  SAM
//
//  Created by Георгий Зуев on 16/09/2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FAQFormViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageBackground;
- (IBAction)goodBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UITextField *editTextName;
- (IBAction)actEditText:(id)sender;

@end

NS_ASSUME_NONNULL_END
