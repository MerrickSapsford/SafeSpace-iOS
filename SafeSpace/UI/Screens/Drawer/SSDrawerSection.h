//
//  SSDrawerSection.h
//  SafeSpace
//
//  Created by Merrick Sapsford on 24/10/2015.
//  Copyright © 2015 Team Moopflop. All rights reserved.
//

#import "SSDrawerItem.h"

@interface SSDrawerSection : NSObject

@property (nonatomic, copy, readonly) NSString *title;

@property (nonatomic, strong, readonly) NSArray *items;

+ (instancetype)drawerSectionWithTitle:(NSString *)title items:(NSArray *)items;

@end
