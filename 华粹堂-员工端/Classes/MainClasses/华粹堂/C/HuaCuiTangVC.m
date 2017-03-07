//
//  HuaCuiTangVC.m
//  华粹堂-员工端
//
//  Created by liqiang on 2016/11/28.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import "HuaCuiTangVC.h"

@interface HuaCuiTangVC ()

@end

@implementation HuaCuiTangVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self drawView];

     
//     self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"sousuo" target:self action:@selector(sava)];
}

-(void)sava
{
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)drawView
{
    UIWebView *webView = [[UIWebView alloc] init];
    [self.view addSubview:webView];
    
    webView.sd_layout
    .leftSpaceToView(self.view,0)
    .topSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0);
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://139.129.218.121:8081/CZ/applogin/knowledgeBase"]];
    [webView loadRequest:request];
}

@end
