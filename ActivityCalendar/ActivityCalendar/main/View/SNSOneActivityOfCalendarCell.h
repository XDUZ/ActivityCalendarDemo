//
//  SNSOneActivityOfCalendarCell.h
//  SNSProject
//
//  Created by liu on 16/6/23.
//  Copyright © 2016年 思想加. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SNSPeopleClickView.h"
@class SNSCalendarActivityModel;
@interface SNSOneActivityOfCalendarCell : UITableViewCell

//活动标题
@property (nonatomic, strong) UILabel *titleLabel;
//已签到标签
@property (nonatomic, strong) UILabel *hadSignUpLabel;
//想参加
@property (nonatomic, strong) UILabel *wantJoinCountLabel;
//评论人数
@property (nonatomic, strong) UILabel *commentCountLabel;

@property(strong,nonatomic)UIImageView *commentIV;
@property(strong,nonatomic)UIImageView *heartIV;
//想参加的好友
@property(nonatomic,strong)SNSPeopleClickView *peopeleClickView;
@property (nonatomic, strong) UILabel *wantJoinLabel;
@property (nonatomic, strong) UIView *peopleView;
@property (nonatomic, strong) void(^peopeleCilck)(NSString *userId);
//签到的好友
@property (nonatomic, strong) UILabel *signUpLabel;

@property (nonatomic, strong) UIView  *line;
-(void)updateCellWithModel:(SNSCalendarActivityModel *)item isLastRow:(BOOL)isLastRow;

-(CGFloat)getReuseableCellHeight:(SNSCalendarActivityModel *)item;
//-(CGFloat)getCellHeightWithModel:(SNSCalendarActivityModel *)item;
@end
