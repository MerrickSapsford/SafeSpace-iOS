//
//  SSDrawerItem.m
//  SafeSpace
//
//  Created by Merrick Sapsford on 24/10/2015.
//  Copyright © 2015 Team Moonflop. All rights reserved.
//

#import "SSDrawerItem.h"

@implementation SSDrawerItem

+ (instancetype)drawerItemWithTitle:(NSString *)title image:(id)image selectedImage:(id)selectedImage {
    SSDrawerItem *item = [SSDrawerItem new];
    item->_title = title;
    item->_image = image;
    item->_selectedImage = selectedImage;
    return item;
}

@end
