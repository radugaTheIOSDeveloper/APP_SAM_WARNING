//
//  CalloutAnnotationView.h
//  SAM
//
//  Created by User on 24.08.16.
//  Copyright © 2016 freshtech. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@protocol CalloutAnnotationViewDelegate;

@interface CalloutAnnotationView : MKAnnotationView

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIButton *button2;
@property (nonatomic, strong) UIImageView * logoImage;
@property (nonatomic, strong) UIImageView * displayView;

@property (nonatomic, assign) id<CalloutAnnotationViewDelegate> delegate;
@end

@protocol CalloutAnnotationViewDelegate
@required
//- (void)calloutButtonClicked:(NSString *)title;
//-(MKAnnotationView*)imag;

@end
