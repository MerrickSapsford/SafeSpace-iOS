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
/*
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
}*/

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

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

+ (UIColor *)ratingColorForRating:(CGFloat)rating {
    if (rating > 90) {
        return UIColorFromRGB(0x4CAF50);
    } else if (rating > 80) {
        return UIColorFromRGB(0x6baf4c);
    } else if (rating > 70) {
        return UIColorFromRGB(0xdad30c);
    } else if (rating > 60) {
        return UIColorFromRGB(0xffd000);
    } else if (rating > 50) {
        return UIColorFromRGB(0xFF9800);
    } else if (rating > 40) {
        return UIColorFromRGB(0xff5100);
    } else {
        return UIColorFromRGB(0xC62828);
    }
}

@end
