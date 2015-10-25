//
//  SSGraphView.m
//  SafeSpace
//
//  Created by Rob Frampton on 25/10/2015.
//  Copyright © 2015 Team Moopflop. All rights reserved.
//

#import "SSGraphView.h"

@interface SSGraphView()


@end

@implementation SSGraphView

- (void) setTimeData:(NSArray *)timeData {
    _timeData = timeData;
    [self setNeedsDisplay];
}

- (void) drawRect:(CGRect)rect {
    
    //Get the CGContext from this view
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetAlpha(context, 1.0);
    CGContextFillRect(context, rect);
 
    if (!_timeData) return;
    
    NSInteger max = 0;
    for (int i = 0; i < _timeData.count; i++) {
        if ([_timeData[i] integerValue] > max) max = [_timeData[i] integerValue];
    }

    NSLog(@"DATA=%@", _timeData);
    
    //Set the stroke (pen) color
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    //Set the width of the pen mark
    CGContextSetLineWidth(context, 1.0);

    //Start at this point
    
    
    
    for (int i = 0; i < _timeData.count; i++) {
        double x = rect.size.width * (double) i / (_timeData.count - 1);
        double y = rect.size.height * [_timeData[i] integerValue] / (double) max;
        if (i == 0) {
            CGContextMoveToPoint(context, x, y);
        }
        else {
            CGContextAddLineToPoint(context, x, y);
        }
    }
    
    //Draw it
    CGContextStrokePath(context);
}

@end
