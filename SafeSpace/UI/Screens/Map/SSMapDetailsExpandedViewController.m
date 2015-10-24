//
//  SSMapDetailsExpandedViewController.m
//  SafeSpace
//
//  Created by Merrick Sapsford on 24/10/2015.
//  Copyright © 2015 Team Moopflop. All rights reserved.
//

#import "SSMapDetailsExpandedViewController.h"

@interface SSMapDetailsExpandedViewController ()

@end

@implementation SSMapDetailsExpandedViewController

#pragma mark - Interaction 

- (IBAction)closeButtonPressed:(id)sender {
    self.expandableView.state = SSExpandableViewStateCompressed;
}

@end
