//
//  SSMapDetailsExpandedViewController.h
//  SafeSpace
//
//  Created by Merrick Sapsford on 24/10/2015.
//  Copyright © 2015 Team Moopflop. All rights reserved.
//

#import "SSExpandableViewController.h"
#import "SSCarPark.h"

@interface SSMapDetailsExpandedViewController : SSExpandableViewController

- (void)setCarPark:(SSCarPark *)carPark withRating:(float)rating timeline:(NSArray *)timeline;

@end
