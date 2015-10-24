//
//  SSExpandableView.h
//  SafeSpace
//
//  Created by Merrick Sapsford on 24/10/2015.
//  Copyright © 2015 Team Moopflop. All rights reserved.
//

#import "SSBaseView.h"
#import "SSBaseViewController.h"

typedef NS_ENUM(NSInteger, SSExpandableViewState) {
    SSExpandableViewStateCompressed,
    SSExpandableViewStateExpanded
};

@interface SSExpandableView : SSBaseView

@property (nonatomic, strong, readonly) SSBaseViewController *compressedViewController;

@property (nonatomic, strong, readonly) SSBaseViewController *expandedViewController;

@property (nonatomic, copy) IBInspectable NSString *compressedViewControllerId;

@property (nonatomic, copy) IBInspectable NSString *expandedViewControllerId;

@property (nonatomic, assign) IBInspectable CGFloat compressedViewHeight;

@property (nonatomic, assign, readonly) SSExpandableViewState state;

- (void)setState:(SSExpandableViewState)state animated:(BOOL)animated;

@end
