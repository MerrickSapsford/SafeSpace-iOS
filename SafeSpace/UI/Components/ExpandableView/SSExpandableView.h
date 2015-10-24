//
//  SSExpandableView.h
//  SafeSpace
//
//  Created by Merrick Sapsford on 24/10/2015.
//  Copyright © 2015 Team Moopflop. All rights reserved.
//

#import "SSBaseView.h"

typedef NS_ENUM(NSInteger, SSExpandableViewState) {
    SSExpandableViewStateCompressed,
    SSExpandableViewStateExpanded
};

@class SSExpandableViewController;

@interface SSExpandableView : SSBaseView

@property (nonatomic, strong, readonly) SSExpandableViewController *compressedViewController;

@property (nonatomic, strong, readonly) SSExpandableViewController *expandedViewController;

@property (nonatomic, copy) IBInspectable NSString *compressedViewControllerId;

@property (nonatomic, copy) IBInspectable NSString *expandedViewControllerId;

@property (nonatomic, assign) IBInspectable CGFloat compressedViewHeight;

@property (nonatomic, assign) SSExpandableViewState state;

- (void)setState:(SSExpandableViewState)state animated:(BOOL)animated;

@end
