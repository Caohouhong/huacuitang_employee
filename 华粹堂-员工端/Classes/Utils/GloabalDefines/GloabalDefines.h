//
//  GloabalDefines.h
//  我的框架
//
//  Created by liqiang on 16/3/24.
//  Copyright © 2016年 Liqiang. All rights reserved.
//

#ifndef GloabalDefines_h
#define GloabalDefines_h

//通知
#define NOTIFICATION_EnterBackground               @"NOTIFICATION_EnterBackground"

//主要单例
#define UserDefaults                        [NSUserDefaults standardUserDefaults]
#define NotificationCenter                  [NSNotificationCenter defaultCenter]
#define SharedApplication                   [UIApplication sharedApplication]
#define APPDELEGATE                         (AppDelegate *)[[UIApplication sharedApplication] delegate]
#define WINDOW                              [[UIApplication sharedApplication].delegate window]

//  大小尺寸
#define ScreenWidth                         [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight                        ([[UIScreen mainScreen] bounds].size.height-64)
#define ScreenHeight2                        ([[UIScreen mainScreen] bounds].size.height)

#define SizeScale(s) ([[UIScreen mainScreen] bounds].size.height > 568 ?  ([[UIScreen mainScreen] bounds].size.height / 568.0 * (s)) : (s * 1.0))

//颜色
#define LQRGBColor(r, g, b, a) [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:a]

//hex颜色
#define HEXCOLOR(c) [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:(c&0xFF)/255.0 alpha:1.0]

//font
#define SYSTEM_FONT_(x)               [UIFont systemFontOfSize:x]
#define SYSTEM_FONT_BOLD_(a)          [UIFont boldSystemFontOfSize:a]

//TS ....
#define GETIMAGE(name) [UIImage imageNamed:[NSString stringWithFormat:@"%@", name]]
#define TFont(size) [UIFont systemFontOfSize:size]
#define WEAK(weakSelf) __weak typeof(self) weakSelf = self;
#define backviewColor   [UIColor colorWithRed:0.94f green:0.94f blue:0.94f alpha:1.00f]  //背景色
#define backviewColor1   [UIColor colorWithRed:0.90f green:0.90f blue:0.90f alpha:1.00f]  //背景色
#define TSTRING_NOT_EMPTY(string)              (string && (string.length > 0))

#define FONT_TEXTSIZE_VerySmall       SYSTEM_FONT_(10)//特小（图标配字）
#define FONT_TEXTSIZE_Small           SYSTEM_FONT_(12)//小号（特别提示，如时间，地点）
#define FONT_TEXTSIZE_Mid             SYSTEM_FONT_(14)//中号（内容区摘要记录、正文、提示）
#define FONT_TEXTSIZE_LargeMid        SYSTEM_FONT_(15)//中号（内容区摘要记录、正文、提示）
#define FONT_TEXTSIZE_Big             SYSTEM_FONT_(16)//大号（内容区标题、人名、模块入口、按钮）
#define FONT_TEXTSIZE_VeryBig         SYSTEM_FONT_(18)//特大号（导航栏Head标题）

#define COLOR_White                   HEXCOLOR(0xffffff)//白(多用于按钮上)
#define COLOR_Black                   HEXCOLOR(0x333333)//黑（标题、正文）
#define COLOR_Gray                    HEXCOLOR(0x999999)//灰（辅助文字）
#define COLOR_darkGray                HEXCOLOR(0x666666)//深灰（提示文字）
#define COLOR_LightGray               HEXCOLOR(0xc7c7cd)//浅灰（输入提示文字）
#define COLOR_Orange                  HEXCOLOR(0xff9900)//橙（金额）
#define COLOR_Red                     HEXCOLOR(0xe54650)//红（提醒文字）
#define COLOR_OrangeRed               HEXCOLOR(0xff5c0b)//橙红
#define COLOR_Green                   HEXCOLOR(0x4eca83)//绿色
#define COLOR_Blue                    HEXCOLOR(0x6586C8)//蓝色
#define COLOR_Text_Blue               HEXCOLOR(0x48bbf9) //字体亮蓝色

#define COLOR_ButtonBackGround_Blue   HEXCOLOR(0x49bafb) //按钮蓝色
#define COLOR_ButtonBackGround_Red    HEXCOLOR(0xec5050)
#define COLOR_ButtonBackGround_Green  HEXCOLOR(0x06bf04)
#define COLOR_ButtonBackGround_White  HEXCOLOR(0xffffff)
#define COLOR_ButtonBackGround_Gray   HEXCOLOR(0xe1e1e1)

#define COLOR_LineViewColor           HEXCOLOR(0xd9d9d9)  //浅灰
#define COLOR_BackgroundColor         HEXCOLOR(0xeeeeee)  //米白
#define NAV_BAR_COLOR                 HEXCOLOR(0x4fbbf6) 

#define COLOR_TEXT_ORANGE_RED        HEXCOLOR(0xff8473) //字体橙红色
#define COLOR_TEXT_GREEN_RED        HEXCOLOR(0x34cdae) //字体青绿色
#define COLOR_BG_DARK_BLUE           HEXCOLOR(0xe3eff7) //背景深蓝
#define COLOR_TEXT_DARK_BLUE         HEXCOLOR(0x2c92c7) //字体深蓝

#define IOS8 ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0 && [[UIDevice currentDevice].systemVersion doubleValue] < 9.0)
#define IOS8_10 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 && [[UIDevice currentDevice].systemVersion doubleValue] < 10.0)
#define IOS10 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)


#define kCell                         @"kCell"
#define kModel                        @"kModel"
#define kTitle                        @"kTitle"
#define kSubTitle                     @"kSubTitle"
#define kKey                          @"kKey"
#define kValue                        @"kValue"
#define kUrl                          @"kUrl"
#define kMethod                       @"kMethod"
#define kParameter                    @"kParameter"
#define kENum                         @"kENum"
#define kType                         @"kType"
#define kArray                        @"kArray"
#define kColor                        @"kColor"
#define kImage                        @"kImage"
#define kRead                         @"kRead"
#define kDateTime                     @"kDateTime"
#define kController                   @"kController"


//版本号(发布新版本时记得更改)
#define VERSION_CODE                  @"V1.0.0"
#define VERSION_BUILD                 @"100"

#endif
