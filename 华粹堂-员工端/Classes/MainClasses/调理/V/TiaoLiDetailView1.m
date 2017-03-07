//
//  TiaoLiDetailView1.m
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/26.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "TiaoLiDetailView1.h"
#import "TiaoliOnceCellView.h"

@implementation TiaoLiDetailView1

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
    UIView *topHoldView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, self.frame.size.height)];
    topHoldView.backgroundColor = COLOR_BackgroundColor;
    [self addSubview:topHoldView];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = @"服务时间：2012-12－12 12:12:12";
    _titleLabel.font = SYSTEM_FONT_(12);
    _titleLabel.textColor = COLOR_Gray;
    [topHoldView addSubview:_titleLabel];
    
    UIView *textViewHoldView = [[UIView alloc] init];
    textViewHoldView.backgroundColor = [UIColor whiteColor];
    [topHoldView addSubview:textViewHoldView];
    
    _topTextView = [[UITextView alloc] init];
    _topTextView.placeholder = @"请填写调理项目";
    _topTextView.backgroundColor = [UIColor whiteColor];
    _topTextView.placeholderColor = COLOR_LightGray;
    _topTextView.font = SYSTEM_FONT_(14);
    _topTextView.textColor = COLOR_Gray;
    [textViewHoldView addSubview:_topTextView];
    
    UIView *topDividerLine1 = [[UIView alloc] init];
    topDividerLine1.backgroundColor = COLOR_LineViewColor;
    [topHoldView addSubview:topDividerLine1];
    
    UIView *topDividerLine2 = [[UIView alloc] init];
    topDividerLine2.backgroundColor = COLOR_LineViewColor;
    [topHoldView addSubview:topDividerLine2];
    
//    UIButton *upBtn = [[UIButton alloc] init];
//    [upBtn setBackgroundImage:[UIImage imageNamed:@"arrow_up_25x14"] forState:UIControlStateNormal];
//    [upBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
//    [topHoldView addSubview:upBtn];
//    
//    UIButton *downBtn = [[UIButton alloc] init];
//    [downBtn setBackgroundImage:[UIImage imageNamed:@"arrow_down_25x14"] forState:UIControlStateNormal];
//    [downBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
//    [topHoldView addSubview:downBtn];
    
    _titleLabel.sd_layout
    .leftEqualToView(topHoldView).offset(15)
    .topEqualToView(topHoldView)
    .widthRatioToView(topHoldView,1)
    .heightIs(20);
    
    textViewHoldView.sd_layout
    .leftEqualToView(topHoldView)
    .topSpaceToView(_titleLabel,0)
    .widthIs(ScreenWidth)
    .heightIs(self.frame.size.height - 30);
    
    _topTextView.sd_layout
    .leftEqualToView(textViewHoldView).offset(15)
    .topEqualToView(textViewHoldView).offset(5)
    .rightEqualToView(textViewHoldView).offset(-15)
    .bottomEqualToView(textViewHoldView).offset(-5);
    
    topDividerLine1.sd_layout
    .leftEqualToView(topHoldView)
    .topEqualToView(textViewHoldView)
    .widthRatioToView(topHoldView,1)
    .heightIs(1);
    
    topDividerLine2.sd_layout
    .leftEqualToView(topHoldView)
    .bottomEqualToView(textViewHoldView)
    .widthRatioToView(topHoldView,1)
    .heightIs(1);

//    upBtn.sd_layout
//    .rightEqualToView(topHoldView).offset(-2)
//    .topEqualToView(textViewHoldView).offset(10)
//    .widthIs(18)
//    .heightIs(10);
//    
//    downBtn.sd_layout
//    .rightEqualToView(upBtn)
//    .bottomEqualToView(textViewHoldView).offset(-10)
//    .widthIs(18)
//    .heightIs(10);
}

//- (void)buttonAction:(UIButton *)button
//{
//    
//}
@end
