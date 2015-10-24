//
//  SSCarParkManager.h
//  SafeSpace
//
//  Created by Rob Frampton on 24/10/2015.
//  Copyright © 2015 Team Moonflop. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSCarParkManager : NSObject

typedef void (^CarParkCallback)(NSArray* data);

typedef void (^CarParkInternalCallback)(NSMutableArray *currentData, int currentPage);

- (void)getCachedCarParkDataWithCallback:(CarParkCallback)callback;

@end
