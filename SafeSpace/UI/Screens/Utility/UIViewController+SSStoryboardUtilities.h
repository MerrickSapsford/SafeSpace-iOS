//
//  UIViewController+SSStoryboardUtilities.h
//  SafeSpace
//
//  Created by Merrick Sapsford on 24/10/2015.
//  Copyright © 2015 Team Moonflop. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (SSStoryboardUtilities)

- (UIViewController *)instantateViewControllerWithIdentifier:(NSString *)viewController;

@end
