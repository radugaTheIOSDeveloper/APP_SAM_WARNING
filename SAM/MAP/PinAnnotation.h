//
//  PinAnnotation.h
//  SAM
//
//  Created by User on 24.08.16.
//  Copyright © 2016 freshtech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "CalloutAnnotation.h"

@interface PinAnnotation : NSObject <MKAnnotation>

@property (nonatomic, copy) NSString *title;
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) CalloutAnnotation *calloutAnnotation;

@end
