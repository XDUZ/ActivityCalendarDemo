//
//  MLLinkClickLabel.m
//  SNSProject
//
//  Created by liu on 16/3/22.
//  Copyright © 2016年 思想加. All rights reserved.
//

#import "MLLinkClickLabel.h"

@implementation MLLinkClickLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        //        [self addGestureRecognizer:longPress];
    }
    return self;
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    
    MLLink *link = [self linkAtPoint:[touch locationInView:self]];
    if (!link) {
       // NSLog(@"单击了非链接部分");
        if (_clickDelegate && [_clickDelegate respondsToSelector:@selector(onClickOutsideLink:)]) {
            [_clickDelegate onClickOutsideLink:_uniqueId];
        }
    }
    
}
@end
