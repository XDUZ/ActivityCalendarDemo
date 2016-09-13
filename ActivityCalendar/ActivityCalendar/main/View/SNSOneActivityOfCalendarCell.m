//
//  SNSOneActivityOfCalendarCell.m
//  SNSProject
//
//  Created by liu on 16/6/23.
//  Copyright © 2016年 思想加. All rights reserved.
//
#define ContentWidth Screen_Width -80-16

#import "SNSOneActivityOfCalendarCell.h"
#import "SNSCalendarActivityModel.h"
#import "NSString+AdaptiveFrame.h"


@implementation SNSOneActivityOfCalendarCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initCell];
    }
    return self;
}
-(void)initCell
{

    _titleLabel = [UILabel LabelWithFrame:CGRectMake(16, 25, ContentWidth, 10) title:@"" font:TextSize03 backgroundColor:nil textColor:TextColor01];
    _titleLabel.numberOfLines = 0;
    
    [self.contentView addSubview:_titleLabel];
    
    
     _commentIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_index_comment"]];
    [self.contentView addSubview:_commentIV];
    //活动评论数
    _commentCountLabel = [UILabel LabelWithFrame: CGRectZero title:@"" font:TextSize07Light backgroundColor:nil textColor:TextColor01];
    
    [self.contentView addSubview:_commentCountLabel];
    
    
    _heartIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_index_heart"]];
    [self.contentView addSubview:_heartIV];
    //想参加人数
    _wantJoinCountLabel = [UILabel LabelWithFrame:CGRectZero  title:nil font:TextSize07Light backgroundColor:nil textColor:TextColor01];
    [self.contentView addSubview:_wantJoinCountLabel];
    
    
    //已签到
    _hadSignUpLabel = [UILabel LabelWithFrame:CGRectZero title:@"已签到" font:TextSize07 backgroundColor:nil textColor:COLORGOLDEN];
    _hadSignUpLabel.layer.cornerRadius = 7;
    _hadSignUpLabel.layer.masksToBounds = YES;
    _hadSignUpLabel.layer.borderColor = COLORGOLDEN.CGColor;
    _hadSignUpLabel.layer.borderWidth = OnePxHeight;
    _hadSignUpLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_hadSignUpLabel];
    
    //想参加的好
    _peopeleClickView = [[SNSPeopleClickView alloc]initWithFrame:CGRectMake(16, 0, ContentWidth, 20)];
    [self.contentView addSubview:_peopeleClickView];
    __weak SNSOneActivityOfCalendarCell *weakSelf = self;
    _peopeleClickView.onClickPeople = ^(NSString *userId){
        if (weakSelf.peopeleCilck)
        {
            weakSelf.peopeleCilck(userId);
        }
    };
//    _wantJoinLabel = [UILabel LabelWithFrame:CGRectZero title:nil font:TextSize07Light backgroundColor:nil textColor:TextColor04];
//     [self.contentView addSubview:_wantJoinLabel];
//    
//    _peopleView = [[UIView alloc] init];
//    [self.contentView addSubview:_peopleView];
//    
//    for (int i = 0; i<5; i++)
//    {
//        UIButton *button = [UIButton buttonSystemWithTarget:self action:@selector(peopleCilck:) backgroundColor:nil title:@"" tag:200+i titleColor:TextColor07 selectedTitleColor:nil];
//        button.titleLabel.font = TextSize07Light;
//        [_peopleView addSubview:button];
//    }
    
    _line= [self createDashed];
    //_line.backgroundColor = LineColor02;
    [self.contentView addSubview:_line];
}

-(void)updateCellWithModel:(SNSCalendarActivityModel *)item isLastRow:(BOOL)isLastRow
{
    _wantJoinLabel.hidden = YES;
    _hadSignUpLabel.hidden = YES;
    _peopleView.hidden = YES;
    _peopeleClickView.hidden = YES;
    _line.hidden =NO;
    _titleLabel.frame = CGRectMake(16, 25, ContentWidth, 10);
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:item.title];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    [style setLineSpacing:5.0f];
    [attStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, item.title.length)];
    _titleLabel.attributedText = attStr;
    [_titleLabel sizeToFit];
    
    if (item.isSignUp) {
        _hadSignUpLabel.frame = CGRectMake(16, CGRectGetMaxY(_titleLabel.frame)+8, 44, 14);
        _hadSignUpLabel.hidden = NO;
    }
    
    _wantJoinCountLabel.text = item.wantJoinCount;
    _commentCountLabel.text = item.commentCount;
    //计算收藏人数View的长度
    CGSize wantCountSize = [NSString boundingRectWitText:item.wantJoinCount font:TextSize07Light textSize:CGSizeMake(150, 20)];
    CGSize CommentCountSize = [NSString boundingRectWitText:item.commentCount font:TextSize07Light textSize:CGSizeMake(150, 20)];
    
    _heartIV.frame = CGRectMake(ContentWidth-CommentCountSize.width-wantCountSize.width-((15+4)*2+10),  CGRectGetMaxY(_titleLabel.frame)+8, 15, 15);
    _wantJoinCountLabel.frame =CGRectMake(CGRectGetMaxX(_heartIV.frame)+4 , CGRectGetMaxY(_titleLabel.frame)+8, wantCountSize.width, 15);
    _commentIV.frame= CGRectMake(CGRectGetMaxX(_wantJoinCountLabel.frame)+10 , CGRectGetMaxY(_titleLabel.frame)+8, 15, 15);
    _commentCountLabel.frame = CGRectMake(CGRectGetMaxX(_commentIV.frame)+4 , CGRectGetMaxY(_titleLabel.frame)+8, CommentCountSize.width, 15);
    
    CGFloat lineY = CGRectGetMaxY(_commentCountLabel.frame)+20-OnePxHeight;
    
 
    if (item.wantJoinFriends.length>0)
    {
        _wantJoinLabel.frame = CGRectMake(16, CGRectGetMaxY(_commentCountLabel.frame)+6, 80, 20);
      
       _peopeleClickView.hidden = NO;
        
        NSArray *peopleArray = [item.wantJoinFriends componentsSeparatedByString:@"，"];
        NSArray *userIdArray =[item.userIds componentsSeparatedByString:@","];
        _peopeleClickView.frame = CGRectMake(16, CGRectGetMaxY(_commentCountLabel.frame)+8, ContentWidth, 20);
        [_peopeleClickView updateWithTitle:@"想参加的好友" titleFont:TextSize07Light titleColor:TextColor04 peopleNameArray:peopleArray userIdArray:userIdArray];
        
//        CGFloat nameX = 0;
//        for(int i = 0;i<peopleArray.count;i++)
//        {
//            NSString *name = [peopleArray objectAtIndex:i];
//            UIButton *btn = (UIButton*)[_peopleView viewWithTag:200+i];
//            
//            CGSize nameSize = [NSString boundingRectWitText:name font:TextSize07Light textSize:CGSizeMake(ContentWidth-80, 20)];
//            btn.frame = CGRectMake(nameX ,0 , nameSize.width+15, 20);
//            
//            if (i<peopleArray.count-1)
//            {
//                [btn setTitle:[NSString stringWithFormat:@"%@，",name] forState:UIControlStateNormal];
//            }
//            else
//            {
//                btn.frame = CGRectMake(nameX ,0 , nameSize.width, 20);
//                [btn setTitle:[NSString stringWithFormat:@"%@",name] forState:UIControlStateNormal];
//                _peopleView.frame = CGRectMake(CGRectGetMaxX(_wantJoinLabel.frame), CGRectGetMinY(_wantJoinLabel.frame), ContentWidth-80, 20);
//               
//            }
//            nameX = nameX +nameSize.width+15;
//        }
//
//        
//        
//        
//        
//        
//        
        lineY = CGRectGetMaxY(_peopeleClickView.frame)+18-OnePxHeight;
        
    }
    
    if (isLastRow)
    {
        _line.hidden =YES;
    }
    else
    {
        _line.frame = CGRectMake(16, lineY, ContentWidth, OnePxHeight);
    }
    
    
    
    
}
-(CGFloat)getReuseableCellHeight:(SNSCalendarActivityModel *)item
{
    if (item.cellHeight != 0) {
        //        NSLog(@"重用高度 %f", item.cellHeight);
        return item.cellHeight;
    }
    CGFloat height = [self getCellHeightWithModel:item];
    item.cellHeight = height;
    
    
    return height;
}
-(CGFloat)getCellHeightWithModel:(SNSCalendarActivityModel *)item
{
    CGFloat height = 0;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.numberOfLines = 0;
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:item.title];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    [style setLineSpacing:5.0f];
    [attStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, item.title.length)];
    titleLabel.attributedText = attStr;
    CGSize size =  [titleLabel sizeThatFits:CGSizeMake(ContentWidth, 10)];
    
    height = 25+ size.height ;
    height += 8+15;
    if (item.wantJoinFriends.length>0)
    {
         NSArray *peopleArray = [item.wantJoinFriends componentsSeparatedByString:@"，"];
     CGFloat peopleHeight= [_peopeleClickView getHeightWithTitle:@"想参加的好友" titleFont:TextSize07Light peopleNameArray:peopleArray];
        height += 8+peopleHeight+18;
    }
    else
    {
        height += 20;
    }
    
   
    
    
    return height;
}
-(void)peopleCilck:(UIButton *)btn
{
//    NSLog(@"%ld",(long)btn.tag);
//    if (_peopeleCilck)
//    {
//        _peopeleCilck(btn.tag-200); 
//    }

}
//虚线
-(UIView *)createDashed
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(16, 0, ContentWidth+16, OnePxHeight)];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
//    [shapeLayer setBounds:self.bounds];
//    [shapeLayer setPosition:self.center];
    [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    // 设置虚线颜色为blackColor [shapeLayer setStrokeColor:[[UIColor blackColor] CGColor]];
    [shapeLayer setStrokeColor:[LineColor01 CGColor]];
    // 3.0f设置虚线的宽度(高度)
    [shapeLayer setLineWidth:OnePxHeight];
    [shapeLayer setLineJoin:kCALineJoinRound];
    // 3=线的宽度 1=每条线的间距
    [shapeLayer setLineDashPattern:
    [NSArray arrayWithObjects:[NSNumber numberWithInt:2],[NSNumber numberWithInt:2],nil]];
    // Setup the path
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
//    CGPathAddLineToPoint(path, NULL, 320,89);
    // Setup the path CGMutablePathRef path = CGPathCreateMutable(); // 0,10代表初始坐标的x，y
    // 320,10代表初始坐标的x，y CGPathMoveToPoint(path, NULL, 0, 10);
    CGPathAddLineToPoint(path, NULL, view.frame.size.width,OnePxHeight);
    
    [shapeLayer setPath:path]; 
    CGPathRelease(path);
    
    [view.layer addSublayer:shapeLayer];
    return view;
}
@end
