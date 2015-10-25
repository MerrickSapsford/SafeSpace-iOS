//
//  SSCarParkAnnotation.h
//  SafeSpace
//
//  Created by Merrick Sapsford on 25/10/2015.
//  Copyright © 2015 Team Moopflop. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "SSCarParkAnnotationView.h"
#import "SSCarPark.h"

@interface SSCarParkAnnotation : NSObject <MKAnnotation>

@property (nonatomic, weak, readonly) SSCarPark *carPark;

@property (nonatomic, strong, readonly) SSCarParkAnnotationView *annotationView;

@property (nonatomic, assign) CGFloat rating;

+ (instancetype)annotationWithCarPark:(SSCarPark *)carPark;

@end
