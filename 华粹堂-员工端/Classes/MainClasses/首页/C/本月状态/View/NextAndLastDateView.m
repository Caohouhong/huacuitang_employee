//
//  NextAndLastDateView.m
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/24.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "NextAndLastDateView.h"

@implementation NextAndLastDateView

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
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 35)];
    topView.backgroundColor = [UIColor whiteColor];
    [self addSubview:topView];
    
    _lastBtn = [[UIButton alloc] init];
    _lastBtn.titleLabel.font = SYSTEM_FONT_(14);
    [_lastBtn setTitleColor:COLOR_Text_Blue forState:UIControlStateNormal];
    _lastBtn.tag = NextAndLastDateViewButtonTypeLast;
    [_lastBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:_lastBtn];
    
    _nextBtn = [[UIButton alloc] init];
    _nextBtn.titleLabel.font = SYSTEM_FONT_(14);
    _nextBtn.tag = NextAndLastDateViewButtonTypeNext;
    [_nextBtn setTitleColor:COLOR_Text_Blue forState:UIControlStateNormal];
    [_nextBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:_nextBtn];
    
    UIView *dividerLine1 = [[UIView alloc] init];
    dividerLine1.backgroundColor = COLOR_LineViewColor;
    [topView addSubview:dividerLine1];
    
    UIView *dividerLine2 = [[UIView alloc] init];
    dividerLine2.backgroundColor = COLOR_LineViewColor;
    [topView addSubview:dividerLine2];
    
    _dataLabel = [[UILabel alloc] init];
    _dataLabel.font = SYSTEM_FONT_(15);
    _dataLabel.textAlignment = NSTextAlignmentCenter;
    _dataLabel.textColor = COLOR_Black;
    [topView addSubview:_dataLabel];
    
    _lastBtn.sd_layout
    .leftSpaceToView(topView,10)
    .topEqualToView(topView)
    .widthIs(80)
    .heightRatioToView(topView,1);
    
    _nextBtn.sd_layout
    .rightEqualToView(topView).offset(-10)
    .topEqualToView(topView)
    .widthIs(80)
    .heightRatioToView(topView,1);
    
    dividerLine1.sd_layout
    .leftSpaceToView(topView,80)
    .topSpaceToView(topView,5)
    .widthIs(1)
    .heightIs(25);
    
    dividerLine2.sd_layout
    .rightSpaceToView(topView,80)
    .topEqualToView(dividerLine1)
    .widthIs(1)
    .heightRatioToView(dividerLine1,1);
    
    _dataLabel.sd_layout
    .centerXEqualToView(topView)
    .centerYEqualToView(topView)
    .widthIs(150)
    .heightRatioToView(topView,1);
}

- (void)buttonAction:(UIButton *)button
{
    if (self.delegate){
        [self.delegate nextAndLastDateBtnClickWithTag:button.tag];
    }
}

@end
