
#import "UIView+SSAutoLayout.h"

@implementation UIView (SSAutoLayout)

- (void)addExpandingSubview:(UIView *)subview {
    [self addExpandingSubview:subview edgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
}

- (void)addExpandingSubview:(UIView *)subview edgeInsets:(UIEdgeInsets)insets {
    if (subview.superview) {
        [subview removeFromSuperview];
    }
    
    [self addSubview:subview];
    subview.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *views = NSDictionaryOfVariableBindings(subview);
    
    NSString *verticalConstraints = [NSString stringWithFormat:@"V:|-%f-[subview]-%f-|", insets.top, insets.bottom];
    NSString *horizontalConstraints = [NSString stringWithFormat:@"H:|-%f-[subview]-%f-|", insets.left, insets.right];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:verticalConstraints
                                                                 options:0
                                                                 metrics:nil
                                                                   views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:horizontalConstraints
                                                                 options:0
                                                                 metrics:nil
                                                                   views:views]];
}

- (void)addTabletOversizedExpandingSubview:(UIView *)subview {
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGFloat padding = MAX(screenSize.width, screenSize.height) / 2.0f;
    
    if (subview.superview) {
        [subview removeFromSuperview];
    }
    
    [self addSubview:subview];
    subview.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:subview attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:-padding]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:subview attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:padding]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:subview attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-padding]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:subview attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:padding]];
}

+ (UIView*)viewWithStackedSubviews:(NSArray *)subviews {
    UIView *containerView = [UIView new];
    containerView.translatesAutoresizingMaskIntoConstraints = NO;
    [containerView insertStackedSubviews:subviews];
    return containerView;
}

- (void)insertStackedSubviews:(NSArray *)subviews {
    NSMutableArray *constraints = [NSMutableArray new];
    
    if (subviews.count > 1)
    {
        for (int count=0; count<subviews.count; count++) {
            UIView *subview = subviews[count];
            
            if (subview.superview) {
                [subview removeFromSuperview];
            }
            [self addSubview:subview];
            subview.translatesAutoresizingMaskIntoConstraints = NO;
            
            if (subview == subviews.firstObject) {
                UIView *nextSubview = subviews[count+1];
                [constraints addObject:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[subview][nextSubview]"
                                                                               options:0
                                                                               metrics:nil
                                                                                 views:@{@"subview":subview, @"nextSubview":nextSubview}]];
            } else if (subview == subviews.lastObject) {
                [constraints addObject:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[subview]|"
                                                                               options:0
                                                                               metrics:nil
                                                                                 views:@{@"subview":subview}]];
            } else {
                UIView *nextSubview = subviews[count+1];
                [constraints addObject:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[subview][nextSubview]"
                                                                               options:0
                                                                               metrics:nil
                                                                                 views:@{@"subview":subview, @"nextSubview":nextSubview}]];
            }
            
            
            [constraints addObject:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[subview]|"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:@{@"subview":subview}]];
        }
    }
    
    for (NSArray *constraint in constraints) {
        [self addConstraints:constraint];
    }
}

- (void)addPinnedToTopAndSidesSubview:(UIView *)subview {
    [self addPinnedToTopAndSidesSubview:subview height:0.0];
}

- (void)addPinnedToTopAndSidesSubview:(UIView *)subview height:(CGFloat)height {
    [self addPinnedToTopAndSidesSubview:subview height:height topInset:0.0];
}

- (void)addPinnedToTopAndSidesSubview:(UIView *)subview height:(CGFloat)height topInset:(CGFloat)topInset {
    if (subview.superview) {
        [subview removeFromSuperview];
    }
    
    [self addSubview:subview];
    subview.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *views = NSDictionaryOfVariableBindings(subview);
    
    NSString *verticalConstraints = [NSString stringWithFormat:@"V:|-%f-[subview]", topInset];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:verticalConstraints
                                                                 options:0
                                                                 metrics:nil
                                                                   views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[subview]|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:views]];
    if (height > 0) {
        [self addHeightConstraint:height toView:subview];
    }
}

- (void)addTabletOversizedPinnedToTopAndSidesSubview:(UIView *)subview {
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGFloat padding = MAX(screenSize.width, screenSize.height) / 2.0f;
    
    if (subview.superview) {
        [subview removeFromSuperview];
    }
    
    [self addSubview:subview];
    subview.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *views = NSDictionaryOfVariableBindings(subview);
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[subview]"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:views]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:subview attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-padding]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:subview attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:padding]];
}

- (NSLayoutConstraint *)addWidthConstraint:(CGFloat)width toView:(UIView *)view {
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:view
                                                                  attribute:NSLayoutAttributeWidth
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:nil
                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                 multiplier:1
                                                                   constant:width];
    [self addConstraint:constraint];
    return constraint;
}

- (NSLayoutConstraint *)addHeightConstraint:(CGFloat)height toView:(UIView *)view {
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:view
                                                                  attribute:NSLayoutAttributeHeight
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:nil
                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                 multiplier:1
                                                                   constant:height];
    [self addConstraint:constraint];
    return constraint;
}

- (NSLayoutConstraint *)pinSubviewToLeft:(UIView *)subview padding:(CGFloat)padding {
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:subview
                                                                  attribute:NSLayoutAttributeLeading
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self
                                                                  attribute:NSLayoutAttributeLeading
                                                                 multiplier:1.0
                                                                   constant:padding];
    [self addConstraint:constraint];
    return constraint;
}

- (NSLayoutConstraint *)pinSubviewToRight:(UIView *)subview padding:(CGFloat)padding {
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:subview
                                                                  attribute:NSLayoutAttributeTrailing
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self
                                                                  attribute:NSLayoutAttributeTrailing
                                                                 multiplier:1.0
                                                                   constant:padding];
    [self addConstraint:constraint];
    return constraint;
}

- (NSLayoutConstraint *)pinSubviewToBottom:(UIView *)subview padding:(CGFloat)padding {
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:subview
                                                                  attribute:NSLayoutAttributeBottom
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self
                                                                  attribute:NSLayoutAttributeBottom
                                                                 multiplier:1.0
                                                                   constant:padding];
    [self addConstraint:constraint];
    return constraint;
}

- (NSLayoutConstraint *)pinSubviewToTop:(UIView *)subview padding:(CGFloat)padding {
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:subview
                                                                  attribute:NSLayoutAttributeTop
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self
                                                                  attribute:NSLayoutAttributeTop
                                                                 multiplier:1.0
                                                                   constant:padding];
    [self addConstraint:constraint];
    return constraint;
}

@end
