//
//  SNSCalendarDayViewCell.m
//  Calendar
//
//  Created by liu on 16/6/24.
//  Copyright © 2016年 思想加. All rights reserved.
//

#define DayWidth  26
#import "SNSCalendarDayViewCell.h"

@implementation SNSCalendarDayViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView
{
    _numLabel = [[UILabel alloc]initWithFrame:CGRectMake((self.frame.size.width-DayWidth)/2, (self.frame.size.height-DayWidth)/2, DayWidth, DayWidth)];
    _numLabel.textAlignment = NSTextAlignmentCenter;
    _numLabel.font = [UIFont systemFontOfSize:14];
    _numLabel.textColor =  Color(150, 150, 150);
    [self addSubview:_numLabel];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.backgroundColor = [UIColor clearColor].CGColor;
    shapeLayer.hidden = YES;
    [self.contentView.layer insertSublayer:shapeLayer below:_numLabel.layer];
    shapeLayer.frame = _numLabel.frame;
    self.shapeLayer = shapeLayer;
}
- (void)updateDay:(NSArray*)number currentDate:(NSArray*)newArray selectedDay:(NSArray *)selectedDays
{
//    NSInteger p_2 =[number componentsJoinedByString:@""].intValue;
//    NSInteger p_1 =[newArray componentsJoinedByString:@""].intValue;
   _numLabel.font = [UIFont systemFontOfSize:14];
    _numLabel.textColor =  Color(150, 150, 150);
    self.shapeLayer.hidden = YES;
     if ([number[2] integerValue]>0) {
         
         self.numLabel.text = @"";
         self.userInteractionEnabled = YES;
       
     }
    else
    {
        
        self.numLabel.textColor =[UIColor whiteColor];
        self.numLabel.text = @"";
        self.userInteractionEnabled = NO;
    }
    if ([number[2] integerValue]>=10) {
        
        self.numLabel.text = [NSString stringWithFormat:@"%@",number[2]];
        
        
    }else if ([number[2] integerValue]< 10 && [number[2] integerValue] >0)
    {
        
        NSString*str =[NSString stringWithFormat:@"%@",number[2]];
        self.numLabel.text = [str stringByReplacingOccurrencesOfString:@"0" withString:@""];
    }
    
    if ([number[2] integerValue] == 7 ||[number[2] integerValue] == 14 ||[number[2] integerValue] == 21)
    {
         [self becomeSelected];
        
    }
    
    
    
}
-(void)becomeSelected
{
    _shapeLayer.hidden = NO;
    CGPathRef path = [UIBezierPath bezierPathWithOvalInRect:_shapeLayer.bounds].CGPath ;
    _shapeLayer.path = path;
    _shapeLayer.fillColor = Color(255,197,67).CGColor;
    _numLabel.textColor =[UIColor whiteColor];
    _numLabel.font = [UIFont boldSystemFontOfSize:14];
}
- (void)prepareForReuse
{
    [super prepareForReuse];
    
    [CATransaction setDisableActions:YES];
    _shapeLayer.hidden = YES;
    
}
@end
