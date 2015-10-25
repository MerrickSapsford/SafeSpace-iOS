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

+ (NSString *)ratingStringForRating:(CGFloat)rating {
    if (rating > 90) {
        return @"A+";
    } else if (rating > 80) {
        return @"A";
    } else if (rating > 70) {
        return @"B";
    } else if (rating > 60) {
        return @"C";
    } else if (rating > 50) {
        return @"D";
    } else if (rating > 40) {
        return @"E";
    } else {
        return @"F";
    }
}

+ (UIColor *)ratingColorForRating:(CGFloat)rating {
    if (rating > 80) {
        return [UIColor colorWithRed:0.30 green:0.69 blue:0.31 alpha:1.0];
    } else if (rating > 60) {
        return [UIColor colorWithRed:0.85 green:0.83 blue:0.05 alpha:1.0];
    } else if (rating > 40) {
        return [UIColor colorWithRed:1.00 green:0.60 blue:0.00 alpha:1.0];
    }
    return [UIColor colorWithRed:0.78 green:0.16 blue:0.16 alpha:1.0];
}

@end
