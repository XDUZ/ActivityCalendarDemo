//
//  SNSActivitysOfDayCell.m
//  SNSProject
//
//  Created by liu on 16/6/23.
//  Copyright © 2016年 思想加. All rights reserved.
//

#import "SNSActivitysOfDayCell.h"
#import "SNSCalendarModel.h"
#import "SNSOneActivityOfCalendarCell.h"
#import "SNSCalendarActivityModel.h"
//#import "SNSLookPersonalCenterViewController.h"

@interface SNSActivitysOfDayCell ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,assign)CGFloat cellHeight;
@end
@implementation SNSActivitysOfDayCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initCell];
        _dataArray  = [NSArray array];
    }
    return self;
}
-(void)initCell
{
    self.backgroundColor = [UIColor whiteColor];
    _dateView = [[UIView alloc] initWithFrame:CGRectMake(16, 25, 44, 44)];
    _dateView.layer.borderColor = TextColor01.CGColor;
    _dateView.layer.borderWidth = 1;
    [self.contentView addSubview:_dateView];
    
    _dayLabel = [UILabel LabelWithFrame:CGRectMake(0, 3, 44, 25) title:@"" font:[UIFont boldSystemFontOfSize:24] backgroundColor:nil textColor:TextColor01];
    _dayLabel.textAlignment = NSTextAlignmentCenter;
    [_dateView addSubview:_dayLabel];
    
    _wewkLabel = [UILabel LabelWithFrame:CGRectMake(0, 30, 44, 10) title:@"" font:TextSize08 backgroundColor:nil textColor:TextColor04];
    _wewkLabel.textAlignment = NSTextAlignmentCenter;
    [_dateView addSubview:_wewkLabel];
    
    
    _todayLabel = [UILabel LabelWithFrame:CGRectMake(21, CGRectGetMaxY(_dateView.frame)+10, 34, 16) title:@"今天" font:TextSize08 backgroundColor:Color(70, 162, 255) textColor:[UIColor whiteColor]];
    _todayLabel.layer.cornerRadius = 8;
    _todayLabel.layer.masksToBounds = YES;
    _todayLabel.layer.shouldRasterize = YES;
    _todayLabel.layer.rasterizationScale = [UIScreen mainScreen].scale;
    _todayLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView  addSubview:_todayLabel];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.scrollEnabled = NO;
    [self.contentView addSubview:_tableView];
    
    _line= [[UIView alloc] init];
    _line.backgroundColor = LineColor01;
    [self.contentView addSubview:_line];
}

-(void)updateCellWithModel:(SNSCalendarModel *)calendarModel isLastRow:(BOOL)isLastRow
{
      _todayLabel.hidden = YES;
      _line.hidden = NO;
    if (calendarModel.isToday)
    {
        _todayLabel.hidden = NO;
    }
    _dayLabel.text = calendarModel.day;
    _wewkLabel.text = calendarModel.week;
    
    _dataArray = calendarModel.activityArray;

    CGFloat height = 0;
    CGFloat cellHeight = [self getCellHeightWithModel:calendarModel];
    if (cellHeight<Screen_Height-64-40)
    {
        height = cellHeight;
    }
    else
    {
        height = Screen_Height-64-40;
    }
    _tableView.frame = CGRectMake(80-16, 0, Screen_Width-80+16, height);
    
    if (isLastRow)
    {
        _line.hidden = YES;
    }
    else
    {
         _line.frame = CGRectMake(0, CGRectGetMaxY(_tableView.frame)-OnePxHeight, Screen_Width, OnePxHeight);
    }
    
    [_tableView reloadData];
    
}
-(CGFloat)getReuseableCellHeight:(SNSCalendarModel *)calendarModel
{
    if (calendarModel.cellHeight != 0) {
        //        NSLog(@"重用高度 %f", item.cellHeight);
        return calendarModel.cellHeight;
    }
    CGFloat height = [self getCellHeightWithModel:calendarModel];
    calendarModel.cellHeight = height;
   
    
    return height;
}
-(CGFloat)getCellHeightWithModel:(SNSCalendarModel *)calendarModel
{
    _cellHeight = 0;
    
    
    _dataArray = calendarModel.activityArray;
    SNSOneActivityOfCalendarCell *cell = [[SNSOneActivityOfCalendarCell alloc] init];
    for (SNSCalendarActivityModel *item in _dataArray)
    {
       _cellHeight += [cell getReuseableCellHeight:item];
    }
    
    return _cellHeight;
}


#pragma tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     return _dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"cell";
    SNSOneActivityOfCalendarCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil)
    {
        cell = [[SNSOneActivityOfCalendarCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellName];
        //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    BOOL isLastRow = NO;
    if (_dataArray.count == indexPath.row +1)
    {
        isLastRow = YES;
    }
    cell.peopeleCilck = ^(NSString *userId){
        if (_peopeleCilck)
        {
            _peopeleCilck(userId);
        }
    };
    [cell updateCellWithModel:[_dataArray objectAtIndex:indexPath.row] isLastRow:isLastRow];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (_activityCilck)
    {
        _activityCilck(@"23");
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SNSOneActivityOfCalendarCell *cell = [[SNSOneActivityOfCalendarCell alloc] init];
    SNSCalendarActivityModel *item = [_dataArray objectAtIndex:indexPath.row];
    return [cell getReuseableCellHeight:item];
}


@end
