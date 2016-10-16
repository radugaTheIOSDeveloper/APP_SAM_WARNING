//
//  CalloutAnnotationView.m
//  SAM
//
//  Created by User on 24.08.16.
//  Copyright © 2016 freshtech. All rights reserved.
//

#import "CalloutAnnotationView.h"
#import "CalloutAnnotation.h"


@implementation CalloutAnnotationView

- (id)initWithAnnotation:(id<MKAnnotation>)annotation
         reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.frame = CGRectMake(0.0f, 0.0f, 280, 160);
        self.backgroundColor = [UIColor whiteColor];
        self.logoImage = [[UIImageView alloc]init];
         self.logoImage.image = [UIImage imageNamed:@"imagAutoMap"];
         self.logoImage.frame = CGRectMake(30, 20, 40, 30);
        [self addSubview: self.logoImage];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 5, 180, 60)];
        self.titleLabel.textColor = [UIColor blackColor];
        [self.titleLabel setFont:[UIFont fontWithName:@"Roboto-Light" size:14]];
         self.titleLabel.numberOfLines = 3;
         self.titleLabel.textColor = [UIColor grayColor];
        [self addSubview:self.titleLabel];
        
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.button setFrame:CGRectMake(40,60, 220,50)];
        [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.button setTitle:@"Помыть машину" forState:UIControlStateNormal];
        [self.button setImage:[UIImage imageNamed:@"buttonMap"] forState:UIControlStateNormal];
     //   [self.button addTarget:self action:@selector(calloutButtonClicked) forControlEvents:UIControlEventTouchUpInside];
       UILabel * Label = [[UILabel alloc] initWithFrame:CGRectMake(40,10, 159, 30)];
        Label.textColor = [UIColor whiteColor];
        Label.text = @"Помыть машину";
       [Label setFont:[UIFont fontWithName:@"Roboto-Light" size:16]];
        [self.button addSubview:Label];
        
        [self addSubview:self.button];
        
        _button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.button2 setFrame:CGRectMake(50, 110, 220, 40)];
        self.button2.tintColor = [UIColor whiteColor];
        [self.button2 setTitle:@"проложить" forState:UIControlStateNormal];
        [self.button2 setImage:[UIImage imageNamed:@"buttonMap"] forState:UIControlStateNormal];
        
        UILabel * Label2 = [[UILabel alloc] initWithFrame:CGRectMake(20,7, 159, 30)];
        Label2.textColor = [UIColor whiteColor];
        Label2.text = @"Проложить маршрут";
        [Label2 setFont:[UIFont fontWithName:@"Roboto-Light" size:15]];
        [self.button2 addSubview:Label2];
        [self addSubview:self.button2];
        
    }
    
    return self;
}


-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    self.titleLabel.text = self.title;
}

#pragma mark - Button clicked

//
//- (void)calloutButtonClicked
//{
//    NSLog(@"calloutButtonClicked");
//    CalloutAnnotation *annotation = self.annotation;
//    [self.delegate calloutButtonClicked:(NSString *)annotation.title];
//}

@end
