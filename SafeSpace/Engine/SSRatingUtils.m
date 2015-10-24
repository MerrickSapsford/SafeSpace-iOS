//
//  SSRatingUtils.m
//  SafeSpace
//
//  Created by Rob Frampton on 24/10/2015.
//  Copyright © 2015 Team Moonflop. All rights reserved.
//

#import "SSRatingUtils.h"
#import "SSCrimePoint.h"
@import CoreLocation;

@implementation SSRatingUtils

static float DISTANCE_RADIUS = 250.0f;
static float RATING_SCALE = 100.0f;

+ (float) getRatingAtLatitude:(float)latitude longitude:(float)longitude crimesList:(NSArray *)crimes {
    int crimeCount = [[self class] getCrimesInAreaAtLatitude:latitude longitude:longitude crimesList:crimes];
    return exp(-crimeCount * (RATING_SCALE / crimes.count)) * 100;
}

+ (int) getCrimesInAreaAtLatitude:(float)latitude longitude:(float)longitude crimesList:(NSArray *)crimes {
    CLLocation *locA = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    
    int crimeCount = 0;
    
    for (SSCrimePoint *crime in crimes) {
        CLLocation *locB = [[CLLocation alloc] initWithLatitude:crime.latitude longitude:crime.longitude];
        if ([locA distanceFromLocation:locB] < DISTANCE_RADIUS) {
            crimeCount++;
        }
    }
    
    return crimeCount;
}

@end
