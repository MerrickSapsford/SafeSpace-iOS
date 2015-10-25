//
//  SSRatingUtils.h
//  SafeSpace
//
//  Created by Rob Frampton on 24/10/2015.
//  Copyright © 2015 Team Moonflop. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSRatingUtils : NSObject

+ (float) getRatingAtLatitude:(float)latitude longitude:(float)longitude crimesList:(NSArray *)crimes;

+ (int) getCrimeCountInAreaAtLatitude:(float)latitude longitude:(float)longitude crimesList:(NSArray *)crimes;

+ (NSString *)ratingStringForRating:(CGFloat)rating;

+ (UIColor *)ratingColorForRating:(CGFloat)rating;

+ (NSArray *)getCrimesTimelineAtLatitude:(float)latitude longitude:(float)longitude crimesList:(NSArray *)crimes;

@end
