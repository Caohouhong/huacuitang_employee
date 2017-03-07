//
//  AppDelegate.m
//  我的框架
//
//  Created by liqiang on 16/7/19.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginVC.h"
#import "HuiFangModel.h"
#import "ModelTrackManage.h"
#import <UserNotifications/UserNotifications.h>
#import "AppDelegate+EaseMob.h"
#import "JPUSHService.h"


// 极光推送
static NSString *appKey = @"b48279826e789eddb6c849e8";
static NSString *channel = @"Publish channel";
static BOOL isProduction = PushIsProduction;

@interface AppDelegate ()<UNUserNotificationCenterDelegate,JPUSHRegisterDelegate,MFMessageComposeViewControllerDelegate,UINavigationControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask,YES);
    NSString *path = [paths objectAtIndex:0];
    NSLog(@"%@",path);
    application.applicationIconBadgeNumber = 0;
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self setUserNotificationWithApplication:application Options:launchOptions];
    [self requsetTiaoLiData];
    [self requsetHuiFangData];
    
    //加载DCURLRouter.plist文件数据
    [DCURLRouter loadConfigDictFromPlist:@"DCURLRouter.plist"];
    
    
    
    NSString *apnsCertName = ApnsCertName;
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *appkey = [ud stringForKey:@"identifier_appkey"];
    if (!appkey) {
        appkey = @"1169161118115378#huacuitang";
        [ud setObject:appkey forKey:@"identifier_appkey"];
    }
    
    [self easemobApplication:application
didFinishLaunchingWithOptions:launchOptions
                      appkey:appkey
                apnsCertName:apnsCertName
                 otherConfig:@{kSDKConfigEnableConsoleLogger:[NSNumber numberWithBool:YES]}];
    
    
    if ([ModelMember isLogin])
    {
        [self loginHuanXing];
        self.window.rootViewController = [LQAppFrameTabBarController updataTabBar];
    }
    else
    {
        self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[LoginVC alloc] init]];
    }
    
    return YES;
}

#pragma mark -
#pragma mark ================= 设置推送 =================
- (void)setUserNotificationWithApplication:(UIApplication *)application Options:(NSDictionary *)launchOptions
{
    if (IOS10) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (!error) {
                NSLog(@"succeeded!");
            }
        }];
    } else if (IOS8_10){//iOS8-iOS10
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound) categories:nil];
        [application registerUserNotificationSettings:settings];
        [application registerForRemoteNotifications];
    } else {//iOS8以下
        [application registerForRemoteNotificationTypes: UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound];
    }
    
    
    
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
        entity.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge|UNAuthorizationOptionSound;
        [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    }
    else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    }
    else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    
    //Required
    // init Push(2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil  )
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    [JPUSHService setupWithOption:launchOptions appKey:appKey
                          channel:channel
                 apsForProduction:isProduction
            advertisingIdentifier:nil];
}

#pragma mark -
#pragma mark ================= 环形登录退出 =================
/**
 环信登录
 */
- (void)loginHuanXing
{
    EMOptions *options = [EMOptions optionsWithAppkey:@"1169161118115378#huacuitang"];
    options.apnsCertName = ApnsCertName;
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    
    [[EMClient sharedClient] loginWithUsername:[ModelMember sharedMemberMySelf].imUserName
                                      password:[ModelMember sharedMemberMySelf].imPasswd
                                    completion:^(NSString *aUsername, EMError *aError) {
                                        if (!aError) {
                                            NSLog(@"登陆成功");
                                        } else {
                                            NSLog(@"登陆失败");
                                            
                                            @weakify(self);
                                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                @strongify(self);
                                                [self loginHuanXing];
                                            });
                                        }
                                    }];
}
/**
 环信登录
 */
- (void)logOutHuanXing
{
    EMOptions *options = [EMOptions optionsWithAppkey:@"1169161118115378#huacuitang"];
    options.apnsCertName = ApnsCertName;
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    
    [[EMClient sharedClient] logout:YES completion:^(EMError *aError) {
        NSLog(@"===>%@",aError);
    }];
}

#pragma mark -
#pragma mark ================= 获取调理、回访数据 =================
- (void)requsetTiaoLiData
{
    NSArray *array = [[DataManage sharedMemberMySelf] getTiaoLiModelArray];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:[ModelMember sharedMemberMySelf].memberId forKey:@"employeeId"];
    [params setValue:@"0" forKey:@"lastModified"];
    
    if (array.count)
    {
        NSDate *date = [NSDate date];
        [params setValue:@((int)[date timeIntervalSince1970]) forKey:@"lastModified"];
    }
    else
    {
        [params setValue:@"0" forKey:@"lastModified"];
    }
    
    [[LQHTTPSessionManager sharedManager]LQPost:@"trackManage/listTrackManages" parameters:params showTips:@"正在加载..." success:^(id responseObject) {
        
        NSArray *arry = [NSMutableArray arrayWithArray:[ModelTrackManage mj_objectArrayWithKeyValuesArray:[responseObject valueForKey:@"data"]]];
        [[DataManage sharedMemberMySelf] saveTiaoLiDataWithModelArray:arry];
        
        
//        [self.tableView reloadData];
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)requsetHuiFangData
{
    NSArray *array = [[DataManage sharedMemberMySelf] getHuiFangModelArray];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:[ModelMember sharedMemberMySelf].memberId forKey:@"employeeId"];
    [params setValue:@(0) forKey:@"lastModified"];
    
    if (array.count)
    {
        NSDate *date = [NSDate date];
        [params setValue:@((int)[date timeIntervalSince1970]) forKey:@"lastModified"];
    }
    else
    {
        [params setValue:@"0" forKey:@"lastModified"];
    }
    
    [[LQHTTPSessionManager sharedManager]LQPost:@"telephonevisit/listTelephonevisits" parameters:params showTips:@"正在加载..." success:^(id responseObject) {
        
        NSArray *arry = [NSMutableArray arrayWithArray:[HuiFangModel mj_objectArrayWithKeyValuesArray:[responseObject valueForKey:@"data"]]];
        
        [[DataManage sharedMemberMySelf] saveHuiFangDataWithModelArray:arry];
        
//        [self.tableView reloadData];
        
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
}


#pragma mark -
#pragma mark ================= 获取版本更新 =================
- (void)requestGetVersionInfo
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@(VersionInfoId) forKey:@"versionInfoId"];
    
    [[LQHTTPSessionManager sharedManager] LQPost:@"version/getVersionInfo" parameters:params showTips:@"" success:^(id responseObject) {
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        
        if ([app_Version doubleValue] < [[responseObject valueForKey:@"apkVersion"] doubleValue])
        {
            if ([[responseObject valueForKey:@"isForce"] boolValue])
            {
                [UIAlertView showAlertViewWithTitle:@"更新" message:[responseObject valueForKey:@"updateTips"] cancelButtonTitle:@"确定" otherButtonTitles:@[] onDismiss:^(int buttonIndex) {
                    
                } onCancel:^{
                    
                    [[UIApplication sharedApplication ] openURL:[NSURL URLWithString:[responseObject valueForKey:@"downLoadPath"]]];
                }];
            }else{
                [UIAlertView showAlertViewWithTitle:@"更新" message:[responseObject valueForKey:@"updateTips"] cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] onDismiss:^(int buttonIndex) {
                    
                    [[UIApplication sharedApplication ] openURL:[NSURL URLWithString:[responseObject valueForKey:@"downLoadPath"]]];
                } onCancel:^{
                    
                }];
            }
        }
        
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark -
#pragma mark ================= 上传设备号 =================
- (void)shangChuanSheBeiHao:(NSString *)sheBeiHao
{
    if (!sheBeiHao.length)
    {
        return;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"2" forKey:@"deviceType"];
    [params setValue:sheBeiHao forKey:@"deviceId"];
    [params setValue:@"1" forKey:@"receiverType"];
    
    if ([ModelMember isLogin]) {
        [params setValue:[ModelMember sharedMemberMySelf].memberId forKey:@"receiverId"];
        
    }else{
        return;
    }
    
    
    [[LQHTTPSessionManager sharedManager] LQPost:@"message/setMessageDeviceInfo" parameters:params showTips:@"" success:^(id responseObject) {
        
        
        
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark -
#pragma mark ================= 消息推送 =================
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    NSLog(@"收到消息%@",userInfo);
}

#pragma mark -
#pragma mark ================= 发送短信 =================
- (void)sendMessageWithPhone:(NSString *)phone
{
    /** 如果可以发送文本消息(不在模拟器情况下*/
    if ([MFMessageComposeViewController canSendText]) {
        /** 创建短信界面(控制器*/
        MFMessageComposeViewController *controller = [MFMessageComposeViewController new];
        controller.recipients = @[phone];//短信接受者为一个NSArray数组
        controller.body = @"";//短信内容
        controller.messageComposeDelegate = self;
        [DCURLRouter presentViewController:controller animated:YES completion:nil];
    }else{
        NSLog(@"模拟器不支持发送短信");
    }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    [DCURLRouter dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark ==================================
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    //发送通知 进入后台
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_EnterBackground object:nil];
    [[EMClient sharedClient] applicationDidEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [[EMClient sharedClient] applicationWillEnterForeground:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    
    //发送通知 进入后台

      [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_EnterBackground object:nil];
}



@end
