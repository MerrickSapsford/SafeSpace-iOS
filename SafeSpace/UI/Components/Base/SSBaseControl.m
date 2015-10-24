//
//  SSBaseControl.m
//  SafeSpace
//
//  Created by Merrick Sapsford on 24/10/2015.
//  Copyright © 2015 Team Moopflop. All rights reserved.
//

#import "SSBaseControl.h"

@implementation SSBaseControl

@synthesize nibName = _nibName;
@synthesize nibView = _nibView;

#pragma mark - Init

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initView:NO];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self initView:YES];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initView:NO];
    }
    return self;
}

- (void)initView:(BOOL)withCoder {
    if (self.nibName) {
        _nibView = (SSBaseView *)[self addNibView:self.nibName withCoder:withCoder];
        _nibView.userInteractionEnabled = NO;
    }
}

#pragma mark - Lifecycle

- (void)awakeFromNib {
    [super awakeFromNib];
    [self updateControlForState:self.state];
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    [self updateControlForState:self.state];
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    [self updateControlForState:self.state];
}

- (void)updateControlForState:(UIControlState)state {
    switch (state) {
        case UIControlStateNormal:
            self.alpha = 1.0f;
            break;
            
        case UIControlStateHighlighted:
            self.alpha = 0.85f;
            break;
            
        default:
            break;
    }
}

#pragma mark - Internal

- (NSString *)nibName {
    return NSStringFromClass([self class]);
}

@end
