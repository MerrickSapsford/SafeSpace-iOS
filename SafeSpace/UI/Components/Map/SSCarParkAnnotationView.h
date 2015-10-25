//
//  SSCarParkAnnotationView.h
//  SafeSpace
//
//  Created by Merrick Sapsford on 25/10/2015.
//  Copyright © 2015 Team Moopflop. All rights reserved.
//

#import "SSCustomAnnotationView.h"

@interface SSCarParkAnnotationView : SSCustomAnnotationView

@property (nonatomic, weak) IBOutlet UIImageView *imageView;

@property (nonatomic, weak) IBOutlet UILabel *textLabel;

@end
