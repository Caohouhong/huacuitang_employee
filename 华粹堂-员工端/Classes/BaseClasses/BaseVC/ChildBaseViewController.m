//
//  ChildBaseViewController.m
//  lingdaozhe
//
//  Created by liqiang on 16/5/5.
//  Copyright © 2016年 bckj. All rights reserved.
//

#import "ChildBaseViewController.h"


@interface ChildBaseViewController ()

@end

@implementation ChildBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    self.navigationItem.leftBarButtonItems = [self backBtnItems];
//    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
}


//返回按钮组
- (NSArray *)backBtnItems
{
    UIBarButtonItem *backBtn = [self backButtonItem];
    
    UIBarButtonItem *navigationSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    navigationSpacer.width = -90;
    
    return @[backBtn];
}

//左边返回按钮
-(UIBarButtonItem *)backButtonItem
{
    UIButton * button = [ UIButton buttonWithType : UIButtonTypeCustom ];
    [button setImage :[ UIImage imageNamed : @"nav_back" ] forState : UIControlStateNormal ];
    [button setFrame : CGRectMake ( 0 , 0 , 40 , 40 )];
    [button  setImageEdgeInsets : UIEdgeInsetsMake ( 0 , - 30 , 0 , 0 )];
    [button addTarget : self action :@selector(back) forControlEvents : UIControlEventTouchUpInside ];
    self.navBackButton = button;
    
    UIBarButtonItem * item = [[ UIBarButtonItem alloc ] initWithCustomView :button] ;
    return item;
    
    //    return [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
