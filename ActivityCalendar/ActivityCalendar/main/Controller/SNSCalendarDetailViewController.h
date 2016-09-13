//
//  SNSCalendarDetailViewController.h
//  SNSProject
//
//  Created by liu on 16/6/23.
//  Copyright © 2016年 思想加. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SNSCalendarDetailViewController : UIViewController

@property(nonatomic,strong)void(^selectedDay)(NSArray *day);
@end
