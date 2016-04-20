//
//  CommonToolsDefine.h
//  SobotApp
//
//  Created by 张新耀 on 15/8/25.
//  Copyright © 2015年 com.sobot.chat. All rights reserved.
//


// UTF8 字符串
#define UTF8Data(str) [str dataUsingEncoding:NSUTF8StringEncoding]


// 常用属性
#define ApplicationDelegate                 ((AppDelegate *)[[UIApplication sharedApplication] delegate])
#define iOS7                                ((floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1)? NO:YES)
#define NS_Bundle                           [NSBundle mainBundle]

#define IntToString(x)                      [NSString stringWithFormat:@"%d",x]
#define UserDefaults                        [NSUserDefaults standardUserDefaults]
#define NOTIFICATION_CENTER                 [NSNotificationCenter defaultCenter]
#define NavBarHeight                        (iOS7 ? 64.0 : 44.0)
#define StatusBarHeight                     (iOS7 ? 20.0 : 0.0)
#define ScreenWidth                         [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight                        [[UIScreen mainScreen] bounds].size.height
#define ScreenScale                          (ScreenWidth / 320.f)
#define ViewWidth(v)                        v.frame.size.width
#define ViewHeight(v)                       v.frame.size.height
#define ViewX(v)                            v.frame.origin.x
#define ViewY(v)                            v.frame.origin.y

// 网络状态提醒背景
#define BgRedColor          0xee5958


#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define COLORWithAlpha(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorFromRGBAlpha(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]


// 格式化字符串
#define FormatString(string, args...)       [NSString stringWithFormat:string, args]



// 多语言支持
#define ZCLocalString(key) NSLocalizedStringFromTable(key, @"ZCAppLocalizable", nil)
