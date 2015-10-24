//
//  SSMapRootViewController.m
//  SafeSpace
//
//  Created by Merrick Sapsford on 24/10/2015.
//  Copyright © 2015 Team Moonflop. All rights reserved.
//

#import "SSMapRootViewController.h"

NSString *const SSMapOptionStandard = @"SSMapOptionStandard";
NSString *const SSMapOptionSatellite = @"SSMapOptionSatellite";
NSString *const SSMapOptionHybrid = @"SSMapOptionHybrid";

@implementation SSMapRootViewController

#pragma mark - Lifecycle

- (void)setUpController {
    [super setUpController];
    
    [self.searchBar.drawerButton addTarget:self action:@selector(drawerButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
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
    return @[[SSDrawerSection drawerSectionWithTitle:@"Map" items:@[[SSDrawerItem drawerItemWithTitle:@"Standard"
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

@end
