//
//  SSBaseControl.h
//  SafeSpace
//
//  Created by Merrick Sapsford on 24/10/2015.
//  Copyright © 2015 Team Moopflop. All rights reserved.
//

#import "SSBaseView.h"
#import "UIView+SSAutoLayout.h"
#import "UIView+SSNibUtilities.h"

IB_DESIGNABLE
@interface SSBaseControl : UIControl <SSBaseViewProtocol>

- (void)updateControlForState:(UIControlState)state;

@end
