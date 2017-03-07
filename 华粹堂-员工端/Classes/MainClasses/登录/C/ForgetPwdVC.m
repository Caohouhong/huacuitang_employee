//
//  ForgetPwdVC.m
//  ZhouMo
//
//  Created by liqiang on 16/9/18.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import "ForgetPwdVC.h"
#import "JXTimeButton.h"
#import "RetrievePwdVC.h"

@interface ForgetPwdVC ()<UITextFieldDelegate>

@property (nonatomic, weak) LQTextFieldStyle_1 *shouJiHaoTextField;
@property (nonatomic, weak) LQTextFieldStyle_1 *yanZhengMaTextField;
@property (nonatomic, weak) JXTimeButton * timeBtn;
@property (nonatomic, copy) NSString *yanZhengMaStr;
@property (nonatomic, copy) NSString *yanZhengTelNum;

@end

@implementation ForgetPwdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"忘记密码";
    [self drawView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)drawView
{
    LQTextFieldStyle_1 *shouJiHaoTextField = [[LQTextFieldStyle_1 alloc] init];
    shouJiHaoTextField.textField.placeholder = @"手机号";
    shouJiHaoTextField.textField.keyboardType = UIKeyboardTypeNumberPad;
    shouJiHaoTextField.leftLabel.text = @"手机号";
    shouJiHaoTextField.textField.delegate = self;
    [self.view addSubview:shouJiHaoTextField];
    self.shouJiHaoTextField = shouJiHaoTextField;
    
    LQTextFieldStyle_1 *yanZhengMaTextField = [[LQTextFieldStyle_1 alloc] init];
    yanZhengMaTextField.textField.placeholder = @"验证码";
    yanZhengMaTextField.textField.keyboardType = UIKeyboardTypeNumberPad;
    yanZhengMaTextField.leftLabel.text = @"验证码";
    yanZhengMaTextField.textField.delegate = self;
    [self.view addSubview:yanZhengMaTextField];
    self.yanZhengMaTextField = yanZhengMaTextField;
    
//    @weakify(self);
    __weak typeof(self) weakSelf = self;
    JXTimeButton * timeBtn = [[JXTimeButton alloc] initWithFrame:CGRectMake(0, 0, 90, 20) AndBeforeTitle:@"发送验证码" AndWorkingMarkStr:@"s后可重发" AndTimeSum:60 AndTimeButtonStar:^{
//        @strongify(self);
        
        NSLog(@"STAR");
        [weakSelf requestGetCode];
    } AndTimeButtonStop:^{
        NSLog(@"STOP");
        weakSelf.timeBtn.beforeString = @"重新发送";
    }];
    timeBtn.textColor = [UIColor whiteColor];
    timeBtn.center = self.view.center;
    timeBtn.font = [UIFont systemFontOfSize:14];
    timeBtn.textAlignment = 1;
    timeBtn.backgroundColor = HEXCOLOR(0xe8444c);
    [self.view addSubview:timeBtn];
    self.timeBtn = timeBtn;
    
    UIButton *loginBtn = [[UIButton alloc] init];
    [loginBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginBtn.backgroundColor = HEXCOLOR(0xe8444c);
    loginBtn.titleLabel.font = FONT_TEXTSIZE_Big;
    [loginBtn addTarget:self action:@selector(doCommit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    shouJiHaoTextField.sd_layout
    .leftSpaceToView(self.view,25)
    .topSpaceToView(self.view,30)
    .rightSpaceToView(self.view,25)
    .heightIs(27);
    
    timeBtn.sd_layout
    .topSpaceToView(shouJiHaoTextField,10)
    .rightEqualToView(shouJiHaoTextField)
    .widthIs(90)
    .heightIs(37);
    
    yanZhengMaTextField.sd_layout
    .leftEqualToView(shouJiHaoTextField)
    .topSpaceToView(shouJiHaoTextField,20)
    .rightSpaceToView(timeBtn,15)
    .heightRatioToView(shouJiHaoTextField,1);
    
    loginBtn.sd_layout
    .leftEqualToView(yanZhengMaTextField)
    .rightEqualToView(shouJiHaoTextField)
    .topSpaceToView(yanZhengMaTextField,30)
    .heightIs(45);
    loginBtn.sd_cornerRadius = @(5);

}

- (void)doCommit
{
    [self.view endEditing:YES];
    
    if (self.shouJiHaoTextField.textField.text.length != 11)
    {
        [LCProgressHUD showFailure:@"请输入正确的手机号码"];
        return;
    }
    
    if (self.yanZhengMaTextField.textField.text.length > 6 || self.yanZhengMaTextField.textField.text.length < 3)
    {
        [LCProgressHUD showFailure:@"验证码错误，请重新验证"];
        return;
    }
    
    if (self.yanZhengMaStr.length == 0)
    {
        [LCProgressHUD showFailure:@"请获取验证码"];
        return;
    }
    
    if (![self.yanZhengTelNum isEqualToString:self.shouJiHaoTextField.textField.text])
    {
        [LCProgressHUD showFailure:@"请重新获取验证码"];
        return;
    }
    
    if (![self.yanZhengMaStr isEqualToString:[MD5Str md5HexDigest:self.yanZhengMaTextField.textField.text]])
    {
        [LCProgressHUD showFailure:@"请输入正确的验证码"];
        return;
    }
    
    RetrievePwdVC *vc = [[RetrievePwdVC alloc] init];
    vc.mobilePhone = self.shouJiHaoTextField.textField.text;
    [DCURLRouter pushViewController:vc animated:YES];
}

#pragma mark -
#pragma mark ================= 网络 =================
- (void)requestGetCode
{
    [self.view endEditing:YES];
    
    if (self.shouJiHaoTextField.textField.text.length != 11)
    {
        [LCProgressHUD showFailure:@"请输入正确的手机号码"];
        [self.timeBtn stop];
        return;
    }
    self.yanZhengTelNum = self.shouJiHaoTextField.textField.text;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:self.shouJiHaoTextField.textField.text forKey:@"mobilePhone"];
    [params setValue:@"3" forKey:@"operation"]; //1：注册 2：修改手机号  3：找回密码 或 设置支付密码
    [params setValue:@"1" forKey:@"codeType"]; //1-短信形式   2-语音形式
    
    [[LQHTTPSessionManager sharedManager] LQPost:@"member/sendAuthCode" parameters:params showTips:@"" success:^(id responseObject) {
        
        self.yanZhengMaStr = responseObject;
        
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
    
    if (textField == self.shouJiHaoTextField.textField || textField == self.yanZhengMaTextField.textField)
    {
        if ([@"1234567890" rangeOfString:string].location == NSNotFound)
        {
            return NO;
        }
    }
    
    return YES;
}

@end
