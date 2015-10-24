//
//  SSCommsManager.h
//  SafeSpace
//
//  Created by Rob Frampton on 24/10/2015.
//  Copyright © 2015 Team Moonflop. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>
#import "SSStreetLevelCrime.h"
#import "SSMappingProvider.h"
#import "SSCrimePoint.h"


@interface SSCrimeManager : NSObject

typedef void (^StreetLevelCrimeCallback)(NSArray* data);

- (instancetype)init;
//+ (void)configureRestKit;
//+ (void)loadStreetLevelCrime;
//+ (void)getCachedStreetLevelCrimeWithCallback:(StreetLevelCrimeCallback)callback;

- (void)getCachedStreetLevelCrimeForMonth:(int)month year:(int)year monthCount:(int)monthCount callback:(StreetLevelCrimeCallback)callback;

@end
