//
//  ChangePasswordViewController.m
//  lingdaozhe
//
//  Created by aliviya on 16/5/24.
//  Copyright © 2016年 bckj. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "UITableViewCell+addLine.h"

@interface ChangePasswordViewController()<UITextFieldDelegate>
@property (nonatomic,retain) UITextField *txtfOrginPassword;

@property (nonatomic,retain) UITextField *txtfNewPassword;
@property (nonatomic,retain) UITextField *txtfNewPasswordAgain;
@end
@implementation ChangePasswordViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.title = @"修改密码";
    
    [self drawView];
    
    
    
}
-(void)drawView{
    UIView *subView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 10, ScreenWidth, 45)];
    subView1.backgroundColor = COLOR_White;
    [self.view addSubview:subView1];
    UITextField *txtfOrginPassword = [UITextField createTextFieldWithFrame:CGRectMake(10, 10, 200, 24) backgroundColor:[UIColor clearColor] borderStyle:UITextBorderStyleNone placeholder:@"请输入原密码" text:nil textColor:COLOR_Black font:FONT_TEXTSIZE_Big textalignment:NSTextAlignmentLeft];
    [subView1 addSubview:txtfOrginPassword];

    [self viewAddUnderLine:subView1];
    
    self.txtfOrginPassword = txtfOrginPassword;
    self.txtfOrginPassword.delegate = self;
    UIView *subView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 10+45, ScreenWidth, 45)];
    [self.view addSubview:subView2];
    subView2.backgroundColor = COLOR_White;
    UITextField *txtfNewPassword = [UITextField createTextFieldWithFrame:CGRectMake(10, 10, 200, 24) backgroundColor:[UIColor clearColor] borderStyle:UITextBorderStyleNone placeholder:@"请输入新密码" text:nil textColor:COLOR_Black font:FONT_TEXTSIZE_Big textalignment:NSTextAlignmentLeft];
    [subView2 addSubview:txtfNewPassword];
    
     [self viewAddUnderLine:subView2];
    self.txtfNewPassword = txtfNewPassword;
    self.txtfNewPassword.delegate = self;
    
    UIView *subView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 10+45*2, ScreenWidth, 45)];
    [self.view addSubview:subView3];
    subView3.backgroundColor = COLOR_White;
    UITextField *txtfNewPasswordAgain = [UITextField createTextFieldWithFrame:CGRectMake(10, 10, 200, 24) backgroundColor:[UIColor clearColor] borderStyle:UITextBorderStyleNone placeholder:@"再次输入新密码" text:nil textColor:COLOR_Black font:FONT_TEXTSIZE_Big textalignment:NSTextAlignmentLeft];
    [subView3 addSubview:txtfNewPasswordAgain];

     [self viewAddUnderLine:subView3];
    self.txtfNewPasswordAgain = txtfNewPasswordAgain;
    self.txtfNewPasswordAgain.delegate = self;
    
    self.txtfOrginPassword.secureTextEntry = YES;
     self.txtfNewPassword.secureTextEntry = YES;
     self.txtfNewPasswordAgain.secureTextEntry = YES;
    
    UIButton *changeBtn = [UIButton createButtonwithFrame:CGRectMake(16, 165, ScreenWidth - 32, SizeScale(44)) backgroundColor: HEXCOLOR(0xe44751) conrnerRadius:5 borderWidth:0 borderColor:nil];
    [changeBtn setTitle:@"修  改" forState:UIControlStateNormal];
    
    [changeBtn addTarget:self action:@selector(changePasswordAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:changeBtn];
    
}

-(void)changePasswordAction:(id)sender
{
    if (!self.txtfOrginPassword.text.length)
    {
        [LCProgressHUD showFailure:@"请输入原密码"];
        self.txtfOrginPassword.text = @"";
        return;
    }
    if (!self.txtfNewPassword.text.length)
    {
        [LCProgressHUD showFailure:@"请输入新密码"];
        self.txtfOrginPassword.text = @"";
        return;
    }
    
    if (![self.txtfNewPassword.text isEqualToString:self.txtfNewPasswordAgain.text]) {
        [LCProgressHUD showFailure:@"您两次输入的密码不相同,请重新输入"];
        self.txtfNewPassword.text = @"";
        self.txtfNewPasswordAgain.text = @"";
        return;
    }
    if (self.txtfNewPassword.text.length <6) {
        [LCProgressHUD showFailure:@"密码格式不对，请重新输入"];
        self.txtfNewPassword.text = @"";
        self.txtfNewPasswordAgain.text = @"";
        return;
    }
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:[ModelMember sharedMemberMySelf].memberId forKey:@"employeeId"];
    [params setValue:self.txtfOrginPassword.text forKey:@"oldPassword"];
    [params setValue:self.txtfNewPassword.text forKey:@"newPassword"];
    
    [[LQHTTPSessionManager sharedManager] LQPost:@"employee/modifyPwd" parameters:params showTips:@"正在修改..." success:^(id responseObject) {
        
        [LCProgressHUD showSuccess:@"重置密码成功"];
        [self.navigationController popViewControllerAnimated:YES];
        
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
}

-(void)viewAddUnderLine:(UIView *)view{
    UIView *lineView = [[UIView alloc] init];

    lineView.backgroundColor = COLOR_LineViewColor;
    [view addSubview:lineView];
    
    lineView.sd_layout
    .leftSpaceToView(view,0)
    .bottomSpaceToView(view,0)
    .rightSpaceToView(view,0)
    .heightIs(0.5);
}

#pragma mark txtfeild 
#pragma mark -UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    //string就是此时输入的那个字符textField就是此时正在输入的那个输入框返回YES就是可以改变输入框的值NO相反
    
 
    
        if ([toBeString length] > 16) { //如果输入框内容大于20则弹出警告
            //            textField.text = [toBeString substringToIndex:32];
            return NO;
        }
    
    return YES;

}

@end
