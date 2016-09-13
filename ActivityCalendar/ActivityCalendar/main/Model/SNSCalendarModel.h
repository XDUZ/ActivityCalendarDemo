//
//  SNSCalendarModel.h
//  SNSProject
//
//  Created by liu on 16/6/23.
//  Copyright © 2016年 思想加. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNSCalendarModel : NSObject

@property(nonatomic,strong)NSString *month;
@property(nonatomic,strong)NSString *day;
@property(nonatomic,strong)NSString *week;
@property(nonatomic,assign)BOOL isToday;
@property(nonatomic,strong)NSArray *activityArray;

@property(nonatomic,assign)CGFloat cellHeight;
@end
