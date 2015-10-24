//
//  SSExpandableView.m
//  SafeSpace
//
//  Created by Merrick Sapsford on 24/10/2015.
//  Copyright © 2015 Team Moopflop. All rights reserved.
//

#import "SSExpandableView.h"

CGFloat const kSSExpandableViewDefaultCompressedHeight = 80.0f;
CGFloat const kSSExpandableViewExpandedTopPadding = 140.0f;

@interface SSExpandableView ()

@property (nonatomic, strong) SSBaseView *compressedContainer;

@property (nonatomic, strong) SSBaseView *expandedContainer;

@property (nonatomic, strong) SSBaseView *backgroundOverlayView;

@end

@implementation SSExpandableView

#pragma mark - Set up

- (void)setUpView {
    [super setUpView];
    
    [self setUpContainers];
    [self setUpCompressedViewController];
    [self setUpExpandedViewController];
}

- (void)setUpContainers {
    if (!self.backgroundOverlayView) {
        self.backgroundOverlayView = [SSBaseView new];
        self.backgroundOverlayView.frame = self.bounds;
        self.backgroundOverlayView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.75f];
        self.backgroundOverlayView.alpha = 0.0f;
        [self addSubview:self.backgroundOverlayView];
    }
    
    if (!self.compressedContainer) {
        self.compressedContainer = [SSBaseView new];
        self.compressedContainer.frame = CGRectMake(0,
                                              self.frame.size.height - self.compressedViewHeight,
                                              self.frame.size.width,
                                              self.compressedViewHeight);
        [self addSubview:self.compressedContainer];
    }
    
    if (!self.expandedContainer) {
        self.expandedContainer = [SSBaseView new];
        self.expandedContainer.frame = CGRectMake(0,
                                                  self.compressedContainer.frame.origin.y,
                                                  self.compressedContainer.frame.size.width,
                                                  self.bounds.size.height - kSSExpandableViewExpandedTopPadding);
        [self addSubview:self.expandedContainer];
    }
    
    [self bringSubviewToFront:self.compressedContainer];
}

- (void)setUpCompressedViewController {
    if (self.compressedViewControllerId) {
        SSBaseViewController *compressedController = (SSBaseViewController *)[SSBaseViewController instantateViewControllerWithIdentifier:self.compressedViewControllerId];
        
        compressedController.view.frame = self.compressedContainer.bounds;
        [self.compressedContainer addSubview:compressedController.view];
        
        _compressedViewController = compressedController;
    }
}

- (void)setUpExpandedViewController {
    if (self.expandedViewControllerId) {
        SSBaseViewController *expandedController = (SSBaseViewController *)[SSBaseViewController instantateViewControllerWithIdentifier:self.expandedViewControllerId];
        
        expandedController.view.frame = self.expandedContainer.bounds;
        [self.expandedContainer addSubview:expandedController.view];
        
        _expandedViewController = expandedController;
    }
}

#pragma mark - Interaction

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (self.state == SSExpandableViewStateCompressed) {
        if (CGRectContainsPoint(self.compressedContainer.frame, point)) {
            return self.compressedViewController.view;
        }
    } else if (self.state == SSExpandableViewStateExpanded) {
        return [super hitTest:point withEvent:event];
    }
    return nil;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    
    CGPoint point = [[touches anyObject]locationInView:self];
    if (self.state == SSExpandableViewStateCompressed) {
        if (CGRectContainsPoint(self.compressedContainer.frame, point)) {
            [self setState:SSExpandableViewStateExpanded];
        }
    } else {
        if (CGRectContainsPoint(self.backgroundOverlayView.frame, point)) {
            [self setState:SSExpandableViewStateCompressed];
        }
    }
}

- (void)setState:(SSExpandableViewState)state {
    [self setState:state animated:YES];
}

- (void)setState:(SSExpandableViewState)state animated:(BOOL)animated {
    _state = state;
    
    CGPoint origin = CGPointZero;
    CGFloat expandedAlpha = 1.0f;
    CGFloat compressedAlpha = 1.0f;
    if (state == SSExpandableViewStateExpanded) {
        origin = CGPointMake(0.0f, self.bounds.size.height - self.expandedContainer.frame.size.height);
        compressedAlpha = 0.0f;
    } else {
        origin = CGPointMake(0.0f, self.bounds.size.height - self.compressedContainer.frame.size.height);
        compressedAlpha = 1.0f;
    }
    
    CGSize compressedSize = self.compressedContainer.frame.size;
    CGSize expandedSize = self.expandedContainer.frame.size;
    
    if (animated) {
        [UIView transitionWithView:self duration:0.3f options:UIViewAnimationOptionCurveLinear animations:^{
            
            self.compressedContainer.alpha = compressedAlpha;
            self.compressedContainer.frame = CGRectMake(origin.x, origin.y, compressedSize.width, compressedSize.height);
            
            self.expandedContainer.alpha = expandedAlpha;
            self.expandedContainer.frame = CGRectMake(origin.x, origin.y, expandedSize.width, expandedSize.height);
            
            self.backgroundOverlayView.alpha = (state == SSExpandableViewStateExpanded) ? 1.0f : 0.0f;
            
        } completion:nil];
    } else {
        self.compressedContainer.alpha = compressedAlpha;
        self.compressedContainer.frame = CGRectMake(origin.x, origin.y, compressedSize.width, compressedSize.height);
        
        self.expandedContainer.alpha = expandedAlpha;
        self.expandedContainer.frame = CGRectMake(origin.x, origin.y, expandedSize.width, expandedSize.height);
    }
}

- (CGFloat)compressedViewHeight {
    if (_compressedViewHeight == 0) {
        _compressedViewHeight = kSSExpandableViewDefaultCompressedHeight;
    }
    return _compressedViewHeight;
}

@end
