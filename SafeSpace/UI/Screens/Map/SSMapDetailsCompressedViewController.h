//
//  SSMapDetailsCompressedViewController.h
//  SafeSpace
//
//  Created by Merrick Sapsford on 24/10/2015.
//  Copyright © 2015 Team Moopflop. All rights reserved.
//

#import "SSBaseViewController.h"
#import "SSRatingView.h"

@interface SSMapDetailsCompressedViewController : SSBaseViewController

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;

@property (nonatomic, weak) IBOutlet UILabel *subtitleLabel;

@property (nonatomic, weak) IBOutlet SSRatingView *ratingView;

@property (nonatomic, weak) IBOutlet UIImageView *contextImageView;

@end
