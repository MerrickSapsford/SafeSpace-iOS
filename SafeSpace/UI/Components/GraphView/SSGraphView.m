//
//  SSGraphView.m
//  SafeSpace
//
//  Created by Rob Frampton on 25/10/2015.
//  Copyright © 2015 Team Moopflop. All rights reserved.
//

#import "SSGraphView.h"

@implementation SSGraphView

- (void) drawRect:(CGRect)rect {
    
    //Get the CGContext from this view
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //Set the stroke (pen) color
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    //Set the width of the pen mark
    CGContextSetLineWidth(context, 5.0);
    
    // Draw a line
    //Start at this point
    CGContextMoveToPoint(context, 10.0, 30.0);
    
    //Give instructions to the CGContext
    //(move "pen" around the screen)
    CGContextAddLineToPoint(context, 310.0, 30.0);
    CGContextAddLineToPoint(context, 310.0, 90.0);
    CGContextAddLineToPoint(context, 10.0, 90.0);
    
    //Draw it
    CGContextStrokePath(context);
}

@end
