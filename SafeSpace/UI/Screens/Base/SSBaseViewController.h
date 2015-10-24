//
//  ViewController.h
//  SafeSpace
//
//  Created by Merrick Sapsford on 23/10/2015.
//  Copyright © 2015 Team Moonflop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSSCollectionViewController.h"
#import "SSBaseView.h"
#import "UIViewController+SSStoryboardUtilities.h"

IB_DESIGNABLE
@interface SSBaseViewController : UIViewController

- (void)initController;

- (void)setUpController;

- (NSString *)storyboardId;

@end

