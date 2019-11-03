//
//  MapViewController.m
//  SAM
//
//  Created by User on 05.09.16.
//  Copyright © 2016 freshtech. All rights reserved.
//

#import "MapViewController.h"
#import "PinAnnotation.h"
#import "CalloutAnnotationView.h"
#import "UIView+MKAnnotationView.h"
#import "BuyCoins.h"


#define AllTrim(string) [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
@interface MapViewController ()<MKMapViewDelegate, CalloutAnnotationViewDelegate,CLLocationManagerDelegate>

@property (strong, nonatomic) CLGeocoder * geoCoder;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) MKDirections * directions;
@property (strong, nonnull) NSString * titleStr;
@property (assign, nonatomic) double routeDistance;
@property (strong, nonatomic) MKMapItem *destination;
@property  MKAnnotationView * annotationView ;
@property BOOL status;

@end

@implementation MapViewController

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    
  //  [mapView setRegion:mapRegion animated:NO];
    
    [self.activitiIndicator stopAnimating];
    self.activitiIndicator.alpha = 0.f;
    self.labelLoad.alpha = 0.f;

    if (self.status == true) {
        [self.mapView setCenterCoordinate:mapView.userLocation.location.coordinate animated:YES];

    }    
}

- (void)dealloc{
    
    [self.mapView removeFromSuperview]; // release crashes app
    self.mapView = nil;
    if ([self.directions isCalculating]) {
        [self.directions cancel];
    }
}

- (void)viewDidLoad {
    
    
    
    self.routeDistance = 1000.f;
    [super viewDidLoad];
    self.status = false;
    
    
    [self.mapView setDelegate:self];
    [self.mapView setShowsUserLocation:YES];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];
    
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    CLLocation *location = [_locationManager location];
    CLLocationCoordinate2D  coordinate = [location coordinate];
    // showing them in the mapView
    _mapView.region = MKCoordinateRegionMakeWithDistance(coordinate, 10000, 10000);
    
    [self.locationManager startUpdatingLocation];
    self.geoCoder = [[CLGeocoder alloc]init];
    
    PinAnnotation * annotation = [[PinAnnotation alloc]init];
    annotation.coordinate = CLLocationCoordinate2DMake(54.007482, 38.252156);
    annotation.title = @"Новомосковск, ул. Космонавтов, 35Б";
    [self.mapView addAnnotation:annotation];
    
    PinAnnotation * annotation1 = [[PinAnnotation alloc]init];
    annotation1.coordinate = CLLocationCoordinate2DMake(54.033654, 37.489695);
    annotation1.title = @"пос. Первомайский";
    [self.mapView addAnnotation:annotation1];
    
    PinAnnotation * annotation2 = [[PinAnnotation alloc]init];
    annotation2.coordinate = CLLocationCoordinate2DMake(54.187362, 37.529558);
    annotation2.title = @"Одоевске ш.";
    [self.mapView addAnnotation:annotation2];
    
    PinAnnotation * annotation3 = [[PinAnnotation alloc]init];
    annotation3.coordinate = CLLocationCoordinate2DMake(54.207003, 37.623024);
    annotation3.title = @"Ряжская 1А";
    [self.mapView addAnnotation:annotation3];
    
    PinAnnotation * annotation4 = [[PinAnnotation alloc]init];
    annotation4.coordinate = CLLocationCoordinate2DMake(54.209238, 37.645939);
    annotation4.title = @"Веневское ш. 2Б";
    [self.mapView addAnnotation:annotation4];
    
    PinAnnotation * annotation5 = [[PinAnnotation alloc]init];
    annotation5.coordinate = CLLocationCoordinate2DMake(54.167056, 37.631806);
    annotation5.title = @"Рязанская 46А";
    [self.mapView addAnnotation:annotation5];
    
    PinAnnotation * annotation6 = [[PinAnnotation alloc]init];
    annotation6.coordinate = CLLocationCoordinate2DMake(54.211388, 37.696394);
    annotation6.title = @"Вильямса 46";
    [self.mapView addAnnotation:annotation6];

   
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIBarButtonItem *zoomButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"search"] style:UIBarButtonItemStylePlain target:self action:@selector(actionShowAll:)];


    self.navigationItem.rightBarButtonItem = zoomButton;
    
    [self.activitiIndicator startAnimating];

    if ([CLLocationManager locationServicesEnabled]){
        
        NSLog(@"Location Services Enabled");
        
        
        if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusDenied){
            
            [self.activitiIndicator stopAnimating];
            self.activitiIndicator.alpha = 0.f;
            self.labelLoad.alpha = 0.f;
            
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:@"Служба геолокации отключена!"
                                          message:@"Включить службу геолокации в настройках?"
                                          preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                                     
                                     [alert dismissViewControllerAnimated:YES completion:nil];
                                     
                                 }];
            UIAlertAction* cancel = [UIAlertAction
                                     actionWithTitle:@"Cancel"
                                     style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction * action)
                                     {
                                         [alert dismissViewControllerAnimated:YES completion:nil];
                                     }];
            [alert addAction:ok];
            [alert addAction:cancel];
            
            dispatch_async(dispatch_get_main_queue(), ^ {
                [self presentViewController:alert animated:YES completion:nil];
            });
        }
        
        
    }
    

    
    
}




- (void)actionShowAll:(id)sender {
    
    [self mapView:self.mapView didDeselectAnnotationView:self.annotationView];
    
    CLLocation *location = [_locationManager location];
    CLLocationCoordinate2D  coordinate = [location coordinate];
    _mapView.region = MKCoordinateRegionMakeWithDistance(coordinate, 10000, 10000);
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    NSString *identifier= @"PIN";
    MKAnnotationView * annotationView = (MKAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if ([annotation isKindOfClass:[PinAnnotation class]]) {
        identifier = @"Pin";
        annotationView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:identifier];
            annotationView.image = [UIImage imageNamed:@"mapIcon"];
        }
        
    } else if ([annotation isKindOfClass:[CalloutAnnotation class]]) {
        identifier = @"Callout";
        annotationView = (CalloutAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[CalloutAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        }
        CalloutAnnotation *calloutAnnotation = (CalloutAnnotation *)annotation;
        ((CalloutAnnotationView *)annotationView).title = calloutAnnotation.title;
        ((CalloutAnnotationView *)annotationView).delegate = self;
        [((CalloutAnnotationView *)annotationView).button2 addTarget:self action:@selector(route:) forControlEvents:UIControlEventTouchUpInside];
        [((CalloutAnnotationView *)annotationView).button addTarget:self action:@selector(segue:) forControlEvents:UIControlEventTouchUpInside];
        
        [annotationView setNeedsDisplay];
        [annotationView setCenterOffset:CGPointMake(0, -100)];
        [UIView animateWithDuration:0.5f
                         animations:^(void) {
                             mapView.centerCoordinate = calloutAnnotation.coordinate;
                             
                         }];
    }
    
    annotationView.annotation = annotation;
    return annotationView;
}



-(void)segue:(UIButton *)sender{
    
    [self performSegueWithIdentifier:@"MAP" sender:self];
}

-(void)route:(UIButton*)sender{

    CGFloat strLatitude = self.annotationView.annotation.coordinate.latitude;
    CGFloat strLongitude = self.annotationView.annotation.coordinate.longitude;
    
    NSString *appleLink2 = [NSString stringWithFormat:@"http://maps.apple.com/?sll=&daddr=%f,%f&t=s",strLatitude,strLongitude];
    
    NSURL * URL = [NSURL URLWithString:appleLink2];
    //    UIApplication *application = [UIApplication sharedApplication];
    //    [application openURL:URL options:@{} completionHandler:nil];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] openURL:URL];
    });
    
}


- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    if ([view.annotation isKindOfClass:[PinAnnotation class]]) {
        
        self.annotationView = view;
        // Selected the pin annotation.
        CalloutAnnotation *calloutAnnotation = [[CalloutAnnotation alloc] init];
        PinAnnotation *pinAnnotation = ((PinAnnotation *)view.annotation);
        calloutAnnotation.title = pinAnnotation.title;
        self.titleStr = pinAnnotation.title;
        calloutAnnotation.coordinate = pinAnnotation.coordinate;
        pinAnnotation.calloutAnnotation = calloutAnnotation;
        [mapView addAnnotation:calloutAnnotation];
    }
}
//----------------------------------------------------------------------

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    
    if ([view.annotation isKindOfClass:[PinAnnotation class]]) {
        // Deselected the pin annotation.
        PinAnnotation *pinAnnotation = ((PinAnnotation *)view.annotation);
        [mapView removeAnnotation:pinAnnotation.calloutAnnotation];
        
        pinAnnotation.calloutAnnotation = nil;
    }
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.mapView.pitchEnabled = YES;
    [self.mapView setShowsBuildings:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    BuyCoins * coins;
    NSLog(@"%@",self.titleStr);
    if ([[segue identifier] isEqualToString:@"MAP"]){
        coins = [segue destinationViewController];
        coins.titleStr = @"MAP";
    }
}

@end
