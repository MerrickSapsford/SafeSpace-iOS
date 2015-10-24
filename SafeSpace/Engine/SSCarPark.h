//
//  SSCarPark.h
//  SafeSpace
//
//  Created by Rob Frampton on 24/10/2015.
//  Copyright © 2015 Team Moonflop. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSCarPark : NSObject

@property (strong, nonatomic) NSString *carParkId;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *state;
@property float latitude;
@property float longitude;
@property int capacity;
@property int spacesNow;
@property int predictedSpaces30Mins;
@property int predictedSpaces60Mins;

@end
