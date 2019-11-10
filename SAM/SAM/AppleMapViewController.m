//  AppleMapViewController.m
//  SAM
//  Created by User on 31.10.16.
//  Copyright © 2016 freshtech. All rights reserved.
//

#import "AppleMapViewController.h"
#import <CoreLocation/CoreLocation.h>


@interface AppleMapViewController () <UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate,UIAlertViewDelegate>

@property (strong, nonatomic) NSArray * sortedDistance;
@property (strong, nonatomic) NSArray * sortedLocation;
@property (strong, nonatomic) NSArray * sortedImages;
@property (nonatomic, strong) CLLocationManager *myLocationManager;
@property (strong, nonatomic) NSMutableDictionary * distance;
@property (strong, nonatomic) NSMutableDictionary * locations;
@property (strong, nonatomic) NSMutableDictionary * imageMap;
@property (assign, nonatomic) NSInteger status;
@property (assign, nonatomic) BOOL statusLocation;
@end

@implementation AppleMapViewController
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *newLocation = locations[[locations count] -1];
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        
            self.statusLocation = true;
            [self start];
        
    }else {
      
    }
}



-(CLLocation *) location {
    
    CLLocation *LocationAtual = [[CLLocation alloc]init];;
    
    if (self.statusLocation == true) {
        
        LocationAtual = self.myLocationManager.location;
        
    } else {
        LocationAtual = [[CLLocation alloc] initWithLatitude:-56.6462520 longitude:-36.6462520];
    }
    
    return LocationAtual;
}

-(void) start {
    
 
    
    CLLocation *startLocation = [self location];
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:54.007482 longitude:38.252156];
    CLLocation *location1 = [[CLLocation alloc] initWithLatitude:54.033654 longitude:37.489695];
    CLLocation *location2 = [[CLLocation alloc] initWithLatitude:54.187362 longitude:37.529558];
    CLLocation *location3 = [[CLLocation alloc] initWithLatitude:54.207003 longitude:37.623024];
    CLLocation *location4 = [[CLLocation alloc] initWithLatitude:54.209238 longitude:37.645939];
    CLLocation *location5 = [[CLLocation alloc] initWithLatitude:54.167056 longitude:37.631806];
    CLLocation *location6 = [[CLLocation alloc] initWithLatitude:54.211388 longitude:37.696394];
    
    self.distance = [NSMutableDictionary dictionary];
    self.locations = [NSMutableDictionary dictionary];
    self.imageMap = [NSMutableDictionary dictionary];
    
    float betweenDistance = [startLocation distanceFromLocation:location];
    float betweenDistance1 = [startLocation distanceFromLocation:location1];
    float betweenDistance2 = [startLocation distanceFromLocation:location2];
    float betweenDistance3 = [startLocation distanceFromLocation:location3];
    float betweenDistance4 = [startLocation distanceFromLocation:location4];
    float betweenDistance5= [startLocation distanceFromLocation:location5];
    float betweenDistance6 = [startLocation distanceFromLocation:location6];

    [self.locations setObject:@(betweenDistance/1000) forKey:location];
    [self.locations setObject:@(betweenDistance1/1000) forKey:location1];
    [self.locations setObject:@(betweenDistance2/1000) forKey:location2];
    [self.locations setObject:@(betweenDistance3/1000) forKey:location3];
    [self.locations setObject:@(betweenDistance4/1000) forKey:location4];
    [self.locations setObject:@(betweenDistance5/1000) forKey:location5];
    [self.locations setObject:@(betweenDistance6/1000) forKey:location6];
    
    [self.imageMap setObject:@(betweenDistance/1000) forKey:@"1"];
    [self.imageMap setObject:@(betweenDistance1/1000) forKey:@"2"];
    [self.imageMap setObject:@(betweenDistance2/1000) forKey:@"3"];
    [self.imageMap setObject:@(betweenDistance3/1000) forKey:@"4"];
    [self.imageMap setObject:@(betweenDistance4/1000) forKey:@"5"];
    [self.imageMap setObject:@(betweenDistance5/1000) forKey:@"6"];
    [self.imageMap setObject:@(betweenDistance6/1000) forKey:@"7"];
    
    [self.distance setObject:@(betweenDistance/1000) forKey:@"г.Новомосковск, ул.Космонавтов, 35Б"];
    [self.distance setObject:@(betweenDistance1/1000) forKey: @"р.п. Первомайский, ул. Пролетарская дом 19(Рядом с газовой заправкой)"];
    [self.distance setObject:@(betweenDistance2/1000) forKey:@"г. Тула, Одоевское ш.(напроти Пив.Завода Балтика)"];
    [self.distance setObject:@(betweenDistance3/1000) forKey: @"г. Тула, Ряжская 1A"];
    [self.distance setObject:@(betweenDistance4/1000) forKey: @"г. Тула, Веневское ш. 2Б"];
    [self.distance setObject:@(betweenDistance5/1000) forKey: @"г. Тула, Рязанская 46А"];
    [self.distance setObject:@(betweenDistance6/1000) forKey: @"г. Тула, Вильямса (напротив дома 46)"];
    
    [self sortDistance:self.distance sortLocation:self.locations sortImages:self.imageMap];
    
    self.status = 1;
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.status = 0;
    
    self.tableView.contentInset = UIEdgeInsetsZero;
    self.automaticallyAdjustsScrollViewInsets = NO;    
    self.myLocationManager = [[CLLocationManager alloc] init];
    self.myLocationManager.delegate=self;
    

    [self.myLocationManager requestWhenInUseAuthorization];
    [self.myLocationManager startMonitoringSignificantLocationChanges];
    [self.myLocationManager startUpdatingLocation];

    if ([CLLocationManager locationServicesEnabled]){
        
        NSLog(@"Location Services Enabled");
        
        
        if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusDenied){
            
            self.statusLocation = false;
            [self start];
            
        }
    }
    
}




-(void) sortDistance:(NSMutableDictionary *) distance
        sortLocation:(NSMutableDictionary *) location
          sortImages:(NSMutableDictionary*) images{

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

    self.sortedImages = [NSArray array];
    self.sortedImages = [images keysSortedByValueUsingComparator: ^(id obj1, id obj2)
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
    NSMutableArray * images = [[NSMutableArray alloc]init];
    

    for (NSString* key in self.sortedDistance)
    {
        CGFloat distance = [[self.distance objectForKey:key] floatValue];
        [rowss addObject:[NSString stringWithFormat:@"До мойки осталось %.02f км", distance]];
        [addr addObject:key];
    }
    for (NSString* keys in self.sortedImages){
        [images addObject:keys];
    }
    
    UILabel * addrLabel = (UILabel*)[cell.contentView viewWithTag:1];
    UILabel * distance = (UILabel*)[cell.contentView viewWithTag:7];
    UIImageView * imageLogo = (UIImageView*)[cell.contentView viewWithTag:2];
    addrLabel.text = [addr objectAtIndex:indexPath.row];
    imageLogo.image = [UIImage imageNamed:[images objectAtIndex:indexPath.row]];
    
    if (self.statusLocation == true) {
        distance.text = [rowss objectAtIndex:indexPath.row];
    } else {
        distance.text = @"Служба геолокации отключена!";
    }
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
    
    NSURL * URL = [NSURL URLWithString:appleLink2];
//    UIApplication *application = [UIApplication sharedApplication];
//    [application openURL:URL options:@{} completionHandler:nil];
    
    
    if (self.statusLocation == true) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication] openURL:URL];
        });
    } else {
        
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
        
        [self presentViewController:alert animated:YES completion:nil];

    }
    
    
}

@end
