//
//  TiaoliOnceCellView.m
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/26.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "TiaoliOnceCellView.h"

@implementation TiaoliOnceCellView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
        
    }
    return self;
}

- (void)initView
{
    
    UIView *dividerLine1 = [[UIView alloc] init];
    dividerLine1.backgroundColor = COLOR_LineViewColor;
    [self addSubview:dividerLine1];
    
    UIView *dividerLine2 = [[UIView alloc] init];
    dividerLine2.backgroundColor = COLOR_LineViewColor;
    [self addSubview:dividerLine2];
    
    _leftNameLabel = [[UILabel alloc] init];
    _leftNameLabel.font = SYSTEM_FONT_(15);
    _leftNameLabel.textColor = COLOR_Black;
    [self addSubview:_leftNameLabel];
    
    _rightLabel = [[UILabel alloc] init];
    _rightLabel.font = SYSTEM_FONT_(15);
    _rightLabel.textColor = COLOR_Black;
    _rightLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_rightLabel];
    
    _rightButton = [[UIButton alloc] init];
    _rightButton.titleLabel.font = SYSTEM_FONT_(15);
    [_rightButton setTitleColor:COLOR_Text_Blue forState:UIControlStateNormal];
    [self addSubview:_rightButton];
    
    _fullButton = [[UIButton alloc] init];
    _fullButton.backgroundColor = [UIColor clearColor];
    _fullButton.hidden = YES;
    [self addSubview:_fullButton];
    
    
    dividerLine1.sd_layout
    .leftEqualToView(self)
    .topEqualToView(self)
    .widthRatioToView(self,1)
    .heightIs(1);
    
    dividerLine2.sd_layout
    .leftEqualToView(self)
    .bottomEqualToView(self)
    .widthRatioToView(self,1)
    .heightIs(1);
    
    _leftNameLabel.sd_layout
    .leftSpaceToView(self,15)
    .topEqualToView(self)
    .widthIs(ScreenWidth/2)
    .heightRatioToView(self,1);
    
    _rightLabel.sd_layout
    .rightEqualToView(self).offset(-15)
    .topEqualToView(self)
    .widthIs(ScreenWidth/2)
    .heightRatioToView(self,1);
    
    _rightButton.sd_layout
    .rightEqualToView(self).offset(-15)
    .topEqualToView(self)
    .widthIs(65)
    .heightRatioToView(self,1);
    
    _fullButton.sd_layout
    .leftEqualToView(self)
    .topEqualToView(self)
    .widthIs(ScreenWidth)
    .heightRatioToView(self,1);

}
@end
