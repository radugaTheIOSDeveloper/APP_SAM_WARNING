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
#import "SWRevealViewController.h"


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
    MKCoordinateRegion mapRegion;
    
  //  [mapView setRegion:mapRegion animated:NO];
    
    [self.activitiIndicator stopAnimating];
    self.activitiIndicator.alpha = 0.f;
    self.labelLoad.alpha = 0.f;

    if (self.status == true) {
        [self.mapView setCenterCoordinate:mapView.userLocation.location.coordinate animated:YES];
//        MKCoordinateSpan span;
//        span.latitudeDelta = 0.005;
//        span.longitudeDelta = 0.005;
//        CLLocationCoordinate2D location;
//        location.latitude = userLocation.coordinate.latitude;
//        location.longitude = userLocation.coordinate.longitude;
//        mapRegion.span = span;
//        mapRegion.center = location;
//        [self.mapView setRegion:mapRegion animated:YES];

        if (self.routeDistance <= 0.01f) {
            [self alerts];
            
        } else {
            
            [self.directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *  response, NSError *  error) {
                if (error) {
                    NSLog(@"1231");
                } else if ([response.routes count]== 0) {
                    NSLog(@"123");
                } else {
                    [self showRoute:response];
                }
                
            }];
            
        }
    } else {
        NSLog(@"123");
    }

    
    
}


-(void) alerts{
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Вы приехали"
                                  message:nil
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"OK"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    self.viewDetail.alpha = 0.f;
                                    [self.mapView removeOverlays:[self.mapView overlays]];
                                    self.viewDetail.alpha = 0.f;
                                    self.routeDistance = 1000.f;
                                    self.status = false;
                                }];
    
    [alert addAction:yesButton];
   
    [self presentViewController:alert animated:YES completion:nil];
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
    self.viewDetail.alpha = 0.f;
    self.status = false;
    
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logoMenu"]];
    
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
    annotation.title = @"г. Новомосковск, ул. Космонавтов (где автосалон КИА)";
    [self.mapView addAnnotation:annotation];
    
    PinAnnotation * annotation1 = [[PinAnnotation alloc]init];
    annotation1.coordinate = CLLocationCoordinate2DMake(54.033654, 37.489695);
    annotation1.title = @"г. Щекино, пос.Первомайский, ул.Пролетарская, д.19";
    [self.mapView addAnnotation:annotation1];
    
    PinAnnotation * annotation2 = [[PinAnnotation alloc]init];
    annotation2.coordinate = CLLocationCoordinate2DMake(54.187362, 37.529558);
    annotation2.title = @"г. Тула, Одоевское шоссе (напротив д. 85 - ОАО Балтика-Тула)";
    [self.mapView addAnnotation:annotation2];
    
    PinAnnotation * annotation3 = [[PinAnnotation alloc]init];
    annotation3.coordinate = CLLocationCoordinate2DMake(54.207003, 37.623024);
    annotation3.title = @"г. Тула, ул. Ряжская, дом 1 (около Ряжского вокзала)";
    [self.mapView addAnnotation:annotation3];
    
    PinAnnotation * annotation4 = [[PinAnnotation alloc]init];
    annotation4.coordinate = CLLocationCoordinate2DMake(54.209238, 37.645939);
    annotation4.title = @"г. Тула, Центральный район, пересечение ул. Каракозова";
    [self.mapView addAnnotation:annotation4];
    
    PinAnnotation * annotation5 = [[PinAnnotation alloc]init];
    annotation5.coordinate = CLLocationCoordinate2DMake(54.167056, 37.631806);
    annotation5.title = @"г. Тула, Центральный район, ул. Рязанская, дом 46-а";
    [self.mapView addAnnotation:annotation5];
    
    PinAnnotation * annotation6 = [[PinAnnotation alloc]init];
    annotation6.coordinate = CLLocationCoordinate2DMake(54.211388, 37.696394);
    annotation6.title = @"г. Тула, Пролетарский район, ул. Вильямса (напротив д. 46)";
    [self.mapView addAnnotation:annotation6];
    
    
    PinAnnotation * annotation7 = [[PinAnnotation alloc]init];
    annotation7.coordinate = CLLocationCoordinate2DMake(54.196345, 37.604139);
    annotation7.title = @"ТЕСТ";
    [self.mapView addAnnotation:annotation7];

   
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIBarButtonItem *zoomButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"search"] style:UIBarButtonItemStylePlain target:self action:@selector(actionShowAll:)];


    self.navigationItem.rightBarButtonItem = zoomButton;
    [self customSetup];
    
    [self.activitiIndicator startAnimating];

}

- (void)customSetup
{
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.revealButtonItem setTarget: self.revealViewController];
        [self.revealButtonItem setAction: @selector( revealToggle: )];
        [self.navigationController.navigationBar addGestureRecognizer: self.revealViewController.panGestureRecognizer];
    }
}
#pragma mark state preservation / restoration

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    // Save what you need here
    
    [super encodeRestorableStateWithCoder:coder];
}


- (void)decodeRestorableStateWithCoder:(NSCoder *)coder
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    // Restore what you need here
    
    [super decodeRestorableStateWithCoder:coder];
}


- (void)applicationFinishedRestoringState
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    // Call whatever function you need to visually restore
    [self customSetup];
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

    [self mapView:self.mapView didDeselectAnnotationView:self.annotationView];
    [UIView animateWithDuration:0.2f
                     animations:^(void) {
                         
                         CLLocation *location = [_locationManager location];
                         CLLocationCoordinate2D  coordinate = [location coordinate];
                         _mapView.region = MKCoordinateRegionMakeWithDistance(coordinate, 100, 100);
                     }];
    
    self.viewDetail.alpha = 1.f;
//    [UIView animateWithDuration:0.1 animations:^{
//        self.viewDetail.alpha = 1.f;
//    } completion:^(BOOL finished) {
//        
//        [UIView animateWithDuration:0.3f animations:^{
//            
//            self.viewDetail.frame = CGRectMake(self.viewDetail.frame.origin.x,self.viewDetail.frame.origin.y - 64 ,self.viewDetail.frame.origin.x,self.viewDetail.frame.origin.y);
//            
//            
//        }];
//    }];

    self.activitiIndicator.alpha = 1.f;
    self.labelLoad.alpha = 1.f;
    
    self.labelLoad.text = @"Загрузка...";
    [self.activitiIndicator startAnimating];
    
    self.status = true;
    
    [self getDirections];
    
  }

- (void)getDirections
{
    
    if (!_annotationView) {
        return;
    }
    
    if ([self.directions isCalculating]) {
        [self.directions cancel];
    }
    
    CLLocationCoordinate2D coordinate = _annotationView.annotation.coordinate;
    MKDirectionsRequest * request = [[MKDirectionsRequest alloc]init];
    request.source = [MKMapItem mapItemForCurrentLocation];
    MKPlacemark * placemark = [[MKPlacemark alloc]initWithCoordinate:coordinate addressDictionary:nil];
    MKMapItem * destination = [[MKMapItem alloc]initWithPlacemark:placemark];
    request.destination = destination;
    request.transportType = MKDirectionsTransportTypeAutomobile;
    
    self.directions = [[MKDirections alloc]initWithRequest:request];
    [self.directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *  response, NSError *  error) {
        if (error) {
            NSLog(@"1231");
        } else if ([response.routes count] == 0) {
            NSLog(@"123");
        } else {
     
            [self showRoute:response];
        }
    }];
    
}

-(void)showRoute:(MKDirectionsResponse *)response
{
    
    [self.mapView removeOverlays:[self.mapView overlays]];
    
    NSMutableArray * array =  [NSMutableArray array];
    
   
    for (MKRoute *route in response.routes)
    {
        [array addObject:route.polyline];
        [self.mapView
         addOverlay:route.polyline level:MKOverlayLevelAboveRoads];
         self.lablelDistance.text = [NSString stringWithFormat:@"До чистой машины осталось %.02f км",(float)route.distance / 1000];
        self.routeDistance = route.distance / 1000;
        
        self.activitiIndicator.alpha = 0.f;
        self.labelLoad.alpha = 0.f;
        [self.activitiIndicator stopAnimating];
     
        for (MKRouteStep *step in route.steps)
        {
            NSLog(@"%@", step.instructions);
        }
    }
}

-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay{
    
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        MKPolylineRenderer * renderer = [[MKPolylineRenderer alloc]initWithOverlay:overlay];
        renderer.lineWidth = 2.f;
        renderer.strokeColor = [UIColor redColor];
        
        return renderer;
    }
    return nil;
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
