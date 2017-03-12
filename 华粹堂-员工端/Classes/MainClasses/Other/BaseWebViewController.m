//
//  BaseWebViewController.m
//  华粹堂-员工端
//
//  Created by caohouhong on 17/3/10.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "BaseWebViewController.h"

@interface BaseWebViewController ()<UIWebViewDelegate>
{
    NSString *navigationTitle;
    NSString *requestUrl;
    UIWebView *mWebView;
}
@end

@implementation BaseWebViewController

-(instancetype)initWithTitle:(NSString *)title andUrl:(NSString *)url
{
    self = [super init];
    if (self) {
        navigationTitle = title;
        requestUrl = url;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = navigationTitle;
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = leftBar;
    [self initWebView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initWebView
{
    mWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    mWebView.scalesPageToFit = YES;
    mWebView.delegate = self;
    [mWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:requestUrl]]];
    [self.view addSubview:mWebView];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [LCProgressHUD showLoading:@"正在加载..."];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [LCProgressHUD hide];
}

- (void)back:(id)sender
{
    if ([mWebView canGoBack]) {
        [mWebView goBack];
    }else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}



@end
