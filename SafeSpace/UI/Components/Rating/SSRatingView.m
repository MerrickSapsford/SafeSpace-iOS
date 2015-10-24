//
//  SSRatingView.m
//  SafeSpace
//
//  Created by Merrick Sapsford on 24/10/2015.
//  Copyright © 2015 Team Moopflop. All rights reserved.
//

#import "SSRatingView.h"

@implementation SSRatingView

- (void)setUpView {
    [super setUpView];
    
    self.layer.cornerRadius = self.bounds.size.width / 2.0f;
    self.layer.borderWidth = 1.0f;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
}

@end
