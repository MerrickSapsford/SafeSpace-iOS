//
//  MSSCellView.h
//  MSSCollectionViewExample
//
//  Created by Merrick Sapsford on 04/10/2015.
//  Copyright © 2015 Merrick Sapsford. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+MSSAutoLayout.h"

IB_DESIGNABLE
@interface MSSCellView : UIView

@property (nonatomic, weak) IBOutlet UILabel *textLabel;

@property (nonatomic, weak) IBOutlet UILabel *detailTextLabel;

@property (nonatomic, weak) IBOutlet UIImageView *imageView;

- (NSString *)nibName;

@end
