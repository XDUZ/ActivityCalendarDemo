//
//  MLLabel+Size.h
//  SNSProject
//
//  Created by liu on 16/3/22.
//  Copyright © 2016年 思想加. All rights reserved.
//

#import "MLLabel.h"
#import "MLLinkLabel.h"

@interface MLLabel (Size)


+(CGSize) getViewSize:(NSAttributedString *)attributedText maxWidth:(CGFloat) maxWidth font:(UIFont *) font lineHeight:(CGFloat) lineHeight lines:(NSUInteger)lines;


+(CGSize) getViewSizeByString:(NSString *)text maxWidth:(CGFloat) maxWidth font:(UIFont *) font lineHeight:(CGFloat) lineHeight lines:(NSUInteger)lines;

+(CGSize) getViewSizeByString:(NSString *)text maxWidth:(CGFloat) maxWidth font:(UIFont *) font;

+(CGSize) getViewSizeByString:(NSString *)text font:(UIFont *) font;

@end
