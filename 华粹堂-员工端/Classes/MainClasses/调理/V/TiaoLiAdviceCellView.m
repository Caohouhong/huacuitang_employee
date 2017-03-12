//
//  TiaoLiAdviceCellView.m
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/27.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "TiaoLiAdviceCellView.h"

@implementation TiaoLiAdviceCellView

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
    _titleLabel.text = @"院长审核意见";
    _titleLabel.font = SYSTEM_FONT_(15);
    _titleLabel.textColor = COLOR_Black;
    [topHoldView addSubview:_titleLabel];
    
    UIView *verBlueView = [[UIView alloc] init];
    verBlueView.backgroundColor = COLOR_Text_Blue;
    [topHoldView addSubview:verBlueView];
    
    UIView *textViewHoldView = [[UIView alloc] init];
    textViewHoldView.backgroundColor = [UIColor whiteColor];
    [topHoldView addSubview:textViewHoldView];
    
    _topTextView = [[UITextView alloc] init];
    _topTextView.backgroundColor = [UIColor whiteColor];
    _topTextView.placeholderColor = COLOR_LightGray;
    _topTextView.font = SYSTEM_FONT_(14);
    _topTextView.textColor = COLOR_Gray;
    _topTextView.editable = NO;
    _topTextView.placeholder = @"暂无";
    [textViewHoldView addSubview:_topTextView];
    
    UIView *topDividerLine1 = [[UIView alloc] init];
    topDividerLine1.backgroundColor = COLOR_LineViewColor;
    [topHoldView addSubview:topDividerLine1];
    
    UIView *topDividerLine2 = [[UIView alloc] init];
    topDividerLine2.backgroundColor = COLOR_LineViewColor;
    [topHoldView addSubview:topDividerLine2];
    
    _nameLabel = [[UILabel alloc] init];
//    _nameLabel.text = @"审核人：";
    _nameLabel.font = SYSTEM_FONT_(15);
    _nameLabel.textColor = COLOR_Gray;
    [topHoldView addSubview:_nameLabel];

    
    _timeLabel = [[UILabel alloc] init];
//    _timeLabel.text = @"审核时间：";
    _timeLabel.font = SYSTEM_FONT_(15);
    _timeLabel.textAlignment = NSTextAlignmentRight;
    _timeLabel.textColor = COLOR_Gray;
    [topHoldView addSubview:_timeLabel];
    
    _titleLabel.sd_layout
    .leftEqualToView(topHoldView).offset(25)
    .topSpaceToView(topHoldView,5)
    .widthRatioToView(topHoldView,1)
    .heightIs(25);
    
    verBlueView.sd_layout
    .leftEqualToView(topHoldView).offset(15)
    .centerYEqualToView(_titleLabel)
    .widthIs(3)
    .heightIs(8);
    verBlueView.sd_cornerRadiusFromWidthRatio = @(0.5);
    
    textViewHoldView.sd_layout
    .leftEqualToView(topHoldView)
    .topSpaceToView(_titleLabel,0)
    .widthIs(ScreenWidth)
    .heightIs(self.frame.size.height - 30 - 25);
    
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
    
    _nameLabel.sd_layout
    .leftEqualToView(topHoldView).offset(15)
    .topSpaceToView(textViewHoldView,0)
    .widthIs(ScreenWidth/2)
    .heightIs(25);
    
    _timeLabel.sd_layout
    .rightEqualToView(topHoldView).offset(-15)
    .topSpaceToView(textViewHoldView,0)
    .widthIs(ScreenWidth/2)
    .heightIs(25);
}

@end
