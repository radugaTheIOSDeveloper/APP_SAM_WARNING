//
//  MapViewController.h
//  SAM
//
//  Created by User on 05.09.16.
//  Copyright © 2016 freshtech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController

@property (weak, nonatomic) IBOutlet MKMapView *mapView;



@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activitiIndicator;
@property (weak, nonatomic) IBOutlet UILabel *labelLoad;



@end
