//
//  SegmentLabel.m
//  GoEuroTest
//
//  Created by ADDC on 8/2/16.
//  Copyright © 2016 sureshkumar. All rights reserved.
//

#import "SegmentLabel.h"

const CGFloat XRed   = 0.4;
const CGFloat XGreen = 0.5;
const CGFloat XBlue  = 0.9;
const CGFloat XAlpha = 1.0;

@implementation SegmentLabel


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.textAlignment = NSTextAlignmentCenter;
        self.textColor = [UIColor colorWithRed:XRed green:XGreen blue:XBlue alpha:XAlpha];

        ;
        
    }
    return self;
}

- (void)setScale:(CGFloat)scale {
    _scale = scale;
    
    CGFloat red   = XRed + (1 - XRed) * scale;
    CGFloat green = XGreen + (1 - XGreen) * scale;
    CGFloat blue  = XBlue + (0 - XBlue) * scale;
    
    self.textColor = [UIColor colorWithRed:red green:green blue:blue alpha:XAlpha];
    
    CGFloat transformScale = 0.9 + scale * 0.2;
    self.transform = CGAffineTransformMakeScale(transformScale, transformScale);
    
}
@end
