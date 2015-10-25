//
//  SSCustomAnnotationView.m
//  SafeSpace
//
//  Created by Merrick Sapsford on 25/10/2015.
//  Copyright © 2015 Team Moopflop. All rights reserved.
//

#import "SSCustomAnnotationView.h"
#import "SSBaseView.h"

@interface SSCustomAnnotationView ()

@property (nonatomic, strong) SSBaseView *nibView;

@end

@implementation SSCustomAnnotationView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self baseInit:NO];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self baseInit:YES];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self baseInit:NO];
    }
    return self;
}

- (void)baseInit:(BOOL)withCoder {
    if (self.nibName) {
        _nibView = (SSBaseView *)[self addNibView:self.nibName withCoder:withCoder];
    }
}

- (NSString *)nibName {
    return NSStringFromClass([self class]);
}

@end
