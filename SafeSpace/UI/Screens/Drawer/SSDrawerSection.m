//
//  SSDrawerSection.m
//  SafeSpace
//
//  Created by Merrick Sapsford on 24/10/2015.
//  Copyright © 2015 Team Moopflop. All rights reserved.
//

#import "SSDrawerSection.h"

@implementation SSDrawerSection

+ (instancetype)drawerSectionWithTitle:(NSString *)title items:(NSArray *)items {
    SSDrawerSection *section = [SSDrawerSection new];
    section->_title = title;
    section->_items = items;
    return section;
}

@end
