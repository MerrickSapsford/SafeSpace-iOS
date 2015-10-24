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
    return [self drawerItemWithTitle:title image:image selectedImage:selectedImage key:nil];
}

+ (instancetype)drawerItemWithTitle:(NSString *)title image:(id)image selectedImage:(id)selectedImage key:(NSString *)key {
    SSDrawerItem *item = [SSDrawerItem new];
    item->_title = title;
    item->_image = image;
    item->_selectedImage = selectedImage;
    item->_key = key;
    item->_selectable = YES;
    return item;
}

+ (instancetype)unselectableDrawerItemWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage key:(NSString *)key {
    SSDrawerItem *item = [self drawerItemWithTitle:title image:image selectedImage:selectedImage key:key];
    item->_selectable = NO;
    return item;
}

@end
