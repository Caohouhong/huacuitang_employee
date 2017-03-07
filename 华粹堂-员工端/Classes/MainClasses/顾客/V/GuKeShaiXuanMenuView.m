//
//  GuKeShaiXuanMenuView.m
//  华粹堂-员工端
//
//  Created by liqiang on 2016/11/28.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import "GuKeShaiXuanMenuView.h"
#import "SUPopupMenu.h"

@interface GuKeShaiXuanMenuView()<SUDropMenuDelegate,UITextFieldDelegate>
//required

@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIView *showView;

@property (nonatomic, weak) UIButton *mengDianKeHuBtn;
@property (nonatomic, weak) UIButton *benRenKeHuBtn;

@property (nonatomic, weak) UIButton *A_Btn;
@property (nonatomic, weak) UIButton *B_Btn;
@property (nonatomic, weak) UIButton *C_Btn;
@property (nonatomic, weak) UIButton *D_Btn;

@property (nonatomic, weak) UITextField *xiaoFeiQuJianTextfield1;
@property (nonatomic, weak) UITextField *xiaoFeiQuJianTextfield2;


@end

@implementation GuKeShaiXuanMenuView

NSInteger menuViewWith2 = 200;

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        menuViewWith2 = ScreenWidth - 25;
        self.libieId = @"264";
        self.employeeId = @"";
        self.shopId = [ModelMember sharedMemberMySelf].s_id;
        
        [self drawView];
        
        [self didClickMengDianKeHuBtn:self.benRenKeHuBtn];
    }
    
    return self;
}

- (void)drawView
{
    self.isRightViewHidden = YES;
    
    _maskView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _maskView.backgroundColor = [UIColor blackColor];
    _maskView.alpha = 0;
    [self addSubview:_maskView];
    
    _maskView.sd_layout
    .leftSpaceToView(self,0)
    .topSpaceToView(self,0)
    .bottomSpaceToView(self,0)
    .rightSpaceToView(self,0);
    
    UIView *showView = [[UIView alloc] init];
    showView.backgroundColor = [UIColor whiteColor];
    [self addSubview:showView];
    self.showView = showView;
    
    showView.sd_layout
    .rightSpaceToView(self,0)
    .topSpaceToView(self,0)
    .bottomSpaceToView(self,0)
    .widthIs(menuViewWith2);
    
    [self addRecognizer];
    [self drawShowView];
}

- (void)drawShowView
{
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.showView.width, 64)];
    navView.backgroundColor = HEXCOLOR(0x4fbbf6);
    [self.showView addSubview:navView];
    
    UILabel *navTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, navView.width, 44)];
    navTitleLabel.font = [UIFont systemFontOfSize:16];
    navTitleLabel.textColor = HEXCOLOR(0x333333);
    navTitleLabel.text = @"筛选";
    navTitleLabel.textAlignment = NSTextAlignmentCenter;
    [navView addSubview:navTitleLabel];
    
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.font = [UIFont systemFontOfSize:14];
    label1.textColor = HEXCOLOR(0x333333);
    label1.text = @"客户等级";
    [self.showView addSubview:label1];
    
    UIView *dengJiBGV = [[UIView alloc] init];
    dengJiBGV.backgroundColor = HEXCOLOR(0xf7f7f7);
    [self.showView addSubview:dengJiBGV];
    
    UIButton *A_Btn = [[UIButton alloc] init];
    [A_Btn setTitle:@"  A" forState:UIControlStateNormal];
    [A_Btn setTitleColor:HEXCOLOR(0x333333) forState:UIControlStateNormal];
    [A_Btn setImage:[UIImage imageNamed:@"icon_unselected"] forState:UIControlStateNormal];
    [A_Btn setImage:[UIImage imageNamed:@"icon_selected"] forState:UIControlStateSelected];
    A_Btn.titleLabel.font = [UIFont systemFontOfSize:14];
    A_Btn.backgroundColor = [UIColor clearColor];
    [A_Btn addTarget:self action:@selector(didClickKeHuLevel:) forControlEvents:UIControlEventTouchUpInside];
    A_Btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    A_Btn.selected = YES;
    [dengJiBGV addSubview:A_Btn];
    self.A_Btn = A_Btn;
    
    UIButton *B_Btn = [[UIButton alloc] init];
    [B_Btn setTitle:@"  AA" forState:UIControlStateNormal];
    [B_Btn setTitleColor:HEXCOLOR(0x333333) forState:UIControlStateNormal];
    [B_Btn setImage:[UIImage imageNamed:@"icon_unselected"] forState:UIControlStateNormal];
    [B_Btn setImage:[UIImage imageNamed:@"icon_selected"] forState:UIControlStateSelected];
    B_Btn.titleLabel.font = [UIFont systemFontOfSize:14];
    B_Btn.backgroundColor = [UIColor clearColor];
    [B_Btn addTarget:self action:@selector(didClickKeHuLevel:) forControlEvents:UIControlEventTouchUpInside];
    B_Btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [dengJiBGV addSubview:B_Btn];
    self.B_Btn = B_Btn;
    
    UIButton *C_Btn = [[UIButton alloc] init];
    [C_Btn setTitle:@"  AAA" forState:UIControlStateNormal];
    [C_Btn setTitleColor:HEXCOLOR(0x333333) forState:UIControlStateNormal];
    [C_Btn setImage:[UIImage imageNamed:@"icon_unselected"] forState:UIControlStateNormal];
    [C_Btn setImage:[UIImage imageNamed:@"icon_selected"] forState:UIControlStateSelected];
    C_Btn.titleLabel.font = [UIFont systemFontOfSize:14];
    C_Btn.backgroundColor = [UIColor clearColor];
    [C_Btn addTarget:self action:@selector(didClickKeHuLevel:) forControlEvents:UIControlEventTouchUpInside];
    C_Btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [dengJiBGV addSubview:C_Btn];
    self.C_Btn = C_Btn;
    
    UIButton *D_Btn = [[UIButton alloc] init];
    [D_Btn setTitle:@"  AAAA" forState:UIControlStateNormal];
    [D_Btn setTitleColor:HEXCOLOR(0x333333) forState:UIControlStateNormal];
    [D_Btn setImage:[UIImage imageNamed:@"icon_unselected"] forState:UIControlStateNormal];
    [D_Btn setImage:[UIImage imageNamed:@"icon_selected"] forState:UIControlStateSelected];
    D_Btn.titleLabel.font = [UIFont systemFontOfSize:14];
    D_Btn.backgroundColor = [UIColor clearColor];
    [D_Btn addTarget:self action:@selector(didClickKeHuLevel:) forControlEvents:UIControlEventTouchUpInside];
    D_Btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [dengJiBGV addSubview:D_Btn];
    self.D_Btn = D_Btn;
    
//    UIButton *keHuLevelBtn = [[UIButton alloc] init];
//    [keHuLevelBtn setTitle:@"A" forState:UIControlStateNormal];
//    [keHuLevelBtn setTitleColor:HEXCOLOR(0x333333) forState:UIControlStateNormal];
//    keHuLevelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//    keHuLevelBtn.backgroundColor = [UIColor clearColor];
//    [keHuLevelBtn addTarget:self action:@selector(didClickKeHuLevel:) forControlEvents:UIControlEventTouchUpInside];
//    keHuLevelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    [self.showView addSubview:keHuLevelBtn];
//    
//    UIImageView *arrowImageView = [[UIImageView alloc] init];
//    arrowImageView.image = [UIImage imageNamed:@"return"];
//    [self.showView addSubview:arrowImageView];
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.font = [UIFont systemFontOfSize:14];
    label2.textColor = HEXCOLOR(0x333333);
    label2.text = @"消费区间";
    [self.showView addSubview:label2];
    
    
    UITextField *xiaoFeiQuJianTextfield1 = [[UITextField alloc] init];
    xiaoFeiQuJianTextfield1.placeholder = @"0";
    xiaoFeiQuJianTextfield1.font = [UIFont systemFontOfSize:14];
    xiaoFeiQuJianTextfield1.keyboardType = UIKeyboardTypeNumberPad;
    xiaoFeiQuJianTextfield1.borderStyle = UITextBorderStyleNone;
    xiaoFeiQuJianTextfield1.textAlignment = NSTextAlignmentCenter;
    xiaoFeiQuJianTextfield1.backgroundColor = HEXCOLOR(0xf7f7f7);
    xiaoFeiQuJianTextfield1.delegate = self;
    xiaoFeiQuJianTextfield1.layer.cornerRadius = 3;
    [self.showView addSubview:xiaoFeiQuJianTextfield1];
    self.xiaoFeiQuJianTextfield1 = xiaoFeiQuJianTextfield1;
    
    UILabel *zhiLabel = [[UILabel alloc] init];
    zhiLabel.font = [UIFont systemFontOfSize:14];
    zhiLabel.textColor = HEXCOLOR(0x333333);
    zhiLabel.text = @"-";
    zhiLabel.textAlignment = NSTextAlignmentCenter;
    [self.showView addSubview:zhiLabel];
    
    UITextField *xiaoFeiQuJianTextfield2 = [[UITextField alloc] init];
    xiaoFeiQuJianTextfield2.placeholder = @"1000";
    xiaoFeiQuJianTextfield2.font = [UIFont systemFontOfSize:14];
    xiaoFeiQuJianTextfield2.keyboardType = UIKeyboardTypeNumberPad;
    xiaoFeiQuJianTextfield2.borderStyle = UITextBorderStyleNone;
    xiaoFeiQuJianTextfield2.textAlignment = NSTextAlignmentCenter;
    xiaoFeiQuJianTextfield2.backgroundColor = HEXCOLOR(0xf7f7f7);
    xiaoFeiQuJianTextfield2.delegate = self;
    xiaoFeiQuJianTextfield2.layer.cornerRadius = 3;
    [self.showView addSubview:xiaoFeiQuJianTextfield2];
    self.xiaoFeiQuJianTextfield2 = xiaoFeiQuJianTextfield2;
    
    
    UILabel *yuanLabel = [[UILabel alloc] init];
    yuanLabel.font = [UIFont systemFontOfSize:14];
    yuanLabel.textColor = HEXCOLOR(0x333333);
    yuanLabel.text = @"元";
    yuanLabel.textAlignment = NSTextAlignmentCenter;
    [self.showView addSubview:yuanLabel];
    
    
//    UIButton *mengDianKeHuBtn = [[UIButton alloc] init];
//    [mengDianKeHuBtn setTitle:@"门店顾客" forState:UIControlStateNormal];
//    [mengDianKeHuBtn setTitleColor:HEXCOLOR(0x333333) forState:UIControlStateNormal];
//    [mengDianKeHuBtn setImage:[UIImage imageNamed:@"pay_notselected"] forState:UIControlStateNormal];
//    [mengDianKeHuBtn setImage:[UIImage imageNamed:@"pay_selected"] forState:UIControlStateSelected];
//    mengDianKeHuBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//    mengDianKeHuBtn.backgroundColor = [UIColor clearColor];
//    [mengDianKeHuBtn addTarget:self action:@selector(didClickMengDianKeHuBtn:) forControlEvents:UIControlEventTouchUpInside];
//    mengDianKeHuBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    [self.showView addSubview:mengDianKeHuBtn];
//    self.mengDianKeHuBtn = mengDianKeHuBtn;
//    
//    UIButton *benRenKeHuBtn = [[UIButton alloc] init];
//    [benRenKeHuBtn setTitle:@"本人顾客" forState:UIControlStateNormal];
//    [benRenKeHuBtn setTitleColor:HEXCOLOR(0x333333) forState:UIControlStateNormal];
//    [benRenKeHuBtn setImage:[UIImage imageNamed:@"pay_notselected"] forState:UIControlStateNormal];
//    [benRenKeHuBtn setImage:[UIImage imageNamed:@"pay_selected"] forState:UIControlStateSelected];
//    benRenKeHuBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//    benRenKeHuBtn.backgroundColor = [UIColor clearColor];
//    [benRenKeHuBtn addTarget:self action:@selector(didClickBenRenKeHuBtn:) forControlEvents:UIControlEventTouchUpInside];
//    benRenKeHuBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    [self.showView addSubview:benRenKeHuBtn];
//    self.benRenKeHuBtn = benRenKeHuBtn;
    
    UILabel *label3 = [[UILabel alloc] init];
    label3.font = [UIFont systemFontOfSize:14];
    label3.textColor = HEXCOLOR(0x333333);
    label3.text = @"搜索客户";
    [self.showView addSubview:label3];
    
    UITextField *nameSearchTextfield = [[UITextField alloc] init];
    nameSearchTextfield.placeholder = @"请输入卡项名字";
    nameSearchTextfield.font = [UIFont systemFontOfSize:14];
    nameSearchTextfield.borderStyle = UITextBorderStyleNone;
    nameSearchTextfield.textAlignment = NSTextAlignmentCenter;
    nameSearchTextfield.backgroundColor = HEXCOLOR(0xf7f7f7);
    nameSearchTextfield.delegate = self;
    [self.showView addSubview:nameSearchTextfield];
    self.nameSearchTextfield = nameSearchTextfield;
    
    UIButton *cancelBtn = [[UIButton alloc] init];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:HEXCOLOR(0x333333) forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    cancelBtn.backgroundColor = [UIColor clearColor];
    [cancelBtn addTarget:self action:@selector(didClickCancle) forControlEvents:UIControlEventTouchUpInside];
    [self.showView addSubview:cancelBtn];
    
    UIButton *sureBtn = [[UIButton alloc] init];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    sureBtn.backgroundColor = HEXCOLOR(0x4fbbf6);
    [sureBtn addTarget:self action:@selector(didClickSure) forControlEvents:UIControlEventTouchUpInside];
    [self.showView addSubview:sureBtn];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = HEXCOLOR(0xeeeeee);
    [self.showView addSubview:lineView];
    
    label1.sd_layout
    .leftSpaceToView(self.showView,15)
    .rightSpaceToView(self.showView,15)
    .topSpaceToView(navView,10)
    .heightIs(20);
    
    dengJiBGV.sd_layout
    .leftSpaceToView(self.showView,0)
    .topSpaceToView(label1,10)
    .rightSpaceToView(self.showView,0)
    .heightIs(60);
    
    A_Btn.sd_layout
    .leftSpaceToView(dengJiBGV,15)
    .topSpaceToView(dengJiBGV,0)
    .widthIs((menuViewWith2 - 30)/2)
    .heightIs(30);
    
    B_Btn.sd_layout
    .leftSpaceToView(A_Btn,0)
    .topSpaceToView(dengJiBGV,0)
    .widthIs((menuViewWith2 - 30)/2)
    .heightIs(30);
    
    C_Btn.sd_layout
    .leftSpaceToView(dengJiBGV,15)
    .topSpaceToView(A_Btn,0)
    .widthIs((menuViewWith2 - 30)/2)
    .heightIs(30);
    
    D_Btn.sd_layout
    .leftSpaceToView(C_Btn,0)
    .topSpaceToView(B_Btn,0)
    .widthIs((menuViewWith2 - 30)/2)
    .heightIs(30);
    
    label2.sd_layout
    .leftSpaceToView(self.showView,15)
    .rightSpaceToView(self.showView,15)
    .topSpaceToView(dengJiBGV,15)
    .heightIs(20);
    
    xiaoFeiQuJianTextfield1.sd_layout
    .leftSpaceToView(self.showView,15)
    .topSpaceToView(label2,10)
    .widthIs((menuViewWith2 - 30 - 20 - 20)/2)
    .heightIs(30);
    
    zhiLabel.sd_layout
    .leftSpaceToView(xiaoFeiQuJianTextfield1,0)
    .centerYEqualToView(xiaoFeiQuJianTextfield1)
    .heightIs(20)
    .widthIs(20);
    
    xiaoFeiQuJianTextfield2.sd_layout
    .leftSpaceToView(zhiLabel,0)
    .topEqualToView(xiaoFeiQuJianTextfield1)
    .widthIs((menuViewWith2 - 30 - 20 - 20)/2)
    .bottomEqualToView(xiaoFeiQuJianTextfield1);
    
    yuanLabel.sd_layout
    .leftSpaceToView(xiaoFeiQuJianTextfield2,0)
    .centerYEqualToView(xiaoFeiQuJianTextfield2)
    .widthIs(20)
    .heightIs(20);
    
    
//    mengDianKeHuBtn.sd_layout
//    .leftSpaceToView(self.showView,15)
//    .topSpaceToView(label2,5)
//    .rightSpaceToView(self.showView,15)
//    .heightIs(40);
//    
//    benRenKeHuBtn.sd_layout
//    .leftSpaceToView(self.showView,15)
//    .topSpaceToView(mengDianKeHuBtn,5)
//    .rightSpaceToView(self.showView,15)
//    .heightIs(40);
    
    label3.sd_layout
    .leftSpaceToView(self.showView,15)
    .rightSpaceToView(self.showView,15)
    .topSpaceToView(xiaoFeiQuJianTextfield1,15)
    .heightIs(20);
    
    nameSearchTextfield.sd_layout
    .leftSpaceToView(self.showView,15)
    .topSpaceToView(label3,5)
    .rightSpaceToView(self.showView,15)
    .heightIs(30);
    
    cancelBtn.sd_layout
    .leftSpaceToView(self.showView,0)
    .bottomSpaceToView(self.showView,49)
    .widthIs(menuViewWith2/2)
    .heightIs(45);
    
    sureBtn.sd_layout
    .leftSpaceToView(cancelBtn,0)
    .bottomSpaceToView(self.showView,49)
    .widthIs(menuViewWith2/2)
    .heightIs(45);
    
    lineView.sd_layout
    .leftSpaceToView(self.showView,0)
    .bottomSpaceToView(cancelBtn,0)
    .rightSpaceToView(self.showView,0)
    .heightIs(0.5);
}

- (void)didClickCancle
{
    [self closeLeftView];
}

- (void)didClickSure
{
    [self closeLeftView];
    
    if (self.didClickSureBlick) {
        self.didClickSureBlick();
    }
}

- (void)didClickKeHuLevel:(UIButton *)btn
{
    NSArray *array = @[@"  A",@"  B",@"  C"];
    
    self.A_Btn.selected = NO;
    self.B_Btn.selected = NO;
    self.C_Btn.selected = NO;
    btn.selected = YES;
    
    if ([btn.titleLabel.text isEqualToString:@"  A"])
    {
        self.libieId = @"264";
    }
    if ([btn.titleLabel.text isEqualToString:@"  B"])
    {
        self.libieId = @"265";
    }
    if ([btn.titleLabel.text isEqualToString:@"  C"])
    {
        self.libieId = @"265";
    }
}

- (void)didClickMengDianKeHuBtn:(UIButton *)btn
{
    self.benRenKeHuBtn.selected = NO;
    btn.selected = YES;
    self.shopId = [ModelMember sharedMemberMySelf].s_id;
    self.employeeId = @"";
}

- (void)didClickBenRenKeHuBtn:(UIButton *)btn
{
    self.mengDianKeHuBtn.selected = NO;
    btn.selected = YES;
    self.employeeId = [ModelMember sharedMemberMySelf].memberId;
    self.shopId = @"";
}

#pragma mark -
#pragma mark ================= UITextFieldDelegate =================
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
//    if (textField == self.xiaoFeiQuJianTextfield1)
//    {
//        self.xiaoFeiQuJianTextfield1.layer.borderColor = HEXCOLOR(0x4fbbf6).CGColor;
//        self.xiaoFeiQuJianTextfield1.layer.borderWidth = 0.5;
//        self.xiaoFeiQuJianTextfield1.backgroundColor = [UIColor whiteColor];
//    }
//    else if (textField == self.xiaoFeiQuJianTextfield2)
//    {
//        self.xiaoFeiQuJianTextfield2.layer.borderColor = HEXCOLOR(0x4fbbf6).CGColor;
//        self.xiaoFeiQuJianTextfield2.layer.borderWidth = 0.5;
//        self.xiaoFeiQuJianTextfield2.backgroundColor = [UIColor whiteColor];
//    }
//    else if (textField == self.nameSearchTextfield)
//    {
//        self.nameSearchTextfield.layer.borderColor = HEXCOLOR(0x4fbbf6).CGColor;
//        self.nameSearchTextfield.layer.borderWidth = 0.5;
//        self.nameSearchTextfield.backgroundColor = [UIColor whiteColor];
//    }
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
//    if (textField == self.xiaoFeiQuJianTextfield1)
//    {
//        self.xiaoFeiQuJianTextfield1.layer.borderWidth = 0;
//        self.xiaoFeiQuJianTextfield1.backgroundColor = HEXCOLOR(0xf7f7f7);
//    }
//    else if (textField == self.xiaoFeiQuJianTextfield2)
//    {
//        self.xiaoFeiQuJianTextfield2.layer.borderWidth = 0;
//        self.xiaoFeiQuJianTextfield2.backgroundColor = HEXCOLOR(0xf7f7f7);
//    }
    
    return YES;
}

#pragma mark - UIPanGestureRecognizer
-(void)addRecognizer
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeLeftViewEvent:)];
    [_maskView addGestureRecognizer:tap];
    
}

-(void)closeLeftViewEvent:(UITapGestureRecognizer *)recognizer
{
    [self closeLeftView];
}

/**
 *  关闭左视图
 */
- (void)closeLeftView{
    
    NSLog(@"closeLeftView");
    [UIView animateWithDuration:0.3 animations:^{
        
        self.frame = CGRectMake(ScreenWidth, 0, ScreenWidth, ScreenHeight2);
        self.isRightViewHidden = YES;
        _maskView.alpha = 0;
    }];
    
}

- (void)openLeftView
{
    NSLog(@"openLeftView");
    [UIView animateWithDuration:0.3 animations:^{
        
        self.frame = CGRectMake(0 , 0, ScreenWidth, ScreenHeight2);
        self.isRightViewHidden = NO;
        _maskView.alpha = 0.5;
    } completion:^(BOOL finished) {
    }];
}

- (void)UpdateUserData:(NSNotification *)notify{
    
    NSLog(@"UpdateUserData");
}

- (void)changeHeaderImage{
    
    NSLog(@"changeHeaderImage");
}

- (void)AddAction{
    
    NSLog(@"AddAction");
    if (_menuViewDelegate) {
        [_menuViewDelegate LeftMenuViewActionIndex:@"AddAction"];
    }
}

@end
