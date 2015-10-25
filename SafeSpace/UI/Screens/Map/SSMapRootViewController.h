//
//  SSMapRootViewController.h
//  SafeSpace
//
//  Created by Merrick Sapsford on 24/10/2015.
//  Copyright © 2015 Team Moonflop. All rights reserved.
//

#import "SSBaseRootViewController.h"
#import "SSSearchBarView.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface SSMapRootViewController : SSBaseRootViewController

@property (nonatomic, weak) IBOutlet SSSearchBarView *searchBar;

@property (nonatomic, weak) IBOutlet MKMapView *mapView;

@end
