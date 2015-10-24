//
//  SSBaseView.m
//  SafeSpace
//
//  Created by Merrick Sapsford on 23/10/2015.
//  Copyright © 2015 Team Moonflop. All rights reserved.
//

#import "SSBaseView.h"

@interface SSBaseView ()

@property (nonatomic, assign) BOOL hasSetup;

@end

@implementation SSBaseView

@synthesize nibName = _nibName;
@synthesize nibView = _nibView;

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (!self.hasSetup) {
        [self setUpView];
        _hasSetup = YES;
    }
}

- (void)setUpView {
    
}

- (NSString *)nibName {
    return NSStringFromClass([self class]);
}

@end
