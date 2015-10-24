//
//  SSCrimePoint.m
//  SafeSpace
//
//  Created by Rob Frampton on 24/10/2015.
//  Copyright © 2015 Team Moonflop. All rights reserved.
//

#import "SSCrimePoint.h"

@implementation SSCrimePoint

#pragma mark NSCoding

#define kLatitudeKey       @"Latitude"
#define kLongitudeKey      @"Longitude"
#define kMonthKey          @"Month"
#define kYearKey           @"Year"

- (void) encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeFloat:_latitude forKey:kLatitudeKey];
    [encoder encodeFloat:_longitude forKey:kLongitudeKey];
    [encoder encodeInteger:_month forKey:kMonthKey];
    [encoder encodeInteger:_year forKey:kYearKey];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if ((self = [super init])) {
        _latitude = [decoder decodeFloatForKey:kLatitudeKey];
        _longitude = [decoder decodeFloatForKey:kLongitudeKey];
        _month = [decoder decodeIntegerForKey:kMonthKey];
        _year = [decoder decodeIntegerForKey:kYearKey];
    }
    return self;
}


@end
