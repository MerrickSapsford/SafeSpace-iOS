//
//  MSSCellView.m
//  MSSCollectionViewExample
//
//  Created by Merrick Sapsford on 04/10/2015.
//  Copyright © 2015 Merrick Sapsford. All rights reserved.
//

#import "MSSCellView.h"

@interface MSSCellView ()

@property (nonatomic, strong) UIView *nibView;

@end

@implementation MSSCellView

#pragma mark - Init

- (instancetype)init {
    if (self = [super init]) {
        [self baseInit:NO];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self baseInit:YES];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self baseInit:NO];
    }
    return self;
}

- (void)baseInit:(BOOL)withCoder {
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *nibName = self.nibName;
    
    if(([bundle pathForResource:nibName ofType:@"nib"] != nil)) {
        NSArray *nibContents = [bundle loadNibNamed:nibName owner:self options:nil];
        UIView *view = nibContents[0];
        [self addSubview:view];
        
        if (withCoder) {
            self.translatesAutoresizingMaskIntoConstraints = NO;
        }
        view.translatesAutoresizingMaskIntoConstraints = NO;
        [self addExpandingSubview:view];
        
        _nibView = view;
    }
}

#pragma mark - Lifecycle

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.nibView layoutSubviews];
}

- (void)updateConstraints {
    [super updateConstraints];
    [self.nibView updateConstraints];
}

#pragma mark - Internal

- (NSString *)nibName {
    return NSStringFromClass(self.class);
}

@end
