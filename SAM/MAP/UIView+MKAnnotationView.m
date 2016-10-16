//
//  UIView+MKAnnotationView.m
//  MapTestInBkPtdelno
//
//  Created by User on 03.12.15.
//  Copyright (c) 2015 freshtech. All rights reserved.
//

#import "UIView+MKAnnotationView.h"

@implementation UIView (MKAnnotationView)

- (MKAnnotationView*) superAnnotationView {
    
    if ([self.superview isKindOfClass:[MKAnnotationView class]]) {
        return (MKAnnotationView*)self.superview;
    }
    
    return nil;
}

@end
