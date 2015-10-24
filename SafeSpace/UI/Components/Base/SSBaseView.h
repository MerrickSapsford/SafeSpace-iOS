//
//  SSBaseView.h
//  SafeSpace
//
//  Created by Merrick Sapsford on 23/10/2015.
//  Copyright © 2015 Team Moonflop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+SSAutoLayout.h"
#import "UIView+SSNibUtilities.h"

@class SSBaseView;

@protocol SSBaseViewProtocol <NSObject>

@property (nonatomic, copy) NSString *nibName;

@property (nonatomic, strong) SSBaseView *nibView;

@end

IB_DESIGNABLE
@interface SSBaseView : UIView <SSBaseViewProtocol>

@end
