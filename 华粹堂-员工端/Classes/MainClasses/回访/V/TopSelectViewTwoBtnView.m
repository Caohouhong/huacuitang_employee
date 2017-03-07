//
//  TopSelectViewTwoBtnView.m
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/27.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "TopSelectViewTwoBtnView.h"

@implementation TopSelectViewTwoBtnView

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
    _leftButton.tag = TopSelectViewTwoBtnViewTypeLeft;
    [_leftButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _rightButton = [[UIButton alloc] init];
    _rightButton.titleLabel.font = SYSTEM_FONT_(14);
    _rightButton.tag = TopSelectViewTwoBtnViewTypeRight;
    [_rightButton setTitleColor:COLOR_darkGray forState:UIControlStateNormal];
    [_rightButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *dividerLine1 = [[UIView alloc] init];
    dividerLine1.backgroundColor = COLOR_LineViewColor;
    
    [holdView sd_addSubviews:@[_leftButton, _rightButton, dividerLine1]];
    
    _leftButton.sd_layout
    .leftEqualToView(holdView)
    .topEqualToView(holdView)
    .widthIs(ScreenWidth/2)
    .heightRatioToView(holdView,1);
    
    _rightButton.sd_layout
    .rightEqualToView(holdView)
    .topEqualToView(holdView)
    .widthRatioToView(_leftButton,1)
    .heightRatioToView(_leftButton,1);
    
    dividerLine1.sd_layout
    .rightEqualToView(_leftButton)
    .topSpaceToView(holdView,5)
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
