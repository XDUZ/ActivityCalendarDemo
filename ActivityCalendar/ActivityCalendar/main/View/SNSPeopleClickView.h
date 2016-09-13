//
//  SNSPeopleClickView.h
//  SNSProject
//
//  Created by liu on 16/6/29.
//  Copyright © 2016年 思想加. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SNSPeopleClickView : UIView



@property(nonatomic,strong)void(^onClickPeople)(NSString *userId);


-(void)updateWithTitle:(NSString *)title titleFont:(UIFont *)titleFont titleColor:(UIColor *)titleColor peopleNameArray:(NSArray *)peopleNameArray userIdArray:(NSArray *)userIdArray;


-(CGFloat)getHeightWithTitle:(NSString *)title titleFont:(UIFont *)titleFont peopleNameArray:(NSArray *)peopleNameArray;
@end
