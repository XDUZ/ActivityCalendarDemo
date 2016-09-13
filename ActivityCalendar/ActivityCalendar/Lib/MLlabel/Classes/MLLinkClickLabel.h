//
//  MLLinkClickLabel.h
//  SNSProject
//
//  Created by liu on 16/3/22.
//  Copyright © 2016年 思想加. All rights reserved.
//

#import "MLLinkLabel.h"

@protocol MLLinkClickLabelDelegate <NSObject>
@optional

-(void) onClickOutsideLink:(NSString *) uniqueId;
-(void) onLongPress;

@end

@interface MLLinkClickLabel : MLLinkLabel

@property (nonatomic, assign) id<MLLinkClickLabelDelegate> clickDelegate;

@property (nonatomic, strong) NSString  *uniqueId;
@end
