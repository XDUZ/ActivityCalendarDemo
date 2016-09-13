//
//  NSString+AdaptiveFrame.m
//  SNSProject
//
//  Created by liu on 15/11/5.
//  Copyright © 2015年 思想加. All rights reserved.
//

#import "NSString+AdaptiveFrame.h"

@implementation NSString (AdaptiveFrame)
+(CGSize)boundingRectWitText:(NSString *)text font:(UIFont *)font textSize:(CGSize)textSize
{
    NSDictionary *attribute = @{NSFontAttributeName: font};
    CGSize size = textSize;
    CGSize retSize = [text boundingRectWithSize:size
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:attribute
                                        context:nil].size;
    
    return retSize;
}

@end
