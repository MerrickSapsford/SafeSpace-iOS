//
//  SSMapDetailsCompressedViewController.m
//  SafeSpace
//
//  Created by Merrick Sapsford on 24/10/2015.
//  Copyright © 2015 Team Moopflop. All rights reserved.
//

#import "SSMapDetailsCompressedViewController.h"
#import "SSCarPark.h"

@interface SSMapDetailsCompressedViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *spacesLabel;
@property (weak, nonatomic) IBOutlet SSRatingView *ratingContainer;
@property (weak, nonatomic) IBOutlet UILabel *ratingLetter;

@end

@implementation SSMapDetailsCompressedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setCarPark:(SSCarPark *)carPark {
    self.nameLabel.text = carPark.name;
    self.spacesLabel.text = [NSString stringWithFormat:@"%d", carPark.spacesNow];
    self.ratingContainer.backgroundColor = [UIColor redColor];
    self.ratingLetter.text = @"A";
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
