//
//  UserAgreementVCtr.m
//  WaterMan
//
//  Created by 陈梦悦 on 15-11-4.
//  Copyright (c) 2015年 baichun. All rights reserved.
//

#import "UserAgreementVCtr.h"

@interface UserAgreementVCtr ()

@property(nonatomic,strong)UIWebView *agreeWebView;

@end

@implementation UserAgreementVCtr
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"用户协议";
    
//    [self setTitle:@"用户协议" isShowEars:NO];
    
    _agreeWebView=[[UIWebView alloc]initWithFrame:CGRectMake(SizeScale(0), SizeScale(0), ScreenWidth, ScreenHeight)];
    [self.view addSubview:_agreeWebView];
//    NSError *error;
//    NSString *string =[NSString stringWithContentsOfFile:[[NSBundle mainBundle]
//                                                          pathForResource:@"Agree"
//                                                          ofType:@"html"]
//                                                encoding:NSUTF8StringEncoding
//                                                   error:&error];
//    [_agreeWebView loadHTMLString:@"" baseURL:nil];
    [_agreeWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:DELEGATE_URL]]];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
