//
//  UILabel+String.h
//  SNSProject
//
//  Created by liu on 15/11/8.
//  Copyright © 2015年 思想加. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (String)
+(UILabel *)LabelWithFrame:(CGRect)frame title:(NSString*)title font:(UIFont *)font backgroundColor:(UIColor *)backgroundColor textColor:(UIColor *)textColor;
@end
