//
//  Header.h
//  SNSProject
//
//  Created by 刘志飞 on 15/9/2.
//  Copyright (c) 2015年 思想加. All rights reserved.
//



//RGB颜色
#define Color(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

//屏幕比例
#define Screen_Scale  [UIScreen mainScreen].scale
//屏幕宽度
#define Screen_Width  [UIScreen mainScreen].bounds.size.width
//屏幕高度
#define Screen_Height  [UIScreen mainScreen].bounds.size.height

//1像素的分割线的高度
#define OnePxHeight 1/Screen_Scale
//细体
#define LightFont(s) [UIFont fontWithName:@"Helvetica-Light" size:s]

//金色Color(217,178,115)
#define COLORGOLDEN Color(255,197,67)

#ifdef DEBUG // 处于开发阶段
#define SNSLog(...) NSLog(__VA_ARGS__)
#else // 处于发布阶段
#define SNSLog(...)
#endif


/*=====================设计规范====================================*/
#pragma mark  文字颜色
// 文字颜色
#define TextColor01  Color(30, 30, 30)
#define TextColor03  Color(100, 100, 100)
#define TextColor04  Color(150, 150, 150)
#define TextColor07  Color(89, 116, 159)



#pragma mark  文字大小
//文字大小
#define TextSize01 [UIFont systemFontOfSize:24]
#define TextSize02 [UIFont systemFontOfSize:18]
#define TextSize03 [UIFont systemFontOfSize:17]
#define TextSize04 [UIFont systemFontOfSize:16]
#define TextSize05 [UIFont systemFontOfSize:15]
#define TextSize06 [UIFont systemFontOfSize:14]
#define TextSize07 [UIFont systemFontOfSize:12]
#define TextSize08 [UIFont systemFontOfSize:10]


#define TextSize02Light LightFont(18)
#define TextSize07Light LightFont(12)



#pragma mark  分割线
//分割线
#define LineColor01 Color(220, 220, 220)  //浅深
#define LineColor02 Color(226, 226, 226)  //浅


#pragma mark  背景色
//背景色
#define BackgroundColor01  Color(242, 242, 242)
#define BackgroundColor02  Color(255, 255, 255)




















