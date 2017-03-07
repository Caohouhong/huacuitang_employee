//
//  MainBaseViewController.m
//  lingdaozhe
//
//  Created by liqiang on 16/5/5.
//  Copyright © 2016年 bckj. All rights reserved.
//

#import "MainBaseViewController.h"
#import "LCProgressHUD.h"

@interface MainBaseViewController ()

@end

@implementation MainBaseViewController

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.automaticallyAdjustsScrollViewInsets = NO;
    self.tabBarController.automaticallyAdjustsScrollViewInsets = NO;
    
    self.supportPortraitOnly = YES;
//    self.hidesBottomBarWhenPushed = YES; //隐藏tabbar
    self.automaticallyAdjustsScrollViewInsets = NO; // 自动下移关闭
    
    self.view.backgroundColor = HEXCOLOR(0xfafaf8);
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.NavLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, ScreenWidth, 0.5)];
    self.NavLineView.backgroundColor = COLOR_LineViewColor;
    [self.navigationController.navigationBar addSubview:self.NavLineView];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    self.navigationController.navigationBarHidden=NO;
    [self.navigationController.navigationBar setTranslucent:NO];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];

    self.navigationController.navigationBar.barTintColor = NAV_BAR_COLOR;
    self.navigationController.navigationBar.tintColor = COLOR_darkGray;
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:COLOR_Black,NSForegroundColorAttributeName,[UIFont fontWithName:@"HelveticaNeue-Bold" size:18],NSFontAttributeName,nil]];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    

}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}
//-(void)showHasNoUserTips{
//    
//    [LCProgressHUD showFailure:HAS_NO_USER];
////    [MBProgressHUD showErrorHUDAddedToView:self.view errorStr:HAS_NO_USER animated:YES showTime:TIPS_DELAY_TIME_NORMAL];
////    
//}
//
//-(void)showFailedTips:(NSString *)failedTips{
//    [LCProgressHUD showFailure:failedTips];
////    [MBProgressHUD showErrorHUDAddedToView:self.view errorStr:failedTips animated:YES showTime:TIPS_DELAY_TIME_NORMAL];
//}
//
//-(void)showSuccessTips:(NSString *)successTips{
//    [LCProgressHUD showSuccess:successTips];
////    [MBProgressHUD showSuccsessHUDAddedToView:self.view successStr:successTips animated:YES showTime:TIPS_DELAY_TIME_NORMAL];
//}

@end
