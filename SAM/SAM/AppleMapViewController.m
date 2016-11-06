     //
//  AppleMapViewController.m
//  SAM
//
//  Created by User on 31.10.16.
//  Copyright © 2016 freshtech. All rights reserved.
//

#import "AppleMapViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "SWRevealViewController.h"


@interface AppleMapViewController () <UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate>

@property (strong, nonatomic) NSArray * sortedDistance;
@property (strong, nonatomic) NSArray * sortedLocation;
@property (nonatomic, strong) CLLocationManager *myLocationManager;
@property (strong, nonatomic) NSMutableDictionary * distance;
@property (strong, nonatomic) NSMutableDictionary * locations;
@property (assign, nonatomic) NSInteger status;
@end

@implementation AppleMapViewController
//
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *newLocation = locations[[locations count] -1];
    CLLocation *currentLocation = newLocation;
//    NSString *longitude = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
//    NSString *latitude = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
    
    if (currentLocation != nil) {
        
            [self start];
        
    }else {
            UIAlertView *errorAlert = [[UIAlertView alloc]
                                             initWithTitle:@"Error" message:@"Failed to Get Your Location"
                                             delegate:nil
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil];
                  [errorAlert show];
              }
}

-(void) start {
    
    CLLocation *startLocation = self.myLocationManager.location;
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:54.007482 longitude:38.252156];
    CLLocation *location1 = [[CLLocation alloc] initWithLatitude:54.033654 longitude:37.489695];
    CLLocation *location2 = [[CLLocation alloc] initWithLatitude:54.187362 longitude:37.529558];
    CLLocation *location3 = [[CLLocation alloc] initWithLatitude:54.207003 longitude:37.623024];
    CLLocation *location4 = [[CLLocation alloc] initWithLatitude:54.209238 longitude:37.645939];
    CLLocation *location5 = [[CLLocation alloc] initWithLatitude:54.167056 longitude:37.631806];
    CLLocation *location6 = [[CLLocation alloc] initWithLatitude:54.211388 longitude:37.696394];
    CLLocation *location7 = [[CLLocation alloc] initWithLatitude:54.196345 longitude:37.604139];
    
    self.distance = [NSMutableDictionary dictionary];
    self.locations = [NSMutableDictionary dictionary];
    
    float betweenDistance = [startLocation distanceFromLocation:location];
    float betweenDistance1 = [startLocation distanceFromLocation:location1];
    float betweenDistance2 = [startLocation distanceFromLocation:location2];
    float betweenDistance3 = [startLocation distanceFromLocation:location3];
    float betweenDistance4 = [startLocation distanceFromLocation:location4];
    float betweenDistance5= [startLocation distanceFromLocation:location5];
    float betweenDistance6 = [startLocation distanceFromLocation:location6];
    float betweenDistance7 = [startLocation distanceFromLocation:location7];
    
    
    [self.locations setObject:@(betweenDistance/1000) forKey:location];
    [self.locations setObject:@(betweenDistance1/1000) forKey:location1];
    [self.locations setObject:@(betweenDistance2/1000) forKey:location2];
    [self.locations setObject:@(betweenDistance3/1000) forKey:location3];
    [self.locations setObject:@(betweenDistance4/1000) forKey:location4];
    [self.locations setObject:@(betweenDistance5/1000) forKey:location5];
    [self.locations setObject:@(betweenDistance6/1000) forKey:location6];
    [self.locations setObject:@(betweenDistance7/1000) forKey:location7];
    
    [self.distance setObject:@(betweenDistance/1000) forKey:@"г. Новомосковск, ул. Космонавтов (где автосалон КИА)"];
    [self.distance setObject:@(betweenDistance1/1000) forKey: @"г. Щекино, пос.Первомайский, ул.Пролетарская, д.19"];
    [self.distance setObject:@(betweenDistance2/1000) forKey:@"г. Тула, Одоевское шоссе (напротив д. 85 - ОАО Балтика-Тула)"];
    [self.distance setObject:@(betweenDistance3/1000) forKey: @"г. Тула, ул. Ряжская, дом 1 (около Ряжского вокзала)"];
    [self.distance setObject:@(betweenDistance4/1000) forKey:@"г. Тула, Центральный район, пересечение ул. Каракозова"];
    [self.distance setObject:@(betweenDistance5/1000) forKey: @"г. Тула, Центральный район, ул. Рязанская, дом 46-а"];
    [self.distance setObject:@(betweenDistance6/1000) forKey: @"г. Тула, Пролетарский район, ул. Вильямса (напротив д. 46)"];
    [self.distance setObject:@(betweenDistance7/1000) forKey:@"Тест проверка"];
    
    [self sortDistance:self.distance sortLocation:self.locations];
    
    self.status = 1;
    [self.tableView reloadData];
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.status = 0;
    
 //  self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logoMenu"]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

    self.myLocationManager = [[CLLocationManager alloc] init];
    self.myLocationManager.delegate=self;
    [self.myLocationManager requestWhenInUseAuthorization];
    [self.myLocationManager startMonitoringSignificantLocationChanges];
    [self.myLocationManager startUpdatingLocation];

    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.revealButtonItem setTarget: self.revealViewController];
        [self.revealButtonItem setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
}



-(void) sortDistance:(NSMutableDictionary *) distance
        sortLocation:(NSMutableDictionary *) location{

    self.sortedDistance = [NSArray array];
    self.sortedDistance = [distance keysSortedByValueUsingComparator: ^(id obj1, id obj2)
                    {
                        if ([obj1 floatValue] > [obj2 floatValue])
                        {
                            return (NSComparisonResult)NSOrderedDescending;
                        }
                        if ([obj1 floatValue] < [obj2 floatValue])
                        {
                            return (NSComparisonResult)NSOrderedAscending;
                        }
                        
                        return (NSComparisonResult)NSOrderedSame;
                    }];
    
    
    self.sortedLocation = [NSArray array];
    self.sortedLocation = [location keysSortedByValueUsingComparator: ^(id obj1, id obj2)
                     {
                         if ([obj1 floatValue] > [obj2 floatValue])
                         {
                             return (NSComparisonResult)NSOrderedDescending;
                         }
                         if ([obj1 floatValue] < [obj2 floatValue])
                         {
                             return (NSComparisonResult)NSOrderedAscending;
                         }
                         
                         return (NSComparisonResult)NSOrderedSame;
                     }];
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140.f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.sortedDistance count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NSMutableArray* rowss = [[NSMutableArray alloc] init];
    NSMutableArray* addr = [[NSMutableArray alloc] init];
    
    for (NSString* key in self.sortedDistance)
    {
        CGFloat distance = [[self.distance objectForKey:key] floatValue];
        [rowss addObject:[NSString stringWithFormat:@"До мойки осталось %.02f км", distance]];
        [addr addObject:key];
        
    }
    
    UILabel * addrLabel = (UILabel*)[cell.contentView viewWithTag:1];
    UILabel * distance = (UILabel*)[cell.contentView viewWithTag:7];
    
    UIImageView * imageLogo = (UIImageView*)[cell.contentView viewWithTag:2];
    addrLabel.text = [addr objectAtIndex:indexPath.row];
    distance.text = [rowss objectAtIndex:indexPath.row];
    imageLogo.image = [UIImage imageNamed:@"bg"];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSMutableArray* addrs = [[NSMutableArray alloc] init];
    
    for (NSString* key in self.sortedLocation)
    {
        [addrs addObject:key];
    }
    
    CLLocation * location = [addrs objectAtIndex:indexPath.row];
    CGFloat strLatitude = location.coordinate.latitude;
    CGFloat strLongitude = location.coordinate.longitude;
    
    NSString *appleLink2 = [NSString stringWithFormat:@"http://maps.apple.com/?sll=&daddr=%f,%f&t=s",strLatitude,strLongitude];
    NSURL *URL = [NSURL URLWithString:appleLink2];
 
    if([[UIApplication sharedApplication] canOpenURL:URL]){ dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{ [[UIApplication sharedApplication] openURL:URL];
    });
    }
    
}

@end
