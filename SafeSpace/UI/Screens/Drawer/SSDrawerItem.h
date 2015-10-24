//
//  SSDrawerItem.h
//  SafeSpace
//
//  Created by Merrick Sapsford on 24/10/2015.
//  Copyright © 2015 Team Moonflop. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSDrawerItem : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, strong) UIImage *selectedImage;

@property (nonatomic, copy) NSString *key;

@property (nonatomic, assign, readonly) BOOL selectable;

+ (instancetype)drawerItemWithTitle:(NSString *)title
                              image:(UIImage *)image
                      selectedImage:(UIImage *)selectedImage;

+ (instancetype)drawerItemWithTitle:(NSString *)title
                              image:(UIImage *)image
                      selectedImage:(UIImage *)selectedImage
                                key:(NSString *)key;

+ (instancetype)unselectableDrawerItemWithTitle:(NSString *)title
                                          image:(UIImage *)image
                                  selectedImage:(UIImage *)selectedImage
                                            key:(NSString *)key;

@end
