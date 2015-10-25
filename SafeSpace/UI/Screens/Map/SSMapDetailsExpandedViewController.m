//
//  SSMapDetailsExpandedViewController.m
//  SafeSpace
//
//  Created by Merrick Sapsford on 24/10/2015.
//  Copyright © 2015 Team Moopflop. All rights reserved.
//

#import "SSMapDetailsExpandedViewController.h"
#import "SSRatingView.h"
#import "SSRatingUtils.h"

@interface SSMapDetailsExpandedViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *spacesLabel;
@property (weak, nonatomic) IBOutlet UILabel *predictedLabel;
@property (weak, nonatomic) IBOutlet UILabel *capacityLabel;
@property (weak, nonatomic) IBOutlet SSRatingView *safetyContainer;
@property (weak, nonatomic) IBOutlet UILabel *safetyLetter;

@end

@implementation SSMapDetailsExpandedViewController

#pragma mark - Interaction 

- (void)setCarPark:(SSCarPark *)carPark withRating:(float)rating {
    self.nameLabel.text = carPark.name;
    self.spacesLabel.text = [NSString stringWithFormat:@"%d", carPark.spacesNow];
    self.predictedLabel.text = [NSString stringWithFormat:@"%d", carPark.predictedSpaces30Mins];
    self.capacityLabel.text = [NSString stringWithFormat:@"%d", carPark.capacity];
    self.safetyContainer.backgroundColor = [SSRatingUtils ratingColorForRating:rating];
    self.safetyLetter.text = [SSRatingUtils ratingStringForRating:rating];
}

- (void)setLocationAtLatitude:(float)latitude longitude:(float)longitude {
    //TODO
}

- (IBAction)closeButtonPressed:(id)sender {
    self.expandableView.state = SSExpandableViewStateCompressed;
}

@end
