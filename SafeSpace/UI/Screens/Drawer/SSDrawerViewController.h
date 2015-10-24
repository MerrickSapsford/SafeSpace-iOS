//
//  SSDrawerViewController.h
//  SafeSpace
//
//  Created by Merrick Sapsford on 24/10/2015.
//  Copyright © 2015 Team Moonflop. All rights reserved.
//

#import "SSBaseViewController.h"
#import "SSDrawerSection.h"

typedef NS_ENUM(NSInteger, SSDrawerViewControllerState) {
    SSDrawerViewControllerStateDrawerVisible,
    SSDrawerViewControllerStateDrawerHidden
};

@class SSDrawerViewController;

@protocol SSDrawerViewControllerDelegate <NSObject>

@property (nonatomic, weak) SSDrawerViewController *drawerController;

@optional
- (void)drawerViewController:(SSDrawerViewController *)drawerViewController willMoveToState:(SSDrawerViewControllerState)state;

- (void)drawerViewController:(SSDrawerViewController *)drawerViewController didMoveToState:(SSDrawerViewControllerState)state;

- (void)drawerViewController:(SSDrawerViewController *)drawerViewController
         didSelectDrawerItem:(SSDrawerItem *)drawerItem;

@end

@protocol SSDrawerViewControllerDataSource <NSObject>

- (NSArray *)drawerItemsForDrawerViewController:(SSDrawerViewController *)drawerViewController;

@end

@interface SSDrawerViewController : SSBaseViewController

@property (nonatomic, copy) IBInspectable NSString *contentViewControllerId;

@property (nonatomic, assign) IBInspectable CGFloat drawerWidth;

@property (nonatomic, assign, readonly) BOOL drawerVisible;

- (void)show;

- (void)showAnimated:(BOOL)animated;

- (void)hide;

- (void)hideAnimated:(BOOL)animated;

@end
