//
//  PerfectInfoModifySelfIntroduceVC.m
//  lingdaozhe
//
//  Created by liqiang on 16/5/19.
//  Copyright © 2016年 bckj. All rights reserved.
//

#import "PerfectInfoModifySelfIntroduceVC.h"

@interface PerfectInfoModifySelfIntroduceVC ()<UITextViewDelegate>

@property (nonatomic, weak) UITextView *textView;

@end

@implementation PerfectInfoModifySelfIntroduceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = COLOR_BackgroundColor;
    
    self.navigationItem.title = @"个性签名";
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
    rightBarButton.tintColor = COLOR_darkGray;
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    [self drawView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)drawView
{
    UIView *textViewBackgroundView = [[UIView alloc] init];
    textViewBackgroundView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:textViewBackgroundView];
    
    UITextView *textView = [[UITextView alloc] init];
    textView.backgroundColor = [UIColor clearColor];
    textView.font = FONT_TEXTSIZE_Big;
    textView.delegate = self;
    textView.text = [ModelMember sharedMemberMySelf].signature;
    [textViewBackgroundView addSubview:textView];
    self.textView = textView;
    
    textViewBackgroundView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,20)
    .heightIs(180);
    
    textView.sd_layout
    .leftSpaceToView(textViewBackgroundView,10)
    .rightSpaceToView(textViewBackgroundView,10)
    .topSpaceToView(textViewBackgroundView,0)
    .bottomSpaceToView(textViewBackgroundView,0);
}

//<UITouch *>
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing: YES];
}

- (void)save
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:[ModelMember sharedMemberMySelf].memberId forKey:@"employeeId"];
    [params setValue:self.textView.text forKey:@"signature"];
    
    [[LQHTTPSessionManager sharedManager] LQPost:@"employee/modifySignature" parameters:params showTips:@"正在修改..." success:^(id responseObject) {
        [LCProgressHUD showSuccess:@"修改成功"];
        
        ModelMember *member = [ModelMember sharedMemberMySelf];
        member.signature = self.textView.text;
        
        NSMutableDictionary *dic = [[ModelMember sharedMemberMySelf] mj_keyValues];
        [ModelMember doLoginWithMemberDic:dic];
        
        [self.navigationController popViewControllerAnimated:YES];
        
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark -
#pragma mark ================= UITextViewDelegate =================
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSString * toBeString = [textView.text stringByReplacingCharactersInRange:range withString:text]; //得到输入框的内容
    
    
    if ([toBeString length] > 200)
    {
        textView.text = [toBeString substringToIndex:200];
        return NO;
    }
    
    return YES;
}

@end
