//
//  RetrievePwdVC.m
//  ZhouMo
//
//  Created by liqiang on 16/9/18.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import "RetrievePwdVC.h"

@interface RetrievePwdVC ()<UITextFieldDelegate>

@property (nonatomic, weak) LQTextFieldStyle_1 *miMaTextField;
@property (nonatomic, weak) LQTextFieldStyle_1 *queRenTextField;

@end

@implementation RetrievePwdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"找回密码";
    [self drawView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)drawView
{
    LQTextFieldStyle_1 *miMaTextField = [[LQTextFieldStyle_1 alloc] init];
    miMaTextField.textField.placeholder = @"密码";
    miMaTextField.textField.keyboardType = UIKeyboardTypeNumberPad;
//    miMaTextField.iconImage = [UIImage imageNamed:@"zhuce_mima"];
    miMaTextField.textField.delegate = self;
    miMaTextField.textField.secureTextEntry = YES;
    [self.view addSubview:miMaTextField];
    self.miMaTextField = miMaTextField;
    
    LQTextFieldStyle_1 *queRenTextField = [[LQTextFieldStyle_1 alloc] init];
    queRenTextField.textField.placeholder = @"确认密码";
    queRenTextField.textField.keyboardType = UIKeyboardTypeNumberPad;
//    queRenTextField.iconImage = [UIImage imageNamed:@"zhuce_mima"];
    queRenTextField.textField.delegate = self;
    queRenTextField.textField.secureTextEntry = YES;
    [self.view addSubview:queRenTextField];
    self.queRenTextField = queRenTextField;
    
    UIButton *loginBtn = [[UIButton alloc] init];
    [loginBtn setTitle:@"完  成" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginBtn.backgroundColor = HEXCOLOR(0xe8444c);
    loginBtn.titleLabel.font = FONT_TEXTSIZE_Big;
    [loginBtn addTarget:self action:@selector(doCommit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    miMaTextField.sd_layout
    .leftSpaceToView(self.view,25)
    .topSpaceToView(self.view,30)
    .rightSpaceToView(self.view,25)
    .heightIs(27);
    
    queRenTextField.sd_layout
    .leftEqualToView(miMaTextField)
    .topSpaceToView(miMaTextField,20)
    .rightEqualToView(miMaTextField)
    .heightRatioToView(miMaTextField,1);
    
    loginBtn.sd_layout
    .leftEqualToView(queRenTextField)
    .rightEqualToView(queRenTextField)
    .topSpaceToView(queRenTextField,30)
    .heightIs(45);
    loginBtn.sd_cornerRadius = @(5);
}

- (void)doCommit
{
    if (self.miMaTextField.textField.text.length <6 || self.miMaTextField.textField.text.length >20 )
    {
        [LCProgressHUD showFailure:@"请输入6-20位密码"];
        return;
    }
    
    if (self.queRenTextField.textField.text.length <6 || self.queRenTextField.textField.text.length >20 )
    {
        [LCProgressHUD showFailure:@"请输入6-20位确认密码"];
        return;
    }
    
    if (![self.miMaTextField.textField.text isEqualToString:self.queRenTextField.textField.text])
    {
        [LCProgressHUD showFailure:@"两次密码设置不一致，请重新设置"];
        return;
    }
    
    [LCProgressHUD showFailure:@"网络连接错误"];
//    [self requestChangePwd];
}

#pragma mark -
#pragma mark ================= 网络 =================
- (void)requestChangePwd
{
    NSLog(@"-->%@ ---->%@",self.mobilePhone,self.miMaTextField.textField.text);
    
//    NSString *signStrBefore=[NSString stringWithFormat:@"mobilePhone%@newPassword%@partner1006",self.mobilePhone,self.miMaTextField.textField.text];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:self.mobilePhone forKey:@"mobilePhone"];
    [params setValue:self.miMaTextField.textField.text forKey:@"newPassword"];
//    [params setObject:[MD5Str MD5HexDigest:signStrBefore] forKey:@"sign"];
    
    [[LQHTTPSessionManager sharedManager] LQPost:@"member/resetMemberPwd" parameters:params showTips:@"正在重置..." success:^(id responseObject) {
        
        [LCProgressHUD showSuccess:@"重置密码成功"];
        
        [DCURLRouter popViewControllerWithTimes:2 animated:YES];
        
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
}


#pragma mark -
#pragma mark ================= UITextFieldDelegate =================
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    if ([string isEqualToString:@""])
    {
        return YES;
    }
    
    if ([@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789,<.>/?;:'\"{[}]|\\=+-_)(*&^%$#@!`~" rangeOfString:string].location == NSNotFound)
    {
        return NO;
    }
    
    return YES;
}

@end
