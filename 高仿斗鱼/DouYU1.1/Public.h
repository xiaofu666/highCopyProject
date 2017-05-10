//
//  Public.h
//  玉石記
//
//  Created by Alesary on 15/9/21.
//  Copyright (c) 2015年 Alesary. All rights reserved.
//

#ifndef ____Public_h
#define ____Public_h


//相对iphone6 屏幕比
#define KWidth_Scale    [UIScreen mainScreen].bounds.size.width/375.0f

#define TabBar_T_Color RGB(244, 89, 27)

//RGB
#define RGBA(r, g, b, a)    [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r, g, b)     RGBA(r, g, b, 1.0f)

//系统版本
#define SYSTEM_VERSION   [[UIDevice currentDevice].systemVersion floatValue]

//设备物理尺寸
#define screen_width [UIScreen mainScreen].bounds.size.width
#define screen_height [UIScreen mainScreen].bounds.size.height

//数据库表名


#define Document_Path  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]

#endif
