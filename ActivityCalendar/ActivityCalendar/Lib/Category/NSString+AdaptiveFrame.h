//
//  NSString+AdaptiveFrame.h
//  SNSProject
//
//  Created by liu on 15/11/5.
//  Copyright © 2015年 思想加. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AdaptiveFrame)
+(CGSize)boundingRectWitText:(NSString *)text font:(UIFont *)font textSize:(CGSize)textSize;
@end
