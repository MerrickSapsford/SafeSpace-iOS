//
//  SSMapDetailsCompressedViewController.h
//  SafeSpace
//
//  Created by Merrick Sapsford on 24/10/2015.
//  Copyright © 2015 Team Moopflop. All rights reserved.
//

#import "SSExpandableViewController.h"
#import "SSRatingView.h"
#import "SSCarPark.h"

@interface SSMapDetailsCompressedViewController : SSExpandableViewController

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;

@property (nonatomic, weak) IBOutlet UILabel *subtitleLabel;

@property (nonatomic, weak) IBOutlet SSRatingView *ratingView;

@property (nonatomic, weak) IBOutlet UIImageView *contextImageView;

- (void)setCarPark:(SSCarPark *)carPark withRating:(float)rating;

- (void)setLocationAtLatitude:(float)latitude longitude:(float)longitude rating:(float)rating;

@end
