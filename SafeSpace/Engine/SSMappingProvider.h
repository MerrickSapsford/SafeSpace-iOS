//
//  SSMappingProvider.h
//  SafeSpace
//
//  Created by Rob Frampton on 24/10/2015.
//  Copyright © 2015 Team Moonflop. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

@interface SSMappingProvider : NSObject

+ (RKObjectMapping *)streetLevelCrimeMapping;

+ (RKObjectMapping *)locationMapping;

+ (RKObjectMapping *)carParkMapping;

@end
