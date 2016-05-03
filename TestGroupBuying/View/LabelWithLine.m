//
//  LabelWithLine.m
//  TestGroupBuying
//
//  Created by SMartP on 16/2/25.
//  Copyright © 2016年 SMartP. All rights reserved.
//

#import "LabelWithLine.h"

@implementation LabelWithLine


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, 0, rect.size.height/2);
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height/2);
    CGContextStrokePath(context);
}


@end
