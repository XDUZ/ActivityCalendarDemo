//
//  SNSActivityCalendarViewController.m
//  SNSProject
//
//  Created by liu on 16/6/22.
//  Copyright © 2016年 思想加. All rights reserved.
//

#import "SNSActivityCalendarViewController.h"
#import "SNSCalendarModel.h"
#import "SNSCalendarActivityModel.h"
#import "SNSActivitysOfDayCell.h"
#import "SNSCalendarDetailViewController.h"
#import "SNSRefreshFooter.h"
#import "SNSCalendartableView.h"
//#import "SNSActivityViewController.h"
#import "SNSRefreshNormalHeader.h"

@interface SNSActivityCalendarViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)SNSCalendartableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UIRefreshControl  *refreshControl;
@end

@implementation SNSActivityCalendarViewController
{
    BOOL _isFootFresh;
    UIActivityIndicatorView* _activity;
    BOOL _isHeadRefresh;
    UIView* _headView;
    
    CGFloat _lastContentSizeHeight;
    NSInteger _firstMonth;
  
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
  
    self.navigationItem.title = @"活动日历";
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed:@"icon_calendarpage_nav_calender"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.frame = CGRectMake(0, 0, 30, 30);
 
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
     _dataArray = [[NSMutableArray alloc] init];
    NSInteger nowMonth = [self getNowMonth];
    _firstMonth = nowMonth;
    [self layoutUI];
    [self getDataSource];
}
-(void)rightClick
{
  
        SNSCalendarDetailViewController *calendar = [[SNSCalendarDetailViewController alloc] init];
        calendar.selectedDay = ^(NSArray *dayArray){
            SNSLog(@"%@",dayArray);
            _firstMonth = [dayArray[1] integerValue];
            [self getOneDayData:[dayArray[2] integerValue]];
            
        };
        [self.navigationController pushViewController:calendar animated:YES];
    
    
}
-(void)layoutUI
{
    
    _tableView= [[SNSCalendartableView alloc]initWithFrame:CGRectMake(0, 64, Screen_Width, Screen_Height - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = BackgroundColor01;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    __weak SNSActivityCalendarViewController *weakSelf = self;
    _tableView.mj_footer = [SNSRefreshFooter footerWithRefreshingBlock:^{
        _isFootFresh = YES;
        [weakSelf getDataSource];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.tableView.mj_footer endRefreshing];
            [weakSelf.tableView reloadData];
               _isFootFresh = NO;
        });
        
        
    }];
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    SNSRefreshNormalHeader *header = [SNSRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    header.automaticallyChangeAlpha = YES;
    
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    // 设置header
    self.tableView.mj_header = header;
  
   
//    _headView = [[UIView alloc] initWithFrame:CGRectMake(0,0, Screen_Width, 40)];
//    _headView.backgroundColor = [UIColor clearColor];
//    
//    _activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    [_headView addSubview:_activity];
//    _activity.frame = CGRectMake(_headView.frame.size.width/2, 10, 20, 20);
//    
//    _tableView.tableHeaderView = _headView;
//    _headView.hidden = YES;
//    
//    _tableView.contentOffset = CGPointMake(0, 40);
    
}
-(void)loadNewData
{
    [self loadMoreHistoryChatInfomation];
}
-(void)getOneDayData:(NSUInteger)day
{
    _dataArray = [NSMutableArray array];
    NSMutableArray *monthArray1 = [[NSMutableArray alloc] init];
   
    
    
    SNSCalendarModel *CalendarItem1 = [[SNSCalendarModel alloc] init];
    CalendarItem1.month = @"6月";
    CalendarItem1.day = @"21";
    CalendarItem1.week = @"周二";
    SNSCalendarActivityModel *actItem1 = [[SNSCalendarActivityModel alloc] init];
    actItem1.title = @"未来年度盛宴：致敬爱因斯坦，致敬科学";
    actItem1.wantJoinCount = @"2018";
    actItem1.commentCount = @"1013";
    actItem1.wantJoinFriends = @"李杰，李佳，李一一，辣哥";
    actItem1.userIds = @"1000030,1000041,1000444,1000538";
    SNSCalendarActivityModel *actItem2 = [[SNSCalendarActivityModel alloc] init];
    actItem2.title = @"6月13号，北方小乌镇－密云[古北口水镇－司马台长城]一日登山休闲活动";
    actItem2.wantJoinCount = @"208";
    actItem2.commentCount = @"123";
    actItem2.isSignUp = YES;
    CalendarItem1.activityArray =@[actItem1,actItem2];
    [monthArray1 addObject:CalendarItem1];
    
    
    SNSCalendarModel *CalendarItem2 = [[SNSCalendarModel alloc] init];
    CalendarItem2.month = @"6月";
    CalendarItem2.day = @"14";
    CalendarItem2.week = @"周天";
    SNSCalendarActivityModel *actItem21 = [[SNSCalendarActivityModel alloc] init];
    actItem21.title = @"陶瓷釉下彩绘，清华美院老师亲自指导";
    actItem21.wantJoinCount = @"2018";
    actItem21.commentCount = @"1013";
    SNSCalendarActivityModel *actItem22 = [[SNSCalendarActivityModel alloc] init];
    actItem22.title = @"西方绘画直通车第一季，水彩写生夏日玫瑰——水彩，水彩纸";
    actItem22.wantJoinCount = @"208";
    actItem22.commentCount = @"123";
    actItem22.isSignUp = YES;
    CalendarItem2.activityArray =@[actItem21,actItem22];
    [monthArray1 addObject:CalendarItem2];
    
    
    SNSCalendarModel *CalendarItem3 = [[SNSCalendarModel alloc] init];
    CalendarItem3.month = @"6月";
    CalendarItem3.day = @"7";
    CalendarItem3.week = @"周天";
    SNSCalendarActivityModel *actItem31 = [[SNSCalendarActivityModel alloc] init];
    actItem31.title = @"一节课玩转尤克里里，你的私人定制曲目";
    actItem31.wantJoinCount = @"2018";
    actItem31.commentCount = @"1013";
    CalendarItem3.activityArray =@[actItem31];
    [monthArray1 addObject:CalendarItem3];
    
    NSArray *monthArray2 = [NSArray array];
  
    if (day == 21)
    {
        monthArray2 = @[CalendarItem1,CalendarItem2,CalendarItem3];
    }
    else if (day == 14)
    {
        monthArray2 = @[CalendarItem2,CalendarItem3];
    }
    else if (day == 7)
    {
        monthArray2 = @[CalendarItem3];
    }

        [_dataArray addObject:monthArray2];
        [_dataArray addObject:monthArray1];
        [_dataArray addObject:monthArray1];
        [_dataArray addObject:monthArray1];
    
    
    
    
    [_tableView reloadData];
    _tableView.contentOffset = CGPointMake(0, 0);
}
-(void)getDataSource
{
    
    
    NSMutableArray *monthArray1 = [[NSMutableArray alloc] init];
//    
    SNSCalendarModel *CalendarItem0 = [[SNSCalendarModel alloc] init];
    CalendarItem0.month = @"6月";
    CalendarItem0.day = @"21";
    CalendarItem0.week = @"周二";
    SNSCalendarActivityModel *actItem01 = [[SNSCalendarActivityModel alloc] init];
    actItem01.title = @"未来年度盛宴：致敬爱因斯坦，致敬科学";
    actItem01.wantJoinCount = @"2018";
    actItem01.commentCount = @"1013";
//    actItem01.wantJoinFriends = @"李杰，李佳，李一一，辣哥";
//    actItem01.userIds = @"1000030,1000041,1000444,1000538";
    SNSCalendarActivityModel *actItem02 = [[SNSCalendarActivityModel alloc] init];
    actItem02.title = @"6月13号，北方小乌镇－密云[古北口水镇－司马台长城]一日登山休闲活动";
    actItem02.wantJoinCount = @"208";
    actItem02.commentCount = @"123";
    actItem02.isSignUp = YES;
    CalendarItem0.activityArray =@[actItem01,actItem02];
   
    
    SNSCalendarModel *CalendarItem1 = [[SNSCalendarModel alloc] init];
    CalendarItem1.month = @"6月";
    CalendarItem1.day = @"21";
    CalendarItem1.week = @"周二";
    CalendarItem1.isToday = YES;
    SNSCalendarActivityModel *actItem1 = [[SNSCalendarActivityModel alloc] init];
    actItem1.title = @"未来年度盛宴：致敬爱因斯坦，致敬科学";
    actItem1.wantJoinCount = @"2018";
    actItem1.commentCount = @"1013";
    actItem1.wantJoinFriends = @"李杰，李佳，李一一，辣哥";
    actItem1.userIds = @"1000030,1000041,1000444,1000538";
    SNSCalendarActivityModel *actItem2 = [[SNSCalendarActivityModel alloc] init];
    actItem2.title = @"6月13号，北方小乌镇－密云[古北口水镇－司马台长城]一日登山休闲活动";
    actItem2.wantJoinCount = @"208";
    actItem2.commentCount = @"123";
    actItem2.isSignUp = YES;
    CalendarItem1.activityArray =@[actItem1,actItem2];
    [monthArray1 addObject:CalendarItem1];
    
    
    SNSCalendarModel *CalendarItem2 = [[SNSCalendarModel alloc] init];
    CalendarItem2.month = @"6月";
    CalendarItem2.day = @"14";
    CalendarItem2.week = @"周天";
    SNSCalendarActivityModel *actItem21 = [[SNSCalendarActivityModel alloc] init];
    actItem21.title = @"陶瓷釉下彩绘，清华美院老师亲自指导";
    actItem21.wantJoinCount = @"2018";
    actItem21.commentCount = @"1013";
    SNSCalendarActivityModel *actItem22 = [[SNSCalendarActivityModel alloc] init];
    actItem22.title = @"西方绘画直通车第一季，水彩写生夏日玫瑰——水彩，水彩纸";
    actItem22.wantJoinCount = @"208";
    actItem22.commentCount = @"123";
    actItem22.isSignUp = YES;
    CalendarItem2.activityArray =@[actItem21,actItem22];
    [monthArray1 addObject:CalendarItem2];
    
    
    SNSCalendarModel *CalendarItem3 = [[SNSCalendarModel alloc] init];
    CalendarItem3.month = @"6月";
    CalendarItem3.day = @"7";
    CalendarItem3.week = @"周天";
    SNSCalendarActivityModel *actItem31 = [[SNSCalendarActivityModel alloc] init];
    actItem31.title = @"一节课玩转尤克里里，你的私人定制曲目";
    actItem31.wantJoinCount = @"2018";
    actItem31.commentCount = @"1013";
    CalendarItem3.activityArray =@[actItem31];
    [monthArray1 addObject:CalendarItem3];
    
     NSArray *monthArray2 = [NSArray array];
    monthArray2 = @[CalendarItem0,CalendarItem2,CalendarItem3];
    
    if (_isHeadRefresh)
    {
        [_dataArray insertObject:monthArray2 atIndex:0];
        [_dataArray insertObject:monthArray2 atIndex:0];
        [_dataArray insertObject:monthArray2 atIndex:0];
        [_dataArray insertObject:monthArray2 atIndex:0];
    }
    else
    {
        if (!_isFootFresh && !_isHeadRefresh)
        {
            [_dataArray addObject:monthArray1];
           
        }
        else
        {
            [_dataArray addObject:monthArray2];
         
        }
        [_dataArray addObject:monthArray2];
        [_dataArray addObject:monthArray2];
        [_dataArray addObject:monthArray2];
    }
    
  
  
    [_tableView reloadData];
    
}
#pragma mark screollViewDelegate
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    //NSLog(@"%f",scrollView.contentOffset.y);
//    if (scrollView.contentOffset.y<-10 && (scrollView.contentOffset.y > -100) &&  _isHeadRefresh==NO)
//    {
//        _isHeadRefresh = YES;
//        [self loadMoreHistoryChatInfomation];
//        NSLog(@"1111111111");
//    }
//}

-(void)loadMoreHistoryChatInfomation
{
 
    _lastContentSizeHeight = self.tableView.contentSize.height;
        //等待2s
        _headView.hidden = NO;
    
        _isHeadRefresh = YES;
    
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
           
            [self getDataSource];
            [_tableView reloadData];
            CGPoint offset = self.tableView.contentOffset;;
            offset.y += self.tableView.contentSize.height -_lastContentSizeHeight;
            self.tableView.contentOffset = offset;
            
     
            [self.tableView.mj_header endRefreshing];
           
            _headView.hidden = YES;
        });
    
    
    
}
#pragma mark tableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [[_dataArray objectAtIndex:section] count];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellName = @"cell";
    SNSActivitysOfDayCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil)
    {
        cell = [[SNSActivitysOfDayCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellName];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    BOOL isLastRow = NO;
    if ([[_dataArray objectAtIndex:indexPath.section] count] == indexPath.row +1)
    {
        isLastRow = YES;
    }
    //SNSCalendarModel *calendar = [[_dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    cell.activityCilck = ^(NSString *activityId){
        
        NSLog(@"点击了%@",activityId);
    };
    cell.peopeleCilck = ^(NSString *userId){

       
       
       
       NSLog(@"点击了%@",userId);
            
        
    };
    [cell updateCellWithModel:[[_dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] isLastRow:isLastRow];
    return cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SNSCalendarModel *item = [[_dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    SNSActivitysOfDayCell *cell = [[SNSActivitysOfDayCell alloc] init];
    return [cell getReuseableCellHeight:item];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 40)];
    view.backgroundColor = BackgroundColor01;
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, Screen_Width-40, 40)];
  
    if (_isHeadRefresh )
    {
        _firstMonth += 4;
        if (_firstMonth>12)
        {
            _firstMonth -= 12;
        }
        
    }
    if (_isHeadRefresh)
    {
        _isHeadRefresh = NO;
       
    }
    NSInteger month;
    if (_firstMonth-section>0)
    {
        month = _firstMonth-section;
    }
    else
    {
        long  beiShu = (-(_firstMonth -section))/12;
        
        month = _firstMonth-section + (beiShu+1)*12;
    }
    lab.text = [NSString stringWithFormat:@"%ld月",month];
    lab.font = TextSize02Light;
    lab.textColor = TextColor04;
    [view addSubview:lab];
    return view;
}
-(NSInteger)getNowMonth
{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    NSInteger month = [dateComponent month];
    
    return month;

}
#pragma mark
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
