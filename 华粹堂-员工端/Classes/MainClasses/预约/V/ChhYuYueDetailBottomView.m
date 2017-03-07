//
//  ChhYuYueDetailBottomView.m
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/24.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "ChhYuYueDetailBottomView.h"

@implementation ChhYuYueDetailBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){
        self.backgroundColor = COLOR_BackgroundColor;
        [self initView];
    }
    
    return self;
}

- (void)initView
{
    UIView *holdView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 45)];
    holdView.backgroundColor = [UIColor whiteColor];
    [self addSubview:holdView];
    
    _callBtn = [[UIButton alloc] init];
    _callBtn.titleLabel.font = SYSTEM_FONT_(14);
    [_callBtn setImage:[UIImage imageNamed:@"Mytelephone"] forState:UIControlStateNormal];
    [_callBtn setTitle:@"打电话" forState:UIControlStateNormal];
    [_callBtn setTitleColor:COLOR_darkGray forState:UIControlStateNormal];
    _callBtn.tag = ChhYuYueDetailBotViewTypeCall;
    [_callBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [holdView addSubview:_callBtn];
    
    _messageBtn = [[UIButton alloc] init];
    _messageBtn.titleLabel.font = SYSTEM_FONT_(14);
    [_messageBtn setImage:[UIImage imageNamed:@"Mytelephone"] forState:UIControlStateNormal];
    [_messageBtn setTitle:@"发短信" forState:UIControlStateNormal];
    _messageBtn.tag = ChhYuYueDetailBotViewTypeMessage;
    [_messageBtn setTitleColor:COLOR_darkGray forState:UIControlStateNormal];
    [_messageBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [holdView addSubview:_messageBtn];
    
    _chatBtn = [[UIButton alloc] init];
    _chatBtn.titleLabel.font = SYSTEM_FONT_(14);
    [_chatBtn setImage:[UIImage imageNamed:@"Mytelephone"] forState:UIControlStateNormal];
    [_chatBtn setTitle:@"在线聊天" forState:UIControlStateNormal];
    _chatBtn.tag = ChhYuYueDetailBotViewTypeChat;
    [_chatBtn setTitleColor:COLOR_darkGray forState:UIControlStateNormal];
    [_chatBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [holdView addSubview:_chatBtn];
    
    UIView *dividerLine1 = [[UIView alloc] init];
    dividerLine1.backgroundColor = COLOR_ButtonBackGround_Blue;
    [holdView addSubview:dividerLine1];
    
    UIView *dividerLine2 = [[UIView alloc] init];
    dividerLine2.backgroundColor = COLOR_LineViewColor;
    [holdView addSubview:dividerLine2];
    
    UIView *dividerLine3 = [[UIView alloc] init];
    dividerLine3.backgroundColor = COLOR_LineViewColor;
    [holdView addSubview:dividerLine3];
    
    _callBtn.sd_layout
    .leftEqualToView(holdView)
    .topEqualToView(holdView)
    .widthIs(ScreenWidth/3)
    .heightRatioToView(holdView,1);
    
    _messageBtn.sd_layout
    .centerXEqualToView(holdView)
    .topEqualToView(holdView)
    .widthRatioToView(_callBtn,1)
    .heightRatioToView(_callBtn,1);
    
    _chatBtn.sd_layout
    .rightEqualToView(holdView)
    .topEqualToView(holdView)
    .widthRatioToView(_callBtn,1)
    .heightRatioToView(_callBtn,1);
    
    dividerLine1.sd_layout
    .leftEqualToView(holdView)
    .topEqualToView(holdView)
    .widthIs(ScreenWidth)
    .heightIs(1);
    
    dividerLine2.sd_layout
    .leftSpaceToView(_callBtn,0)
    .centerYEqualToView(holdView)
    .widthIs(1)
    .heightIs(15);
    
    dividerLine3.sd_layout
    .leftSpaceToView(_messageBtn,0)
    .centerYEqualToView(holdView)
    .widthIs(1)
    .heightIs(15);
}

- (void)buttonAction:(UIButton *)button
{

}

@end
