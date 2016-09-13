//
//  UILabel+String.m
//  SNSProject
//
//  Created by liu on 15/11/8.
//  Copyright © 2015年 思想加. All rights reserved.
//

#import "UILabel+String.h"

@implementation UILabel (String)
+(UILabel *)LabelWithFrame:(CGRect)frame title:(NSString*)title font:(UIFont *)font backgroundColor:(UIColor *)backgroundColor textColor:(UIColor *)textColor
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = title;
    label.font = font;
    
    label.backgroundColor = backgroundColor == nil?[UIColor clearColor]:backgroundColor;
    label.textColor = textColor;
    return label;
    
}
@end
