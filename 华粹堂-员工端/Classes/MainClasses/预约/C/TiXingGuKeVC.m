//
//  TiXingGuKeVC.m
//  华粹堂-员工端
//
//  Created by liqiang on 2016/11/17.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import "TiXingGuKeVC.h"

@interface TiXingGuKeVC ()

@end

@implementation TiXingGuKeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)drawView
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = HEXCOLOR(0xeeeeee);
    [self.view addSubview:scrollView];
    
    UIView *moBanBgv = [[UIView alloc] init];
    moBanBgv.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:moBanBgv];
    
}

@end
