//
//  SNSCalendarDayViewCell.h
//  Calendar
//
//  Created by liu on 16/6/24.
//  Copyright © 2016年 思想加. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SNSCalendarDayViewCell : UICollectionViewCell
@property(nonatomic , strong) UILabel *numLabel;
@property (weak, nonatomic) CAShapeLayer *shapeLayer;

- (void)updateDay:(NSArray*)number currentDate:(NSArray*)newArray selectedDay:(NSArray *)selectedDays;
@end
