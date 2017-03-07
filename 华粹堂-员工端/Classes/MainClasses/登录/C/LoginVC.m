//
//  LoginVC.m
//  ZhouMo
//
//  Created by liqiang on 16/9/14.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import "LoginVC.h"
#import "AppDelegate.h"
#import "JPUSHService.h"

@interface LoginVC ()<UITextFieldDelegate>

@property (nonatomic, weak) LQTextFieldStyle_1 *nameTextField;
@property (nonatomic, weak) LQTextFieldStyle_1 *pwdTextField;
@property (nonatomic, weak) UIButton *loginBtn;
@property (nonatomic, weak) UIButton *forgetPwdBtn;

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = HEXCOLOR(0xeeeeee);
    
    [self drawView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}

- (void)drawView
{
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont boldSystemFontOfSize:40];
    label.textColor = HEXCOLOR(0x999999);
    label.text = @"华粹堂";
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.font = [UIFont boldSystemFontOfSize:35];
    label2.textColor = HEXCOLOR(0x999999);
    label2.text = @"员工入口";
    label2.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label2];
    
    
    LQTextFieldStyle_1 *nameTextField = [[LQTextFieldStyle_1 alloc] init];
    nameTextField.textField.placeholder = @"请输入手机号";
    nameTextField.textField.keyboardType = UIKeyboardTypeNumberPad;
    nameTextField.leftLabel.text = @"手机号";
    nameTextField.textField.delegate = self;
    [self.view addSubview:nameTextField];
    self.nameTextField = nameTextField;
    
    LQTextFieldStyle_1 *pwdTextField = [[LQTextFieldStyle_1 alloc] init];
    pwdTextField.textField.placeholder = @"请输入密码";
    pwdTextField.textField.keyboardType = UIKeyboardTypeASCIICapable;
    pwdTextField.leftLabel.text = @"密  码";
    pwdTextField.textField.secureTextEntry = YES;
    pwdTextField.textField.delegate = self;
    [self.view addSubview:pwdTextField];
    self.pwdTextField = pwdTextField;
    
    UIButton *loginBtn = [[UIButton alloc] init];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginBtn.backgroundColor = HEXCOLOR(0xe8444c);
    loginBtn.titleLabel.font = FONT_TEXTSIZE_Big;
    [loginBtn addTarget:self action:@selector(doLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    self.loginBtn = loginBtn;
    
    UIButton *forgetPwdBtn = [[UIButton alloc] init];
    [forgetPwdBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [forgetPwdBtn setTitleColor:HEXCOLOR(0x999999) forState:UIControlStateNormal];
    forgetPwdBtn.titleLabel.font = FONT_TEXTSIZE_Mid;
    [forgetPwdBtn addTarget:self action:@selector(doForgetPwd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetPwdBtn];
    self.forgetPwdBtn = forgetPwdBtn;
    
    UIButton *closeBtn = [[UIButton alloc] init];
    [closeBtn setImage:[UIImage imageNamed:@"ic_exit"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(doClose) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
    
    label.sd_layout
    .topSpaceToView(self.view,100)
    .centerXEqualToView(self.view)
    .widthIs(200)
    .heightIs(50);
    
    label2.sd_layout
    .topSpaceToView(label,5)
    .centerXEqualToView(self.view)
    .widthIs(200)
    .heightIs(40);
    
    nameTextField.sd_layout
    .leftSpaceToView(self.view,25)
    .topSpaceToView(label2,20)
    .rightSpaceToView(self.view,25)
    .heightIs(27);
    
    pwdTextField.sd_layout
    .leftEqualToView(nameTextField)
    .topSpaceToView(nameTextField,20)
    .heightRatioToView(nameTextField,1)
    .rightEqualToView(nameTextField);

    loginBtn.sd_layout
    .leftEqualToView(nameTextField)
    .rightEqualToView(nameTextField)
    .topSpaceToView(pwdTextField,20)
    .heightIs(45);
    loginBtn.sd_cornerRadius = @(5);
    
    forgetPwdBtn.sd_layout
    .rightEqualToView(pwdTextField)
    .topSpaceToView(loginBtn,10)
    .widthIs(75)
    .heightIs(20);
    
    closeBtn.sd_layout
    .rightSpaceToView(self.view,15)
    .topSpaceToView(self.view,35)
    .widthIs(30)
    .heightIs(30);
}

- (void)doLogin
{
    [self.view endEditing:YES];
    
//    WINDOW.rootViewController = [LQAppFrameTabBarController updataTabBar];
    
    if (self.nameTextField.textField.text.length != 11)
    {
        [LCProgressHUD showFailure:@"请输入正确的手机号码"];
        return;
    }
    
    if (self.pwdTextField.textField.text.length <6 || self.pwdTextField.textField.text.length >20 )
    {
        [LCProgressHUD showFailure:@"请输入6-20位密码"];
        return;
    }
    
    [self requestLogin];
}

- (void)doZhuCe
{
    [DCURLRouter pushURLString:@"dariel://ZhuCeVC" animated:YES];
}

- (void)doForgetPwd
{
    [DCURLRouter pushURLString:@"dariel://ForgetPwdVC" animated:YES];
}

- (void)doKaiTongSiMiao
{

}

- (void)doClose
{

}

#pragma mark -
#pragma mark ================= 网络 =================
- (void)requestLogin
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:self.nameTextField.textField.text forKey:@"loginName"];
    [params setValue:self.pwdTextField.textField.text forKey:@"password"];

    [[LQHTTPSessionManager sharedManager] LQPost:@"employee/login" parameters:params showTips:@"正在登录..." success:^(id responseObject) {
        
        ModelMember *member = [ModelMember sharedMemberMySelf];
        member = [ModelMember mj_objectWithKeyValues:responseObject];
        
        [ModelMember doLoginWithMemberDic:[member mj_keyValues]];
        
        AppDelegate *del = APPDELEGATE;
        
        [del requsetTiaoLiData];
        [del requsetHuiFangData];
        
        WINDOW.rootViewController = [LQAppFrameTabBarController updataTabBar];
        [LCProgressHUD showSuccess:@"登录成功"];
        
        [del loginHuanXing];
        
        NSString *deviceToken = [UserDefaults valueForKey:@"deviceToken"];
        [del shangChuanSheBeiHao:deviceToken];
        [JPUSHService setAlias:deviceToken callbackSelector:nil object:nil];
        
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
    
    if (textField == self.nameTextField.textField)
    {
        if ([@"1234567890" rangeOfString:string].location == NSNotFound)
        {
            return NO;
        }
    }
    
    if (textField == self.pwdTextField.textField)
    {
        if ([@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789,<.>/?;:'\"{[}]|\\=+-_)(*&^%$#@!`~" rangeOfString:string].location == NSNotFound)
        {
            return NO;
        }
    }
    
    return YES;
}

@end
