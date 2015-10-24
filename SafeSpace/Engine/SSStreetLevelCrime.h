//
//  SSStreetLevelCrime.h
//  SafeSpace
//
//  Created by Rob Frampton on 24/10/2015.
//  Copyright © 2015 Team Moonflop. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SSLocation.h"

@interface SSStreetLevelCrime : NSObject

@property (strong, nonatomic) NSString *category;
@property (strong, nonatomic) NSString *persistent_id;
@property (strong, nonatomic) NSString *month;
@property (strong, nonatomic) SSLocation *location;

@end
