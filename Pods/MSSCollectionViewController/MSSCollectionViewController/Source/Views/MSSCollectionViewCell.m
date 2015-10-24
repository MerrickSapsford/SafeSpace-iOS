//
//  MSSCollectionViewCell.m
//  MSSCollectionViewExample
//
//  Created by Merrick Sapsford on 04/10/2015.
//  Copyright © 2015 Merrick Sapsford. All rights reserved.
//

#import "MSSCollectionViewCell.h"

@implementation MSSCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addExpandingSubview:self.contentView];
}

@end
