//
//  SSMapDetailsCompressedViewController.m
//  SafeSpace
//
//  Created by Merrick Sapsford on 24/10/2015.
//  Copyright © 2015 Team Moopflop. All rights reserved.
//

#import "SSMapDetailsCompressedViewController.h"
#import "SSCarPark.h"
#import "SSRatingUtils.h"

@interface SSMapDetailsCompressedViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *spacesLabel;
@property (weak, nonatomic) IBOutlet SSRatingView *ratingContainer;
@property (weak, nonatomic) IBOutlet UILabel *ratingLetter;
@property (weak, nonatomic) IBOutlet UILabel *spacesCaptionLabel;

@end

@implementation SSMapDetailsCompressedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setViewsHidden:YES];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setViewsHidden:(BOOL)hidden {
    self.nameLabel.hidden = hidden;
    self.spacesLabel.hidden = hidden;
    self.ratingContainer.hidden = hidden;
    self.ratingLetter.hidden = hidden;
    self.spacesCaptionLabel.hidden = hidden;
}

- (void)setCarPark:(SSCarPark *)carPark withRating:(float)rating {
    [self setViewsHidden:NO];
    self.nameLabel.text = carPark.name;
    self.spacesLabel.text = [NSString stringWithFormat:@"%d", carPark.spacesNow];
    self.ratingContainer.backgroundColor = [SSRatingUtils ratingColorForRating:rating];
    self.ratingLetter.text = [SSRatingUtils ratingStringForRating:rating];
}

- (void)setLocationAtLatitude:(float)latitude longitude:(float)longitude rating:(float)rating isPin:(BOOL)isPin {
    [self setViewsHidden:NO];
    self.spacesCaptionLabel.hidden = YES;
    if (isPin) {
    self.nameLabel.text = @"Pin Location";
    }
    else {
        self.nameLabel.text = @"Current Location";
    }
    self.spacesLabel.text = @"";
    self.ratingContainer.backgroundColor = [SSRatingUtils ratingColorForRating:rating];
    self.ratingLetter.text = [SSRatingUtils ratingStringForRating:rating];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
