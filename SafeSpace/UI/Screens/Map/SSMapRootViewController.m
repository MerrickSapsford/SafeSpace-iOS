//
//  SSMapRootViewController.m
//  SafeSpace
//
//  Created by Merrick Sapsford on 24/10/2015.
//  Copyright © 2015 Team Moonflop. All rights reserved.
//

#import "SSMapRootViewController.h"

@implementation SSMapRootViewController

- (IBAction)drawerButtonPressed:(id)sender {
    if (self.drawerController.drawerVisible) {
        [self.drawerController hideAnimated:YES];
    } else {
        [self.drawerController showAnimated:YES];
    }
}

#pragma mark - Drawer View Controller

- (NSArray *)drawerItemsForDrawerViewController:(SSDrawerViewController *)drawerViewController {
    return @[[SSDrawerSection drawerSectionWithTitle:@"Map" items:@[[SSDrawerItem drawerItemWithTitle:@"Standard" image:nil selectedImage:nil],
                                                                    [SSDrawerItem drawerItemWithTitle:@"Satellite" image:nil selectedImage:nil],
                                                                    [SSDrawerItem drawerItemWithTitle:@"Hybrid" image:nil selectedImage:nil]]]];
}

@end
