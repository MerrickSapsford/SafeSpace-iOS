//
//  SSMappingProvider.m
//  SafeSpace
//
//  Created by Rob Frampton on 24/10/2015.
//  Copyright © 2015 Team Moonflop. All rights reserved.
//

#import "SSMappingProvider.h"
#import <RestKit/RestKit.h>
#import "SSStreetLevelCrime.h"
#import "SSLocation.h"

@implementation SSMappingProvider

+ (RKObjectMapping *)streetLevelCrimeMapping {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[SSStreetLevelCrime class]];
    NSDictionary *mappingDictionary = @{@"category": @"category",
                                        @"persistent_id": @"persistent_id",
                                        @"month": @"month",
                                        };
    [mapping addAttributeMappingsFromDictionary:mappingDictionary];
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"location" toKeyPath:@"location" withMapping:[[self class] locationMapping]]];
    
    return mapping;
}

+ (RKObjectMapping *)locationMapping {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[SSLocation class]];
    NSDictionary *mappingDictionary = @{@"latitude": @"latitude",
                                        @"longitude": @"longitude"
                                        };
    [mapping addAttributeMappingsFromDictionary:mappingDictionary];
    
    return mapping;
}

@end
