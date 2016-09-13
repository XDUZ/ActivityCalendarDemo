//
//  SNSCalendarModel.m
//  SNSProject
//
//  Created by liu on 16/6/23.
//  Copyright © 2016年 思想加. All rights reserved.
//

#import "SNSCalendarModel.h"

@implementation SNSCalendarModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
-(instancetype)init
{
    self = [super init];
    if (self)
    {
        _activityArray = [NSArray array];
    }
    return self;
}
@end
