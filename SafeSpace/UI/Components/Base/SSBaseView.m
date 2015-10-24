//
//  SSBaseView.m
//  SafeSpace
//
//  Created by Merrick Sapsford on 23/10/2015.
//  Copyright © 2015 Team Moonflop. All rights reserved.
//

#import "SSBaseView.h"

@implementation SSBaseView

@synthesize nibName = _nibName;
@synthesize nibView = _nibView;

- (NSString *)nibName {
    return NSStringFromClass([self class]);
}

@end
