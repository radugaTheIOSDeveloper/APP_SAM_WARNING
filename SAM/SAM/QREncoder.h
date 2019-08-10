//
//  QREncoder.h
//  SAM
//
//  Created by User on 05.09.16.
//  Copyright © 2016 freshtech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "qrencode.h"

@interface QREncoder : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) NSString * stringQR;
@property (strong, nonatomic) NSString * timeQR;


- (UIImage *)quickResponseImageForString:(NSString *)dataString withDimension:(int)imageWidth;
@property (weak, nonatomic) IBOutlet UILabel *nonActive;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
