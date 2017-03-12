//
//  BackFourTableViewCell.m
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/28.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "BackFourTableViewCell.h"

@implementation BackFourTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        //        self.contentView.backgroundColor = HEXCOLOR(0xeeeeee);
        [self drawView];
    }
    
    return self;
}

+ (BackFourTableViewCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"BackFourTableViewCell";
    BackFourTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[BackFourTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}
- (void)drawView{
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = @"综合反馈";
    _titleLabel.font = SYSTEM_FONT_(15);
    _titleLabel.textColor = COLOR_Black;
    
    UIView *dividerLine1 = [[UIView alloc] init];
    dividerLine1.backgroundColor = COLOR_LineViewColor;
    
    UIView *dividerLine2 = [[UIView alloc] init];
    dividerLine2.backgroundColor = COLOR_LineViewColor;
    
    UIView *dividerLine3 = [[UIView alloc] init];
    dividerLine3.backgroundColor = COLOR_LineViewColor;
    
    self.adviceBtn0 = [self creatBtnWithTitle:@"不太满意" andTag:20000];
    self.adviceBtn1 = [self creatBtnWithTitle:@"一般" andTag:20001];
    self.adviceBtn2 = [self creatBtnWithTitle:@"较满意" andTag:20002];
    self.adviceBtn3 = [self creatBtnWithTitle:@"很满意" andTag:20003];
    
    [self.contentView sd_addSubviews:@[_titleLabel,_adviceBtn0,_adviceBtn1,_adviceBtn2,_adviceBtn3,dividerLine1,dividerLine2,dividerLine3]];
    
    _titleLabel.sd_layout
    .leftEqualToView(self.contentView).offset(15)
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
    
    _adviceBtn0.sd_layout
    .leftEqualToView(self.contentView).offset(15)
    .topSpaceToView(_titleLabel,10)
    .widthIs((ScreenWidth - 45)/4)
    .heightIs(30);
    
    _adviceBtn1.sd_layout
    .leftSpaceToView(_adviceBtn0,5)
    .topEqualToView(_adviceBtn0)
    .widthRatioToView(_adviceBtn0,1)
    .heightRatioToView(_adviceBtn0,1);
    
    _adviceBtn2.sd_layout
    .leftSpaceToView(_adviceBtn1,5)
    .topEqualToView(_adviceBtn0)
    .widthRatioToView(_adviceBtn0,1)
    .heightRatioToView(_adviceBtn0,1);
    
    _adviceBtn3.sd_layout
    .leftSpaceToView(_adviceBtn2,5)
    .topEqualToView(_adviceBtn0)
    .widthRatioToView(_adviceBtn0,1)
    .heightRatioToView(_adviceBtn0,1);
    
   }

- (UIButton *)creatBtnWithTitle:(NSString *)title andTag:(int)tag {
    
    UIButton *selectBtn = [[UIButton alloc] init];
    selectBtn.layer.cornerRadius = 2;
    selectBtn.layer.borderWidth = 1;
    selectBtn.layer.masksToBounds = YES;
    selectBtn.tag = tag;
    selectBtn.selected = NO;
    selectBtn.layer.borderColor = COLOR_LightGray.CGColor;
    selectBtn.titleLabel.font = SYSTEM_FONT_(15);
    [selectBtn setTitle:title forState:UIControlStateNormal];
    [selectBtn setTitleColor:COLOR_Gray forState:UIControlStateNormal];
//    [selectBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    return selectBtn;
}

- (void)buttonAction:(UIButton *)btn
{
    btn.layer.borderColor = COLOR_Text_Blue.CGColor;
    [btn setTitleColor:COLOR_TEXT_DARK_BLUE forState:UIControlStateNormal];
    [btn setBackgroundColor:COLOR_BG_DARK_BLUE];
}



@end
