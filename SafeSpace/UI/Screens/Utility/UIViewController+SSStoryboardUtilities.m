//
//  UIViewController+SSStoryboardUtilities.m
//  SafeSpace
//
//  Created by Merrick Sapsford on 24/10/2015.
//  Copyright © 2015 Team Moonflop. All rights reserved.
//

#import "UIViewController+SSStoryboardUtilities.h"

@implementation UIViewController (SSStoryboardUtilities)

- (UIViewController *)instantateViewControllerWithIdentifier:(NSString *)viewController {
    return [UIViewController instantateViewControllerWithIdentifier:viewController];
}

+ (UIViewController *)instantateViewControllerWithIdentifier:(NSString *)viewController {
    return [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:viewController];
}

@end
