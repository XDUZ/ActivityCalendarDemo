//
//  SNSPeopleClickView.m
//  SNSProject
//
//  Created by liu on 16/6/29.
//  Copyright © 2016年 思想加. All rights reserved.
//
#define OneLineHeight  14
#define LineHeightMultiple 1.1
#import "SNSPeopleClickView.h"
#import "NSString+AdaptiveFrame.h"
#import "MLLabel+Size.h"


@interface SNSPeopleClickView ()

@property(nonatomic,strong)UILabel *titlelabel;
@property(nonatomic,strong)MLLinkLabel *peopleLabel;
@end
@implementation SNSPeopleClickView


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}
-(void)initView
{
    if (_titlelabel == nil)
    {
         _titlelabel = [[UILabel alloc] init];
        [self addSubview:_titlelabel];
    }
    
    if (_peopleLabel == nil)
    {
        _peopleLabel =[[MLLinkLabel alloc] initWithFrame:CGRectZero];
        _peopleLabel.textColor = TextColor07;
        _peopleLabel.numberOfLines = 0;
        _peopleLabel.adjustsFontSizeToFitWidth = NO;
        _peopleLabel.textInsets = UIEdgeInsetsZero;
        
        _peopleLabel.dataDetectorTypes = MLDataDetectorTypeAll;
        _peopleLabel.allowLineBreakInsideLinks = NO;
        _peopleLabel.linkTextAttributes = nil;
        _peopleLabel.activeLinkTextAttributes = nil;
        _peopleLabel.lineHeightMultiple = LineHeightMultiple;
        _peopleLabel.linkTextAttributes = @{NSForegroundColorAttributeName: TextColor07};
        
        __weak SNSPeopleClickView *weakSelf = self;
        
        [_peopleLabel setDidClickLinkBlock:^(MLLink *link, NSString *linkText, MLLinkLabel *label) {
            
            if (weakSelf.onClickPeople)
            {
                weakSelf.onClickPeople(link.linkValue);
            }
            
        }];
        [self addSubview:_peopleLabel];
    }
}
-(void)updateWithTitle:(NSString *)title titleFont:(UIFont *)titleFont titleColor:(UIColor *)titleColor peopleNameArray:(NSArray *)peopleNameArray userIdArray:(NSArray *)userIdArray
{
    CGFloat contentWidth =  self.frame.size.width;
    CGSize titleSize = [NSString boundingRectWitText:title font:titleFont textSize:CGSizeMake(contentWidth, 20)];
    _titlelabel.frame = CGRectMake(0, 2, titleSize.width+10, titleSize.height);
    _titlelabel.text = title;
    _titlelabel.font = titleFont;
    _titlelabel.textColor = titleColor;
    
    
    _peopleLabel.font = titleFont;
    NSString *peopleWholeStr = @"";
    for (int i = 0; i<peopleNameArray.count; i++)
    {
        
        if (i == 0)
        {
            peopleWholeStr = [NSString stringWithFormat:@"%@",[peopleNameArray firstObject]];
        }else
        {
            peopleWholeStr = [NSString stringWithFormat:@"%@, %@", peopleWholeStr,[peopleNameArray objectAtIndex:i]];
        }
        
    }
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:peopleWholeStr];
    NSUInteger position = 0;
    
    for (int i = 0; i<peopleNameArray.count; i++)
    {
        NSString *name = [peopleNameArray objectAtIndex:i];
        [attrStr addAttribute:NSLinkAttributeName value:[userIdArray objectAtIndex:i] range:NSMakeRange(position,name.length )];
        position += name.length+2;
    }
    _peopleLabel.attributedText = attrStr;
    
    [_peopleLabel sizeToFit];
    CGFloat peopleWidth = contentWidth-titleSize.width-10;
    CGSize peopleSize = [MLLinkLabel getViewSize:attrStr maxWidth:peopleWidth font:titleFont lineHeight:LineHeightMultiple lines:0];
    
//    CGSize oneLineSize = [MLLinkLabel getViewSize:attrStr maxWidth:peopleWidth font:titleFont lineHeight:LineHeightMultiple lines:1];
    
//    _titlelabel.frame = CGRectMake(0, 0, titleSize.width+10, oneLineSize.height);
    _peopleLabel.frame = CGRectMake(CGRectGetMaxX(_titlelabel.frame), 0,peopleWidth, peopleSize.height);
    NSLog(@"%f",CGRectGetMaxY(_peopleLabel.frame));
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, CGRectGetMaxY(_peopleLabel.frame));
}

-(CGFloat)getHeightWithTitle:(NSString *)title titleFont:(UIFont *)titleFont peopleNameArray:(NSArray *)peopleNameArray
{
    
    CGFloat contentWidth =  self.frame.size.width;
    CGSize titleSize = [NSString boundingRectWitText:title font:titleFont textSize:CGSizeMake(contentWidth, 20)];
    
    NSString *peopleWholeStr = @"";
    for (int i = 0; i<peopleNameArray.count; i++)
    {
        
        if (i == 0)
        {
            peopleWholeStr = [NSString stringWithFormat:@"%@",[peopleNameArray firstObject]];
        }else
        {
            peopleWholeStr = [NSString stringWithFormat:@"%@， %@", peopleWholeStr,[peopleNameArray objectAtIndex:i]];
        }
        
    }
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:peopleWholeStr];
    CGFloat peopleWidth = contentWidth-titleSize.width-10;
    CGSize peopleSize = [MLLinkLabel getViewSize:attrStr maxWidth:peopleWidth font:titleFont lineHeight:LineHeightMultiple lines:0];
    
    return peopleSize.height;
}

   
    
   
    
  
    
  
    
















@end
