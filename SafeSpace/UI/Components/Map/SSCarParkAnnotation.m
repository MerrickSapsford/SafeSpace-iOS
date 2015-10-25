//
//  SSCarParkAnnotation.m
//  SafeSpace
//
//  Created by Merrick Sapsford on 25/10/2015.
//  Copyright © 2015 Team Moopflop. All rights reserved.
//

#import "SSCarParkAnnotation.h"
#import "SSRatingUtils.h"

@implementation SSCarParkAnnotation

@synthesize coordinate = _coordinate;
@synthesize annotationView = _annotationView;

+ (instancetype)annotationWithCarPark:(SSCarPark *)carPark {
    SSCarParkAnnotation *annotaion = [SSCarParkAnnotation new];
    annotaion->_carPark = carPark;
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(carPark.latitude, carPark.longitude);
    annotaion->_coordinate = coordinate;
    
    return annotaion;
}

- (SSCarParkAnnotationView *)annotationView {
    if (!_annotationView) {
        _annotationView = [SSCarParkAnnotationView new];
        static CGSize annotationSize;
        if (CGSizeEqualToSize(annotationSize, CGSizeZero)) {
            annotationSize = [_annotationView systemLayoutSizeFittingSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
        }
        _annotationView.frame = CGRectMake(0, 0, annotationSize.width, annotationSize.height);
        
        _annotationView.textLabel.text = [SSRatingUtils ratingStringForRating:self.rating];
        
        _annotationView.imageView.image = [_annotationView.imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _annotationView.imageView.tintColor = [SSRatingUtils ratingColorForRating:self.rating];
    }
    
    return _annotationView;
}

@end
