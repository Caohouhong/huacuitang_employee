//
//  Config.h
//  YouChengTire
//
//  Created by WangZhipeng on 15/12/9.
//  Copyright © 2015年 WangZhipeng. All rights reserved.
//

#ifndef Config_h
#define Config_h


//#define IP                         @"http://115.28.148.32/App" //外网测试


//#define IP                         @"http://192.168.1.167:8080/zmapiprj"

#define IP                         @"http://luwl.s1.natapp.cc" //个人调试

//#define SERVER_URL                 [NSString stringWithFormat:@"%@%@",IP,@"/zmapiprj/webService/"]
#define SERVER_URL                 [NSString stringWithFormat:@"%@%@",IP,@"/webService/"]
#define VIDEO_DOWNLOAD_BASEURL     @"http://ldzpic.oss-cn-hangzhou.aliyuncs.com/ldzaudio"
#define IMAGES_OSS_PIC             @"http://hctpic.oss-cn-qingdao.aliyuncs.com/file_img"
#define VIDEO_DOWNLOAD_URL(urlStr) [NSString stringWithFormat:@"%@%@",VIDEO_DOWNLOAD_BASEURL,urlStr]
#define IMAGE_URL(urlStr)          [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGES_OSS_PIC,urlStr]]
#define DELEGATE_URL               @"http://www.zhoumopark.com:8788/index.html"
#define Ticket_URL                 @"http://www.zhoumopark.com:8788/ticket.html"//优惠券说明

#define ApnsCertName @"yuangongduan_Dev"
#define PushIsProduction           0
//#define ApnsCertName @"yuangongduan_Dis"
//#define PushIsProduction           1

/**
 *  1表示fir 2表示appstore
 */
#define VersionInfoId 2

//微博
#define APPKEY_WEIBO               @"1047094253"
#define APPSECRET_WEIBO            @"b37b5ceb3ddbf46e87c783e744145442"

//微信
#define APPKEY_WECHAT              @"wxb42e236277b4f786"
#define APPSECRET_WECHAT           @"616d25ff6248378e8d47a94a60553c2c"
//#define WECHAT_ZF_SHOPID           @"1368609102"
//#define WECHAT_ZF_Key              @"4F78E411642BAF6EEBA74AC2972C6A98"

//微信支付回调
#define WeiXinCallBack             @"http://114.55.129.93:8788/ldzprj/wxpayCourseSuccess.action";
//支付宝支付回调
#define AliPayCallBack             @"http://114.55.129.93:8788/ldzprj/alipayCourseSuccess.action";

#endif /* Config_h */
