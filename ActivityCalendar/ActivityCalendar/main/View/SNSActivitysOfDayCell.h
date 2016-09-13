//
//  SNSActivitysOfDayCell.h
//  SNSProject
//
//  Created by liu on 16/6/23.
//  Copyright © 2016年 思想加. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SNSCalendarModel;
@interface SNSActivitysOfDayCell : UITableViewCell

@property (nonatomic, strong) UIView *dateView;
@property (nonatomic, strong) UILabel *dayLabel;
@property (nonatomic, strong) UILabel *wewkLabel;
@property (nonatomic, strong) UILabel *todayLabel;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView  *line;
@property (nonatomic, strong) void(^activityCilck)(NSString *activityId);
@property (nonatomic, strong) void(^peopeleCilck)(NSString *userId);

-(void)updateCellWithModel:(SNSCalendarModel *)calendarModel isLastRow:(BOOL)isLastRow;

-(CGFloat)getReuseableCellHeight:(SNSCalendarModel *)calendarModel;
//-(CGFloat)getCellHeightWithModel:(SNSCalendarModel *)calendarModel;
@end
