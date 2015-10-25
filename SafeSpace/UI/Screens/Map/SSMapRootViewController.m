//
//  SSMapRootViewController.m
//  SafeSpace
//
//  Created by Merrick Sapsford on 24/10/2015.
//  Copyright © 2015 Team Moonflop. All rights reserved.
//

#import "SSMapRootViewController.h"

#import "SSCarParkManager.h"
#import "SSCrimeManager.h"
#import "SSRatingUtils.h"
#import "SSCarPark.h"

NSString *const SSMapOptionStandard = @"SSMapOptionStandard";
NSString *const SSMapOptionSatellite = @"SSMapOptionSatellite";
NSString *const SSMapOptionHybrid = @"SSMapOptionHybrid";

@interface SSMapRootViewController() <MKMapViewDelegate>

@property (strong, nonatomic) NSArray *carParkData;

@property (strong, nonatomic) NSArray *crimeData;

@end

@implementation SSMapRootViewController

static int CRIME_START_MONTH = 8;
static int CRIME_START_YEAR = 2015;
static int CRIME_MONTH_COUNT = 12;

#pragma mark - Lifecycle

- (void)setUpController {
    [super setUpController];
    [self makeRequests];
    
    self.mapView.delegate = self;
    
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
    for (SSCarPark *carPark in self.carParkData) {
        MKPointAnnotation *annotation = [MKPointAnnotation new];
        annotation.coordinate = CLLocationCoordinate2DMake(carPark.latitude, carPark.longitude);
        annotation.title = carPark.name;
        [self.mapView addAnnotation:annotation];
    }
    
//    int rating = [SSRatingUtils getRatingAtLatitude:carPark.latitude longitude:carPark.longitude crimesList:self.crimeData];
}

#pragma mark - Interaction

- (void)drawerButtonPressed:(id)sender {
    if (self.drawerController.drawerVisible) {
        [self.drawerController hideAnimated:YES];
    } else {
        [self.drawerController showAnimated:YES];
    }
}

#pragma mark - Drawer View Controller

- (NSArray *)drawerItemsForDrawerViewController:(SSDrawerViewController *)drawerViewController {
    return @[[SSDrawerSection drawerSectionWithTitle:@"Parking" items:@[[SSDrawerItem unselectableDrawerItemWithTitle:@"0 Available"
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



@end
