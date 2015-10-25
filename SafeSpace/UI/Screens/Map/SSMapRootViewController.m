//
//  SSMapRootViewController.m
//  SafeSpace
//
//  Created by Merrick Sapsford on 24/10/2015.
//  Copyright © 2015 Team Moonflop. All rights reserved.
//

#import "SSMapRootViewController.h"
#import "SSCarParkAnnotation.h"

#import "SSCarParkManager.h"
#import "SSCrimeManager.h"
#import "SSRatingUtils.h"
#import "SSCarPark.h"
#import "SSExpandableView.h"
#import "SSMapDetailsExpandedViewController.h"
#import "SSMapDetailsCompressedViewController.h"

NSString *const SSMapOptionStandard = @"SSMapOptionStandard";
NSString *const SSMapOptionSatellite = @"SSMapOptionSatellite";
NSString *const SSMapOptionHybrid = @"SSMapOptionHybrid";

@interface SSMapRootViewController() <MKMapViewDelegate>

@property (strong, nonatomic) NSArray *carParkData;

@property (strong, nonatomic) NSArray *crimeData;

@property (weak, nonatomic) IBOutlet SSExpandableView *expandableView;

@property (strong, nonatomic) MKPointAnnotation *pin;
@property (weak, nonatomic) IBOutlet UIButton *pinDropButton;

@property BOOL pinDropMode;

@end

@implementation SSMapRootViewController

static int CRIME_START_MONTH = 8;
static int CRIME_START_YEAR = 2015;
static int CRIME_MONTH_COUNT = 12;

#pragma mark - Lifecycle

- (void)setUpController {
    [super setUpController];
    [self makeRequests];
    
    [[CLLocationManager new] requestAlwaysAuthorization];
    
    UITapGestureRecognizer *lpgr = [[UITapGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(handleMapTap:)];
    [self.mapView addGestureRecognizer:lpgr];
    
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    
    [self.searchBar.drawerButton addTarget:self action:@selector(drawerButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Data requests

- (void)makeRequests {
    [[[SSCarParkManager alloc] init] getCachedCarParkDataWithCallback:^(NSArray *data) {
        self.carParkData = data;
        if (self.carParkData && self.crimeData) [self requestsComplete];
    }];
    [[[SSCrimeManager alloc] init] getCachedStreetLevelCrimeForMonth:CRIME_START_MONTH year:CRIME_START_YEAR monthCount:CRIME_MONTH_COUNT callback:^(NSArray *data) {
        self.crimeData = data;
        if (self.carParkData && self.crimeData) [self requestsComplete];
    }];
}

- (void)requestsComplete {
    [self addCarParks];
    
    [self.mapView showAnnotations:self.mapView.annotations animated:NO];
    self.mapView.camera.altitude *= 1.2;
    
    [self.drawerController reloadData];
}

- (void) addCarParks {
    for (SSCarPark *carPark in self.carParkData) {
        SSCarParkAnnotation *annotation = [SSCarParkAnnotation annotationWithCarPark:carPark];
        annotation.rating = [SSRatingUtils getRatingAtLatitude:annotation.coordinate.latitude
                                                     longitude:annotation.coordinate.longitude
                                                    crimesList:self.crimeData];
        [self.mapView addAnnotation:annotation];
    }
}

#pragma mark - Interaction

- (void)drawerButtonPressed:(id)sender {
    if (self.drawerController.drawerVisible) {
        [self.drawerController hideAnimated:YES];
    } else {
        [self.drawerController showAnimated:YES];
    }
}

- (IBAction)pinDropButtonPressed:(id)sender {
    self.pinDropMode = !self.pinDropMode;
    if (self.pinDropMode) {
        [self.pinDropButton setImage:[[UIImage imageNamed:@"mapParking"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
        [self.mapView removeAnnotations:self.mapView.annotations];
    }
    else {
        [self.pinDropButton setImage:[UIImage imageNamed:@"ic_pin_drop_black_48dp"] forState:UIControlStateNormal];
        if (self.pin) {
            [self.mapView removeAnnotation:self.pin];
        }
        [self addCarParks];
    }
}

- (void)handleMapTap:(UIGestureRecognizer *)gestureRecognizer {
    if (!self.pinDropMode) return;
    
    CGPoint touchPoint = [gestureRecognizer locationInView:self.mapView];
    CLLocationCoordinate2D touchMapCoordinate = [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
    
    if (self.pin) {
        [self.mapView removeAnnotation:self.pin];
    }
    self.pin =  [MKPointAnnotation new];
    self.pin.coordinate = touchMapCoordinate;
    [self.mapView addAnnotation:self.pin];
    
    [self locationSelectedAtLatitude:touchMapCoordinate.latitude longitude:touchMapCoordinate.longitude isPin:YES];
}

- (void)carParkSelected:(SSCarPark *)carPark withRating:(float)rating {
    SSMapDetailsExpandedViewController *expanded = (SSMapDetailsExpandedViewController*) [self.expandableView expandedViewController];
    [expanded setCarPark:carPark withRating:rating];
    SSMapDetailsCompressedViewController *compressed = (SSMapDetailsCompressedViewController*) [self.expandableView compressedViewController];
    [compressed setCarPark:carPark withRating:rating];
}

- (void)locationSelectedAtLatitude:(float)latitude longitude:(float)longitude isPin:(BOOL)isPin {
    float rating = [SSRatingUtils getRatingAtLatitude:latitude longitude:longitude crimesList:self.crimeData];
    //SSMapDetailsExpandedViewController *expanded = (SSMapDetailsExpandedViewController*) [self.expandableView expandedViewController];
    SSMapDetailsCompressedViewController *compressed = (SSMapDetailsCompressedViewController*) [self.expandableView compressedViewController];
    [compressed setLocationAtLatitude:latitude longitude:longitude rating:rating isPin:isPin];
}

#pragma mark - Drawer View Controller

- (NSArray *)drawerItemsForDrawerViewController:(SSDrawerViewController *)drawerViewController {
    return @[[SSDrawerSection drawerSectionWithTitle:@"Parking" items:@[[SSDrawerItem unselectableDrawerItemWithTitle:[NSString stringWithFormat:@"%li Available", self.totalSpaces]
                                                                                                image:[UIImage imageNamed:@"mapParking.png"]
                                                                                        selectedImage:nil
                                                                                                  key:SSMapOptionStandard]]],
             [SSDrawerSection drawerSectionWithTitle:@"Map" items:@[[SSDrawerItem drawerItemWithTitle:@"Standard"
                                                                                                image:[UIImage imageNamed:@"mapStandard.png"]
                                                                                        selectedImage:nil
                                                                                                  key:SSMapOptionStandard],
                                                                    [SSDrawerItem drawerItemWithTitle:@"Satellite"
                                                                                                image:[UIImage imageNamed:@"mapSatellite.png"]
                                                                                        selectedImage:nil
                                                                                                  key:SSMapOptionSatellite],
                                                                    [SSDrawerItem drawerItemWithTitle:@"Hybrid"
                                                                                                image:[UIImage imageNamed:@"mapHybrid.png"]
                                                                                        selectedImage:nil
                                                                                                  key:SSMapOptionHybrid]]]];
}

- (SSDrawerItem *)drawerViewController:(SSDrawerViewController *)drawerViewController selectedItemForSection:(SSDrawerSection *)section {
    if ([section.title isEqualToString:@"Map"]) {
        return [section.items firstObject];
    }
    return nil;
}

- (void)drawerViewController:(SSDrawerViewController *)drawerViewController didSelectDrawerItem:(SSDrawerItem *)drawerItem {
    if ([drawerItem.key isEqualToString:SSMapOptionStandard]) {
        self.mapView.mapType = MKMapTypeStandard;
    } else if ([drawerItem.key isEqualToString:SSMapOptionSatellite]) {
        self.mapView.mapType = MKMapTypeSatellite;
    } else if  ([drawerItem.key isEqualToString:SSMapOptionHybrid]) {
        self.mapView.mapType = MKMapTypeHybrid;
    }
}

#pragma mark - Map View

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    // If it's the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    // Handle any custom annotations.
    if ([annotation isKindOfClass:[SSCarParkAnnotation class]])
    {
        SSCarParkAnnotation *carParkAnnotation = (SSCarParkAnnotation *)annotation;
        return carParkAnnotation.annotationView;
    }
    return nil;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    if ([view.annotation isKindOfClass:[SSCarParkAnnotation class]]) {
        SSCarParkAnnotation *annotation = (SSCarParkAnnotation *) view.annotation;
        SSCarPark *carPark = ((SSCarParkAnnotation *) view.annotation).carPark;
        [self carParkSelected:carPark withRating:annotation.rating];
    }
    else if ([view.annotation isKindOfClass:[MKUserLocation class]]) {
        MKUserLocation *userLocation = (MKUserLocation *) view.annotation;
        [self locationSelectedAtLatitude:userLocation.location.coordinate.latitude longitude:userLocation.location.coordinate.longitude isPin:NO];
    }
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    [self locationSelectedAtLatitude:userLocation.location.coordinate.latitude longitude:userLocation.location.coordinate.longitude isPin:NO];
}



#pragma mark - Internal

- (NSInteger)totalSpaces {
    NSInteger count = 0;
    for (SSCarPark *carpark in self.carParkData) {
        count += carpark.spacesNow;
    }
    return count;
}

@end
