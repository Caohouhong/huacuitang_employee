//
//  LQAppFrameTabBarController.m
//  我的框架
//
//  Created by liqiang on 16/3/24.
//  Copyright © 2016年 Liqiang. All rights reserved.
//

#import "LQAppFrameTabBarController.h"

#define kClassKey   @"rootVCClassString"
#define kTitleKey   @"title"
#define kImgKey     @"imageName"
#define kSelImgKey  @"selectedImageName"
#define kSupportPortraitOnly @"supportPortraitOnly"


static LQAppFrameTabBarController *mainTabBar = nil;

@interface LQAppFrameTabBarController ()

@end

@implementation LQAppFrameTabBarController

+ (instancetype)sharedMainTabBar
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mainTabBar = [[LQAppFrameTabBarController alloc] init];
    
    });
    return mainTabBar;
}

+ (instancetype)updataTabBar
{
    mainTabBar = [[LQAppFrameTabBarController alloc] init];
    return mainTabBar;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *childItemsArray = @[
                                 @{kClassKey  : @"MainVC",
                                   kTitleKey  : @"首页",
                                   kImgKey    : @"tab_home",
                                   kSelImgKey : @"tab_home_pre",
                                   kSupportPortraitOnly :[NSNumber numberWithBool:NO]},
                                 
                                 @{kClassKey  : @"RiChengVC",
                                   kTitleKey  : @"日程",
                                   kImgKey    : @"tab_yeji",
                                   kSelImgKey : @"tab_yeji_pre",
                                   kSupportPortraitOnly :[NSNumber numberWithBool:NO]},
                                 
                                 @{kClassKey  : @"GuKeMianListVC",
                                   kTitleKey  : @"顾客",
                                   kImgKey    : @"tab_guke",
                                   kSelImgKey : @"tab_guke_pre",
                                   kSupportPortraitOnly :[NSNumber numberWithBool:NO]},
                                 
                                 @{kClassKey  : @"HuaCuiTangVC",
                                   kTitleKey  : @"华粹堂",
                                   kImgKey    : @"tab_me",
                                   kSelImgKey : @"tab_me_pre",
                                   kSupportPortraitOnly :[NSNumber numberWithBool:NO]}];
    
    __weak typeof(self) weakSelf = self;
    [childItemsArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL *stop) {
        UIViewController *vc = [NSClassFromString(dict[kClassKey]) new];
        vc.title = dict[kTitleKey];
        BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
        UITabBarItem *item = nav.tabBarItem;
        item.title = dict[kTitleKey];
        item.image = [UIImage imageNamed:dict[kImgKey]];
        item.selectedImage = [[UIImage imageNamed:dict[kSelImgKey]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName : HEXCOLOR(0x4fbbf6)} forState:UIControlStateSelected];
        [weakSelf addChildViewController:nav];
//        [nav.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -5)]; 
    }];
     self.selectedIndex = 0;
}

@end
