//
//  RechargeTableViewCell.m
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/22.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "RechargeTableViewCell.h"
@interface RechargeTableViewCell(){
    
}
@end
@implementation RechargeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        //        self.contentView.backgroundColor = HEXCOLOR(0xeeeeee);
        [self drawView];
    }
    
    return self;
}

+ (RechargeTableViewCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"RechargeTableViewCell";
    RechargeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[RechargeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)drawView{
    
    _iconImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_iconImageView];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont systemFontOfSize:15];
    _nameLabel.textColor = HEXCOLOR(0x666666);
    [self.contentView addSubview:_nameLabel];
    
    _leftLabel = [[UILabel alloc] init];
    _leftLabel.font = [UIFont systemFontOfSize:15];
    _leftLabel.textColor = HEXCOLOR(0x666666);
    [self.contentView addSubview:_leftLabel];
    
    _centerLabel = [[UILabel alloc] init];
    _centerLabel.font = [UIFont systemFontOfSize:15];
    _centerLabel.textColor = COLOR_Gray;
    _centerLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_centerLabel];
    
    _rightLabel = [[UILabel alloc] init];
    _rightLabel.font = [UIFont systemFontOfSize:15];
    _rightLabel.textColor = HEXCOLOR(0x666666);
    _rightLabel.textAlignment = NSTextAlignmentRight;
    _rightLabel.text = @"0";
    [self.contentView addSubview:_rightLabel];

    UIView *dividerLine = [[UIView alloc] init];
    dividerLine.backgroundColor = backviewColor;
    [self.contentView addSubview:dividerLine];
    
    _iconImageView.sd_layout
    .leftSpaceToView(self.contentView,10)
    .centerYEqualToView(self.contentView)
    .widthIs(37).heightIs(37);
    
    _nameLabel.sd_layout
    .leftSpaceToView(self.contentView,57)
    .centerYEqualToView(self.contentView)
    .widthIs(100).heightIs(25);

    _leftLabel.sd_layout
    .leftSpaceToView(self.contentView,15)
    .centerYEqualToView(self.contentView)
    .widthIs(125).heightRatioToView(self.contentView,1);
    
    _centerLabel.sd_layout
    .centerXEqualToView(self.contentView)
    .centerYEqualToView(self.contentView)
    .widthIs(125).heightRatioToView(self.contentView,1);
    
    _rightLabel.sd_layout
    .rightEqualToView(self.contentView).offset(-10)
    .centerYEqualToView(self.contentView)
    .widthIs(150).heightIs(25);
    
    dividerLine.sd_layout
    .leftEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .widthRatioToView(self.contentView,1)
    .heightIs(1);
    
    
}

//今日目标
- (void)setTodayTargetModel:(TodayTargetModel *)todayTargetModel
{
    _todayTargetModel = todayTargetModel;

    self.leftLabel.text = todayTargetModel.target_customer;
    self.centerLabel.text = todayTargetModel.target_content;
    self.rightLabel.text = todayTargetModel.target_money;
}

//今日总结
- (void)setDailySumModel:(DailySummaryModel *)dailySumModel
{
    _dailySumModel = dailySumModel;
    
    self.leftLabel.text = dailySumModel.e_name;
    self.centerLabel.text = @"调理师";
    self.rightLabel.text = ([dailySumModel.is_finished isEqualToString:@"1"] ? @"已完成" : @"未完成");
    
}

@end
