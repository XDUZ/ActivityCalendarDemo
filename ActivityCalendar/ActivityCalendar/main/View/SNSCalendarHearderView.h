//
//  SNSCalendarHearderView.h
//  Calendar
//
//  Created by liu on 16/6/24.
//  Copyright © 2016年 思想加. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SNSCalendarHearderView : UICollectionReusableView
@property(nonatomic,strong)UILabel *monthLabel;
@property(nonatomic,strong)  UIView *topLine;

-(void)updateTime:(NSArray *)time section:(NSInteger)section;
@end
