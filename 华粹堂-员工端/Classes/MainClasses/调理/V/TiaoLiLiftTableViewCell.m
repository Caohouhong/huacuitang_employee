//
//  TiaoLiLiftTableViewCell.m
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/27.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "TiaoLiLiftTableViewCell.h"


@implementation TiaoLiLiftTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.contentView.backgroundColor = HEXCOLOR(0xeeeeee);
        [self drawView];
    }
    
    return self;
}

+ (TiaoLiLiftTableViewCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"TiaoLiLiftTableViewCell";
    TiaoLiLiftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[TiaoLiLiftTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}


- (void)drawView
{
    UIView *topHoldView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 90)];
    topHoldView.backgroundColor = [UIColor whiteColor];
    [self addSubview:topHoldView];
    
    UIView *dividerView = [[UIView alloc] init];
    dividerView.backgroundColor = COLOR_BackgroundColor;
    
    _topPlanCell = [[TiaoliOnceCellView alloc] init];
    _topPlanCell.leftNameLabel.text = @"到店理疗配合情况：";
    _topPlanCell.rightButton.hidden = YES;
    _topPlanCell.rightLabel.text = @"得分：10";
    
    UIView *dividerLine1 = [[UIView alloc] init];
    dividerLine1.backgroundColor = COLOR_LineViewColor;
    
    UIButton *selectBtn0 = [self creatBtnWithTitle:@"不选" andTag:10000];
    UIButton *selectBtn1 = [self creatBtnWithTitle:@"差" andTag:10001];
    UIButton *selectBtn2 = [self creatBtnWithTitle:@"一般" andTag:10002];
    UIButton *selectBtn3 = [self creatBtnWithTitle:@"较好" andTag:10003];
    UIButton *selectBtn4 = [self creatBtnWithTitle:@"好" andTag:10004];
    
    [topHoldView sd_addSubviews:@[dividerView,_topPlanCell,selectBtn0,selectBtn1,selectBtn2,selectBtn3,selectBtn4,dividerLine1]];
    
    dividerView.sd_layout
    .leftEqualToView(topHoldView)
    .topEqualToView(topHoldView)
    .widthRatioToView(topHoldView,1)
    .heightIs(10);
    
    _topPlanCell.sd_layout
    .leftEqualToView(topHoldView)
    .topEqualToView(topHoldView).offset(10)
    .widthRatioToView(topHoldView,1)
    .heightIs(30);
    
    selectBtn0.sd_layout
    .leftEqualToView(topHoldView).offset(15)
    .topSpaceToView(_topPlanCell,10)
    .widthIs((ScreenWidth - 50)/5)
    .heightIs(30);
    
    selectBtn1.sd_layout
    .leftSpaceToView(selectBtn0,5)
    .topEqualToView(selectBtn0)
    .widthRatioToView(selectBtn0,1)
    .heightRatioToView(selectBtn0,1);
    
    selectBtn2.sd_layout
    .leftSpaceToView(selectBtn1,5)
    .topEqualToView(selectBtn0)
    .widthRatioToView(selectBtn0,1)
    .heightRatioToView(selectBtn0,1);
    
    selectBtn3.sd_layout
    .leftSpaceToView(selectBtn2,5)
    .topEqualToView(selectBtn0)
    .widthRatioToView(selectBtn0,1)
    .heightRatioToView(selectBtn0,1);
    
    selectBtn4.sd_layout
    .leftSpaceToView(selectBtn3,5)
    .topEqualToView(selectBtn0)
    .widthRatioToView(selectBtn0,1)
    .heightRatioToView(selectBtn0,1);
    
    dividerLine1.sd_layout
    .leftEqualToView(topHoldView)
    .bottomEqualToView(topHoldView)
    .widthRatioToView(topHoldView,1)
    .heightIs(1);
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

- (void)buttonAction:(UIButton *)button
{
    
}
@end
