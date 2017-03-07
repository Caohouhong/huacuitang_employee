//
//  YuYueCell.m
//  华粹堂-员工端
//
//  Created by liqiang on 2016/11/14.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import "YuYueCell.h"

@interface YuYueCell ()

@property (nonatomic, weak) UIImageView *iconImageView;
@property (nonatomic, weak) UILabel *shopNameLabel;
@property (nonatomic, weak) UILabel *orderNumLabel;
@property (nonatomic, weak) UILabel *sheJiShiNameLabel;
@property (nonatomic, weak) UILabel *yuYueDateLabel;
@property (nonatomic, weak) UILabel *stateLabel;

@end

@implementation YuYueCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (YuYueCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"YuYueCell";
    YuYueCell *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[YuYueCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)drawView
{
    UIImageView *iconImageView = [[UIImageView alloc] init];
    //iconImageView.image = [UIImage imageNamed:@"default"];
    iconImageView.image = [UIImage imageNamed:@"touxiang"];
    [self.contentView addSubview:iconImageView];
    self.iconImageView = iconImageView;
    
    UILabel *shopNameLabel = [[UILabel alloc] init];
    shopNameLabel.font = [UIFont systemFontOfSize:14];
    shopNameLabel.textColor = HEXCOLOR(0x333333);
    shopNameLabel.text = @"阳光店";
    [self.contentView addSubview:shopNameLabel];
    self.shopNameLabel = shopNameLabel;
    
    UILabel *orderNumLabel = [[UILabel alloc] init];
    orderNumLabel.font = [UIFont systemFontOfSize:10];
    orderNumLabel.textColor = HEXCOLOR(0x333333);
    orderNumLabel.text = @"订单号：201611110001";
    orderNumLabel.textAlignment = NSTextAlignmentRight;
    orderNumLabel.hidden = YES;
    [self.contentView addSubview:orderNumLabel];
    self.orderNumLabel = orderNumLabel;
    
    UILabel *sheJiShiNameLabel = [[UILabel alloc] init];
    sheJiShiNameLabel.font = [UIFont systemFontOfSize:10];
    sheJiShiNameLabel.textColor = HEXCOLOR(0x333333);
    sheJiShiNameLabel.text = @"预约设计师：大强哥";
    [self.contentView addSubview:sheJiShiNameLabel];
    self.sheJiShiNameLabel = sheJiShiNameLabel;
    
    UILabel *yuYueDateLabel = [[UILabel alloc] init];
    yuYueDateLabel.font = [UIFont systemFontOfSize:10];
    yuYueDateLabel.textColor = HEXCOLOR(0x333333);
    yuYueDateLabel.text = @"预约时间：2016年11月11日 10:12";
    [self.contentView addSubview:yuYueDateLabel];
    self.yuYueDateLabel = yuYueDateLabel;
    
    UILabel *stateLabel = [[UILabel alloc] init];
    stateLabel.font = [UIFont systemFontOfSize:12];
    stateLabel.textColor = HEXCOLOR(0xe31830);
    stateLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:stateLabel];
    self.stateLabel = stateLabel;
    
    iconImageView.sd_layout
    .leftSpaceToView(self.contentView,20)
    .centerYEqualToView(self.contentView)
    .widthIs(70)
    .heightIs(70);
    iconImageView.sd_cornerRadiusFromWidthRatio = @(0.5);
    
    shopNameLabel.sd_layout
    .leftSpaceToView(iconImageView,15)
    .topEqualToView(iconImageView)
    .heightIs(20)
    .widthIs(70);
    
    orderNumLabel.sd_layout
    .leftSpaceToView(shopNameLabel,15)
    .rightSpaceToView(self.contentView,15)
    .topEqualToView(shopNameLabel)
    .heightIs(15);
    
    yuYueDateLabel.sd_layout
    .leftEqualToView(shopNameLabel)
    .bottomEqualToView(iconImageView)
    .rightSpaceToView(self.contentView,15)
    .heightIs(15);
    
    stateLabel.sd_layout
    .bottomSpaceToView(yuYueDateLabel,5)
    .rightSpaceToView(self.contentView,15)
    .heightIs(15)
    .widthIs(50);
    
    sheJiShiNameLabel.sd_layout
    .leftEqualToView(yuYueDateLabel)
    .bottomSpaceToView(yuYueDateLabel,5)
    .heightIs(15)
    .rightSpaceToView(stateLabel,5);
}

- (void)setModel:(ModelHealthBooking *)model
{
    _model = model;
    
    [self.iconImageView sd_setImageWithURL:IMAGE_URL(model.portrait) placeholderImage:[UIImage imageNamed:@"touxiang"]];
    
    self.shopNameLabel.text = model.name;
    self.sheJiShiNameLabel.text = [NSString stringWithFormat:@"预约调理师：%@",[ModelMember sharedMemberMySelf].name];
    self.yuYueDateLabel.text = [NSString stringWithFormat:@"%@",model.book_start_time];
    
    if ([model.book_result isEqualToString:@"0"]) {
        self.stateLabel.text = @"未完成";
    }else{
        self.stateLabel.text = @"已完成";
    }
}

@end
