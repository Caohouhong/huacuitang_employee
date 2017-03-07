//
//  BackFiveTableViewCell.m
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/28.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "BackFiveTableViewCell.h"

@implementation BackFiveTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        //        self.contentView.backgroundColor = HEXCOLOR(0xeeeeee);
        [self drawView];
    }
    
    return self;
}

+ (BackFiveTableViewCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"BackFiveTableViewCell";
    BackFiveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[BackFiveTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}
- (void)drawView{
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = @"综合反馈";
    _titleLabel.font = SYSTEM_FONT_(15);
    _titleLabel.textColor = COLOR_Black;
    
    _rightLabel = [[UILabel alloc] init];
    _rightLabel.font = SYSTEM_FONT_(15);
    _rightLabel.textAlignment = NSTextAlignmentRight;
    _rightLabel.textColor = COLOR_Black;
    
    UIView *dividerLine1 = [[UIView alloc] init];
    dividerLine1.backgroundColor = COLOR_LineViewColor;
    
    UIView *dividerLine2 = [[UIView alloc] init];
    dividerLine2.backgroundColor = COLOR_LineViewColor;
    
    UIView *dividerLine3 = [[UIView alloc] init];
    dividerLine3.backgroundColor = COLOR_LineViewColor;
    
    UIButton *adviceBtn0 = [self creatBtnWithTitle:@"不选" andTag:20000];
    UIButton *adviceBtn1 = [self creatBtnWithTitle:@"差" andTag:20001];
    UIButton *adviceBtn2 = [self creatBtnWithTitle:@"一般" andTag:20002];
    UIButton *adviceBtn3 = [self creatBtnWithTitle:@"较好" andTag:20003];
    UIButton *adviceBtn4 = [self creatBtnWithTitle:@"好" andTag:20004];
    
    [self.contentView sd_addSubviews:@[_titleLabel,_rightLabel,adviceBtn0,adviceBtn1,adviceBtn2,adviceBtn3,adviceBtn4,dividerLine1,dividerLine2,dividerLine3]];
    
    _titleLabel.sd_layout
    .leftEqualToView(self.contentView).offset(15)
    .topEqualToView(self.contentView)
    .widthRatioToView(self.contentView,1)
    .heightIs(30);
    
    _rightLabel.sd_layout
    .rightEqualToView(self.contentView).offset(-15)
    .topEqualToView(self.contentView)
    .widthRatioToView(self.contentView,1)
    .heightIs(30);
    
    dividerLine1.sd_layout
    .leftEqualToView(self.contentView)
    .bottomEqualToView(_titleLabel)
    .widthRatioToView(self.contentView,1)
    .heightIs(1);
    
    dividerLine2.sd_layout
    .leftEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .widthRatioToView(self.contentView,1)
    .heightIs(1);
    
    dividerLine3.sd_layout
    .leftEqualToView(self.contentView)
    .topEqualToView(self.contentView)
    .widthRatioToView(self.contentView,1)
    .heightIs(1);
    
    adviceBtn0.sd_layout
    .leftEqualToView(self.contentView).offset(15)
    .topSpaceToView(_titleLabel,10)
    .widthIs((ScreenWidth - 50)/5)
    .heightIs(30);
    
    adviceBtn1.sd_layout
    .leftSpaceToView(adviceBtn0,5)
    .topEqualToView(adviceBtn0)
    .widthRatioToView(adviceBtn0,1)
    .heightRatioToView(adviceBtn0,1);
    
    adviceBtn2.sd_layout
    .leftSpaceToView(adviceBtn1,5)
    .topEqualToView(adviceBtn0)
    .widthRatioToView(adviceBtn0,1)
    .heightRatioToView(adviceBtn0,1);
    
    adviceBtn3.sd_layout
    .leftSpaceToView(adviceBtn2,5)
    .topEqualToView(adviceBtn0)
    .widthRatioToView(adviceBtn0,1)
    .heightRatioToView(adviceBtn0,1);
    
    adviceBtn4.sd_layout
    .leftSpaceToView(adviceBtn3,5)
    .topEqualToView(adviceBtn0)
    .widthRatioToView(adviceBtn0,1)
    .heightRatioToView(adviceBtn0,1);

    
}

- (UIButton *)creatBtnWithTitle:(NSString *)title andTag:(int)tag {
    
    UIButton *selectBtn = [[UIButton alloc] init];
    selectBtn.layer.cornerRadius = 2;
    selectBtn.layer.borderWidth = 1;
    selectBtn.tag = tag;
    selectBtn.selected = NO;
    selectBtn.layer.borderColor = COLOR_LightGray.CGColor;
    selectBtn.titleLabel.font = SYSTEM_FONT_(15);
    [selectBtn setTitle:title forState:UIControlStateNormal];
    [selectBtn setTitleColor:COLOR_Gray forState:UIControlStateNormal];
    [selectBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    return selectBtn;
}

- (void)buttonAction:(UIButton *)btn
{
    btn.layer.borderColor = COLOR_Text_Blue.CGColor;
    [btn setTitleColor:COLOR_TEXT_DARK_BLUE forState:UIControlStateNormal];
    [btn setBackgroundColor:COLOR_BG_DARK_BLUE];
}




@end
