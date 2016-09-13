//
//  SNSCalendarActivityModel.h
//  SNSProject
//
//  Created by liu on 16/6/23.
//  Copyright © 2016年 思想加. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNSCalendarActivityModel : NSObject
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *wantJoinCount;
@property(nonatomic,strong)NSString *commentCount;
@property(nonatomic,strong)NSString *wantJoinFriends;
@property(nonatomic,strong)NSString *signUpFriends;
@property(nonatomic,strong)NSString *userIds;
@property(nonatomic,assign)BOOL isSignUp;
@property(nonatomic,assign)CGFloat cellHeight;
@end
