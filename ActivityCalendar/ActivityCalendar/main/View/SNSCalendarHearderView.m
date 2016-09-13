//
//  SNSCalendarHearderView.m
//  Calendar
//
//  Created by liu on 16/6/24.
//  Copyright © 2016年 思想加. All rights reserved.

#define HeaderHeight  (72+22)
#import "SNSCalendarHearderView.h"

@implementation SNSCalendarHearderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self layoutUI];
    }
    return self;
}
-(void)layoutUI
{
    
    UIView *monthView = [[UIView alloc] initWithFrame:CGRectMake(0, 14, Screen_Width, 40)];
    monthView.backgroundColor = BackgroundColor01;
    [self addSubview:monthView];
    
    _monthLabel = [UILabel LabelWithFrame:CGRectMake(16, 0, 300, 40) title:nil font:TextSize02 backgroundColor:nil textColor:TextColor04];
    [monthView addSubview:_monthLabel];
    
    _topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, OnePxHeight)];
    _topLine.backgroundColor = LineColor01;
    [monthView addSubview:_topLine];
    
    UIView *weekView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(monthView.frame), self.frame.size.width, 32)];
    weekView.backgroundColor = [UIColor whiteColor];
    [self addSubview:weekView];
                                
    
    
    
    NSArray *weekArray = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    CGFloat labelWidth = (Screen_Width-32)/7;
    CGFloat labelHeight = 32;
    CGFloat  labelX = 16;
     CGFloat  labelY = 0;
    for (int i = 0; i<7; i++)
    {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(labelX,labelY , labelWidth, labelHeight)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = [weekArray objectAtIndex:i];
        label.textColor = TextColor03;
        label.font = TextSize06;
        [weekView addSubview:label];
        
        labelX +=labelWidth;
        if (i  == 6 || i == 0)
        {
            label.textColor = Color(223, 96, 73);
        }
    }
    UIView *line = [self createDashed];
    line.frame =CGRectMake(16,CGRectGetMaxY(weekView.frame) , Screen_Width-32, OnePxHeight);
    [self addSubview:line];
}

-(void)updateTime:(NSArray *)time section:(NSInteger)section
{
    NSString *month;
    if ([time[1] integerValue] <10)
    {
         month = [time[1] stringByReplacingOccurrencesOfString:@"0" withString:@""];
    }
    else
    {
        month = time[1];
    }
    NSString *timeStr  = [NSString stringWithFormat:@"%@月",month];
    _monthLabel.text = timeStr;
    _topLine.hidden  = NO;
    if (section == 0)
    {
        _topLine.hidden = YES;
    }
}
//虚线
-(UIView *)createDashed
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(16,HeaderHeight-OnePxHeight , Screen_Width-32, OnePxHeight)];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    //    [shapeLayer setBounds:self.bounds];
    //    [shapeLayer setPosition:self.center];
    [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    // 设置虚线颜色为blackColor [shapeLayer setStrokeColor:[[UIColor blackColor] CGColor]];
    [shapeLayer setStrokeColor:[LineColor01 CGColor]];
    // 3.0f设置虚线的宽度(高度)
    [shapeLayer setLineWidth:OnePxHeight];
    [shapeLayer setLineJoin:kCALineJoinRound];
    // 3=线的宽度 1=每条线的间距
    [shapeLayer setLineDashPattern:
     [NSArray arrayWithObjects:[NSNumber numberWithInt:2],[NSNumber numberWithInt:2],nil]];
    // Setup the path
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    //    CGPathAddLineToPoint(path, NULL, 320,89);
    // Setup the path CGMutablePathRef path = CGPathCreateMutable(); // 0,10代表初始坐标的x，y
    // 320,10代表初始坐标的x，y CGPathMoveToPoint(path, NULL, 0, 10);
    CGPathAddLineToPoint(path, NULL, view.frame.size.width,OnePxHeight);
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    
    [view.layer addSublayer:shapeLayer];
    return view;
}
@end
