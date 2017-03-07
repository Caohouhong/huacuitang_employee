//
//  ChhYuYueDetailHeaderView.m
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/24.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "ChhYuYueDetailHeaderView.h"

@implementation ChhYuYueDetailHeaderView

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
    UIView *holdView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, ScreenWidth, 70)];
    holdView.backgroundColor = [UIColor whiteColor];
    [self addSubview:holdView];
    
    UIView *blueView = [[UIView alloc] init];
    blueView.backgroundColor = COLOR_ButtonBackGround_Blue;
    [holdView addSubview:blueView];
    
    _iconImageView = [[UIImageView alloc] init];
    _iconImageView.image = [UIImage imageNamed:@"default"];
    [holdView addSubview:_iconImageView];
    
    _nameTextlabel = [[UILabel alloc] init];
    _nameTextlabel.text = @"姓名";
    _nameTextlabel.font = SYSTEM_FONT_(18);
    _nameTextlabel.textColor = COLOR_Black;
    [holdView addSubview:_nameTextlabel];
    
    _phoneTextlabel = [[UILabel alloc] init];
    _phoneTextlabel.text = @"";
    _phoneTextlabel.font = SYSTEM_FONT_(15);
    _phoneTextlabel.textColor = COLOR_Gray;
    [holdView addSubview:_phoneTextlabel];
    
    _addressTextlabel = [[UILabel alloc] init];
    _addressTextlabel.text = @"";
    _addressTextlabel.font = SYSTEM_FONT_(15);
    _addressTextlabel.textColor = COLOR_Gray;
    [holdView addSubview:_addressTextlabel];
    
    _sexImageView = [[UIImageView alloc] init];
    _sexImageView.image = [UIImage imageNamed:@"icon_girl"]; //12x12
    [holdView addSubview:_sexImageView];
    
    _yearTextlabel = [[UILabel alloc] init];
    _yearTextlabel.font = SYSTEM_FONT_(15);
    _yearTextlabel.textColor = COLOR_Gray;
    _yearTextlabel.text = @"";
    [holdView addSubview:_yearTextlabel];
    
    blueView.sd_layout
    .leftEqualToView(holdView)
    .topEqualToView(holdView)
    .widthIs(4)
    .heightRatioToView(holdView,1);
    
    _iconImageView.sd_layout
    .leftSpaceToView(holdView,20)
    .centerYEqualToView(holdView)
    .widthIs(65)
    .heightIs(65);
    _iconImageView.sd_cornerRadiusFromWidthRatio = @(0.5);
    
    _nameTextlabel.sd_layout
    .leftSpaceToView(_iconImageView,15)
    .topSpaceToView(holdView,10)
    .widthIs(60)
    .heightIs(20);
    
    _phoneTextlabel.sd_layout
    .leftSpaceToView(_nameTextlabel,5)
    .centerYEqualToView(_nameTextlabel)
    .widthIs(130)
    .heightIs(20);
    
    _addressTextlabel.sd_layout
    .leftSpaceToView(_iconImageView,15)
    .topSpaceToView(_nameTextlabel,12)
    .widthIs(75)
    .heightIs(20);
    
    _sexImageView.sd_layout
    .leftSpaceToView(_addressTextlabel,5)
    .centerYEqualToView(_addressTextlabel)
    .widthIs(12)
    .heightIs(12);
    
    _yearTextlabel.sd_layout
    .leftSpaceToView(_sexImageView,5)
    .centerYEqualToView(_addressTextlabel)
    .widthIs(50)
    .heightIs(20);
   }
@end
