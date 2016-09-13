//
//  SNSCalendarDetailViewController.m
//  SNSProject
//
//  Created by liu on 16/6/23.
//  Copyright © 2016年 思想加. All rights reserved.
//
#define HeaderHeight  (72+22)
#define itemHeight  34

#import "SNSCalendarDetailViewController.h"
#import "SNSCalendarDayViewCell.h"
#import "SNSCalendarHearderView.h"
#import "SNSCalendarMonthModel.h"
#import "SNSRefreshFooter.h"


static NSString * const reuseIdentifier = @"ChooseTimeCell";
static NSString * const headerIdentifier = @"headerIdentifier";

@interface SNSCalendarDetailViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSDateFormatter *formatter;
@property (nonatomic, strong) NSDateComponents *comps;
@property (nonatomic, strong) NSCalendar *calender;
@property (nonatomic, strong) NSArray * weekdays;
@property (nonatomic, strong) NSTimeZone *timeZone;
@property (nonatomic, strong) NSArray *OutDateArray;
@property (nonatomic, strong) NSArray *selectedData;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, assign) NSInteger currentMonth;
@property (nonatomic, assign) NSInteger currentYear;
@property (nonatomic, strong) NSMutableDictionary *monthHeightDic;
@end

@implementation SNSCalendarDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = [NSString stringWithFormat:@"%ld年",(long)_currentYear];
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"ic_arrowback_black"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.frame = CGRectMake(0, 12, 20, 20);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    _date = [NSDate date];
    _currentMonth = [self getNowMonth];
    _currentYear = [self getNowYear];
    _monthHeightDic = [[NSMutableDictionary alloc] init];
    _dataArray = [NSMutableArray array];
    [self getData];
    [self updateSectionHeight];

    [self layoutUI];
    
  
   

}
-(void)leftClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)layoutUI
{
    float cellw =(Screen_Width -32)/7;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
  
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];//设置其布局方向
    [flowLayout setHeaderReferenceSize:CGSizeMake(Screen_Width, HeaderHeight)];
    [flowLayout setMinimumInteritemSpacing:0]; //设置 y 间距
    [flowLayout setMinimumLineSpacing:0]; //设置 x 间距
    [flowLayout setItemSize:CGSizeMake(cellw,itemHeight)];//设置cell的尺寸
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 16, 0, 15);//设置其边界
    //UIEdgeInsetsMake(设置上下cell的上间距,设置cell左距离,设置上下cell的下间距,设置cell右距离);
    
    //其布局很有意思，当你的cell设置大小后，一行多少个cell，由cell的宽度决定
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-64) collectionViewLayout:flowLayout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    //    注册cell
    [_collectionView registerClass:[SNSCalendarHearderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier];
    [_collectionView registerClass:[SNSCalendarDayViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
   
    
    [self.view addSubview:_collectionView];
    
    __weak SNSCalendarDetailViewController *weekSelf = self;
    _collectionView.mj_footer = [SNSRefreshFooter footerWithRefreshingBlock:^{
      
        [weekSelf getData];
    
       
       
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weekSelf.collectionView.mj_footer endRefreshing];
            [weekSelf.collectionView reloadData];
            [weekSelf updateSectionHeight];
        });
    }];
    // 默认先隐藏footer
    self.collectionView.mj_footer.hidden = YES;
    
    _collectionView.contentInset = UIEdgeInsetsMake(-14, 0, 0, 0);
    
}
-(void)getData
{
    for (int i = 0; i<5; i++)
    {
        SNSCalendarMonthModel *month = [[SNSCalendarMonthModel alloc] init];
        [_dataArray addObject:month];
        
    }
    
    
}
#pragma mark ---
#pragma mark --- <UICollectionViewDataSource>

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//    
//    CGSize size={Screen_Width,HeaderHeight};
//    return size;
//}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return _dataArray.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    //算出section月前的当前时间
    NSDate *dateList = [self getPriousorLaterDateFromDate:_date withMonth:(int)section];
    //算出那个月的第一天是周几
    NSString *timerNsstring = [self getMonthBeginAndEndWith:dateList];
    NSInteger weekDay = [timerNsstring integerValue];
    NSInteger allDay = [self getNumberOfDays:dateList] + weekDay;
    
    [self getSectionHeightWithSection:section allDays:allDay];
    return allDay;
}
-(void)getSectionHeightWithSection:(NSInteger)section allDays:(NSUInteger) Days
{
    SNSCalendarMonthModel *month = [_dataArray objectAtIndex:section];
    if (month.sectionHight == 0 )
    {
        CGFloat height = 0;
        if (Days>35)
        {
            //六行
            height += HeaderHeight+itemHeight*6;
            
            
        }
        else
        {
            //五行
           height += HeaderHeight+itemHeight*5;
        }
        month.sectionHight = height;
    }
   
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SNSCalendarDayViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    NSDate*dateList = [self getPriousorLaterDateFromDate:_date withMonth:(int)indexPath.section];
    
    NSArray*array = [self timeString:_date many:indexPath.section];
    
    NSInteger p = indexPath.row -[self getMonthBeginAndEndWith:dateList].intValue+1;
    
    NSString *str;
    
    if (p<10) {
        
        str = p > 0 ? [NSString stringWithFormat:@"0%ld",(long)p]:[NSString stringWithFormat:@"-0%ld",(long)-p];
        
    }else{
        
        str = [NSString stringWithFormat:@"%ld",(long)p];
    }
    
    
    NSArray *list = @[ array[0], array[1], str];
    
    //    [cell updateDay:list outDate:self.OutDateArray selected:[self.selectedData componentsJoinedByString:@""].integerValue currentDate:[self timeString:newDate many:0]];
    [cell updateDay:list currentDate:[self timeString:_date many:0] selectedDay:nil];
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    

    NSArray *array = [self timeString:_date many:(int)indexPath.section];
    
  
    SNSCalendarDayViewCell *cell = (SNSCalendarDayViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if ([cell.numLabel.text integerValue] == 7 || [cell.numLabel.text integerValue] == 14 || [cell.numLabel.text integerValue] == 21) {
        if (_selectedDay)
        {
            NSArray *timeArray = @[array[0],array[1],cell.numLabel.text];
            
            _selectedDay(timeArray);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SNSCalendarDayViewCell *cell = (SNSCalendarDayViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if ([cell.numLabel.text integerValue] == 7 || [cell.numLabel.text integerValue] == 14  ||  [cell.numLabel.text integerValue] == 21 ) {
        return YES;
    }
    return NO;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        SNSCalendarHearderView * headerCell = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier forIndexPath:indexPath];
        
        NSArray *timeArray =[self timeString:_date many:indexPath.section];
      
        [headerCell updateTime:timeArray section:indexPath.section];
        
        return headerCell;
    }
    return nil;
}
/**
 *  将高度存进字典
 */
-(void)updateSectionHeight
{
    CGFloat lastMonthCount = 12-_currentMonth+1;
    
    if (_dataArray.count - lastMonthCount>0)
    {
        CGFloat firstHeight = 0;
        if (_monthHeightDic.count == 0)
        {
            
            for (int i = 0 ; i<lastMonthCount; i++)
            {
                SNSCalendarMonthModel *month = [_dataArray objectAtIndex:i];
                firstHeight += month.sectionHight;
                NSLog(@"firstHeight=%f",firstHeight);
            }
            [_monthHeightDic setObject:[NSString stringWithFormat:@"%f",firstHeight] forKey:@"0"];
        }
        else
        {
            int yearMultiple = (_dataArray.count - lastMonthCount)/12;
            if (yearMultiple >0 )
            {
                CGFloat lastHeight ;
                for (int i = 0; i<yearMultiple; i++)
                {
                    if (_monthHeightDic.count  <= i+1)
                    {
                        
                        
                        lastHeight += [[_monthHeightDic objectForKey:[NSString stringWithFormat:@"%d",i]] floatValue];
                        
                        for (int m = 0 ; m<12; m++)
                        {
                            SNSCalendarMonthModel *month = [_dataArray objectAtIndex:i*12+(lastMonthCount-1)+m];
                            lastHeight += month.sectionHight;
                        }
                        [_monthHeightDic setObject:[NSString stringWithFormat:@"%f",lastHeight] forKey:[NSString stringWithFormat:@"%d",i+1]];
                    }
                    
                }
                
            }
        }
        
        
    }
}




-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
   
    CGFloat offsetY = scrollView.contentOffset.y-14;
    


    if (_monthHeightDic.count>0)
    {
    
            for (int i = 0; i<_monthHeightDic.count; i++)
            {
                CGFloat nowMonthHeight = [[_monthHeightDic objectForKey: [NSString stringWithFormat:@"%d",i]] floatValue];
                CGFloat nextMonthHeight = 0;
                if (i+1<_monthHeightDic.count)
                {
                   nextMonthHeight  = [[_monthHeightDic objectForKey: [NSString stringWithFormat:@"%d",i+1]] floatValue];
                }
                if (i == 0)
                {
                    if (offsetY<= nowMonthHeight)
                    {
                        self.navigationItem.title = [NSString stringWithFormat:@"%ld年",(long)_currentYear];
                         break;
                    }
                   
                }
                if (nextMonthHeight == 0)
                {
                    if (offsetY>nowMonthHeight)
                    {
                       self.navigationItem.title = [NSString stringWithFormat:@"%ld年",(long)_currentYear+i+1];
                       
                    }
                   break;
                   
                }
              
                if ((nowMonthHeight <= offsetY) && (offsetY  <= nextMonthHeight))
                {
                    self.navigationItem.title= [NSString stringWithFormat:@"%ld年",(long)_currentYear+i+1];
                    SNSLog(@"%@",[NSString stringWithFormat:@"%ld年",(long)_currentYear+i+1]);
                }
               
                
            }
        
       
        
      
    }
    
    
  
    
}

#pragma mark ---
#pragma mark --- 初始化
- (NSTimeZone*)timeZone
{
    
    if (_timeZone == nil) {
        [UIColor blueColor];
        _timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    }
    return _timeZone;
}


- (NSArray*)weekdays
{
    
    if (_weekdays == nil) {
        
        _weekdays = [NSArray arrayWithObjects: [NSNull null], @"0", @"1", @"2", @"3", @"4", @"5", @"6", nil];
        
    }
    return _weekdays;
}
- (NSCalendar*)calender
{
    
    if (_calender == nil) {
        
        _calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    }
    
    return _calender;
}
- (NSDateComponents*)comps
{
    
    if (_comps == nil) {
        
        _comps = [[NSDateComponents alloc] init];
        
    }
    
    return _comps;
}
- (NSDateFormatter*)formatter
{
    
    if (_formatter == nil) {
        
        _formatter =[[NSDateFormatter alloc]init];
        [_formatter setDateFormat:@"yyyy-MM-dd"];
    }
    return _formatter;
}


#pragma mark ---
#pragma mark --- 各种方法

-(NSInteger)getNowMonth
{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    NSInteger month = [dateComponent month];
    
    return month;
    
}
-(NSInteger)getNowYear
{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    NSInteger year = [dateComponent year];
    
    return year;
    
}
/**
 *  根据当前月获取有多少天
 *
 *  @param dayDate 但前时间
 *
 *  @return 天数
 */
- (NSInteger)getNumberOfDays:(NSDate *)dayDate
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:dayDate];
    
    return range.length;
    
}
/**
 *  获取某个月份的时间（第几个月前的当前时间）
 *
 *  @param date  当前时间
 *  @param month 第几个月 正数为前  负数为后
 *
 *  @return 获得时间
 */
- (NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withMonth:(int)month

{
    [self.comps setMonth:month];
    
    NSDate *mDate = [self.calender dateByAddingComponents:self.comps toDate:date options:0];
    return mDate;
    
}



/**
 *  根据时间获取周几
 *
 *  @param inputDate 输入参数是NSDate，
 *
 *  @return 输出结果是星期几的字符串。
 */
- (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    
    
    
    [self.calender setTimeZone: self.timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [self.calender components:calendarUnit fromDate:inputDate];
    
    return [self.weekdays objectAtIndex:theComponents.weekday];
    
}
/**
 *  获取第N个月的时间数组
 *
 *  @param currentDate 当前时间
 *  @param index 第几个月 正数为前  负数为后
 *
 *  @return @“2016  6  24”
 */
- (NSArray*)timeString:(NSDate*)currentDate many:(NSInteger)index;
{
    
    NSDate *getDate =[self getPriousorLaterDateFromDate:currentDate withMonth:index];
    
    NSString  *str =  [self.formatter stringFromDate:getDate];
    
    return [str componentsSeparatedByString:@"-"];
}

/**
 *  根据时间获取第一天周几
 *
 *  @param dateStr 时间
 *
 *  @return 周几
 */
- (NSString*)getMonthBeginAndEndWith:(NSDate *)dateStr{
    
    double interval = 0;
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar setFirstWeekday:2];//设定周一为周首日
    BOOL ok = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&beginDate interval:&interval forDate:dateStr];
    //分别修改为 NSDayCalendarUnit NSWeekCalendarUnit NSYearCalendarUnit
    if (ok) {
        //根据当前时间算结束时间
        endDate = [beginDate dateByAddingTimeInterval:interval-1];
    }else {
        return @"";
    }
    
    return   [self weekdayStringFromDate:beginDate];
}


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
