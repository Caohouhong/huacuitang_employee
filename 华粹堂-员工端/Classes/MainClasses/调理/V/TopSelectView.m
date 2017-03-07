//
//  TopSelectView.m
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/26.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "TopSelectView.h"

@implementation TopSelectView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){
        [self initView];
    }
    return self;
}

- (void)initView
{
    UIView *holdView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 35)];
    holdView.backgroundColor = [UIColor whiteColor];
    [self addSubview:holdView];
    
    _leftButton = [[UIButton alloc] init];
    _leftButton.titleLabel.font = SYSTEM_FONT_(14);
    [_leftButton setTitleColor:COLOR_darkGray forState:UIControlStateNormal];
    _leftButton.tag = TopSelectViewTypeLeft;
    [_leftButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _centerButton = [[UIButton alloc] init];
    _centerButton.titleLabel.font = SYSTEM_FONT_(14);
    _centerButton.tag = TopSelectViewTypeCenter;
    [_centerButton setTitleColor:COLOR_darkGray forState:UIControlStateNormal];
    [_centerButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _rightButton = [[UIButton alloc] init];
    _rightButton.titleLabel.font = SYSTEM_FONT_(14);
    _rightButton.tag = TopSelectViewTypeRight;
    [_rightButton setTitleColor:COLOR_darkGray forState:UIControlStateNormal];
    [_rightButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _markView = [[UIView alloc] init];
    _markView.backgroundColor = [UIColor redColor];
    _markView.hidden = YES;
    [_rightButton addSubview:_markView];
    
    UIView *dividerLine1 = [[UIView alloc] init];
    dividerLine1.backgroundColor = COLOR_LineViewColor;
    
    UIView *dividerLine2 = [[UIView alloc] init];
    dividerLine2.backgroundColor = COLOR_LineViewColor;
    
    [holdView sd_addSubviews:@[_leftButton, _rightButton, _centerButton, dividerLine1,dividerLine2]];
    
    _leftButton.sd_layout
    .leftEqualToView(holdView)
    .topEqualToView(holdView)
    .widthIs(ScreenWidth/3)
    .heightRatioToView(holdView,1);
    
    _centerButton.sd_layout
    .centerXEqualToView(holdView)
    .topEqualToView(holdView)
    .widthRatioToView(_leftButton,1)
    .heightRatioToView(_leftButton,1);
    
    _rightButton.sd_layout
    .rightEqualToView(holdView)
    .topEqualToView(holdView)
    .widthRatioToView(_leftButton,1)
    .heightRatioToView(_leftButton,1);
    
    _markView.sd_layout
    .centerXEqualToView(_rightButton).offset(27)
    .topEqualToView(_rightButton).offset(5)
    .widthIs(10)
    .heightIs(10);
    _markView.sd_cornerRadiusFromWidthRatio = @(0.5);
    
    dividerLine1.sd_layout
    .rightEqualToView(_leftButton)
    .topSpaceToView(holdView,5)
    .widthIs(1)
    .heightIs(25);
    
    dividerLine2.sd_layout
    .rightEqualToView(_centerButton)
    .centerYEqualToView(dividerLine1)
    .widthIs(1)
    .heightIs(25);
}

- (void)buttonAction:(UIButton *)button
{
    if (self.delegate){
        [self.delegate topButtonClickWithTag:button.tag];
    }
}

@end
