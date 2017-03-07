//
//  TiaoLiCell.m
//  华粹堂-员工端
//
//  Created by liqiang on 2016/11/14.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import "TiaoLiCell.h"

@interface TiaoLiCell ()

@property (nonatomic, weak) UIImageView *iconImageView;
@property (nonatomic, weak) UILabel *shopNameLabel;
@property (nonatomic, weak) UILabel *orderNumLabel;
@property (nonatomic, weak) UILabel *sheJiShiNameLabel;
@property (nonatomic, weak) UILabel *yuYueDateLabel;
@property (nonatomic, weak) UILabel *stateLabel;
@property (nonatomic, weak) UILabel *menLabel;

@end

@implementation TiaoLiCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (TiaoLiCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"TiaoLiCell";
    TiaoLiCell *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[TiaoLiCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
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
    
    UILabel *menLabel = [[UILabel alloc] init];
    menLabel.font = [UIFont systemFontOfSize:10];
    menLabel.textColor = HEXCOLOR(0x333333);
    menLabel.text = @"门店：无锡奥林";
    [self.contentView addSubview:menLabel];
    self.menLabel = menLabel;
    
    UILabel *shopNameLabel = [[UILabel alloc] init];
    shopNameLabel.font = [UIFont systemFontOfSize:14];
    shopNameLabel.textColor = HEXCOLOR(0x333333);
    shopNameLabel.text = @"大强哥";
    [self.contentView addSubview:shopNameLabel];
    self.shopNameLabel = shopNameLabel;
    
    UILabel *orderNumLabel = [[UILabel alloc] init];
    orderNumLabel.font = [UIFont systemFontOfSize:10];
    orderNumLabel.textColor = HEXCOLOR(0x333333);
    orderNumLabel.textAlignment = NSTextAlignmentRight;
    orderNumLabel.text = @"订单号：201611110001";
    orderNumLabel.hidden = YES;
    [self.contentView addSubview:orderNumLabel];
    self.orderNumLabel = orderNumLabel;
    
    UILabel *sheJiShiNameLabel = [[UILabel alloc] init];
    sheJiShiNameLabel.font = [UIFont systemFontOfSize:10];
    sheJiShiNameLabel.textColor = HEXCOLOR(0x333333);
    sheJiShiNameLabel.text = @"预约调理师：大强哥";
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
    .topSpaceToView(self.contentView,10)
    .heightIs(20)
    .widthIs(70);
    
    menLabel.sd_layout
    .leftSpaceToView(iconImageView,15)
    .topSpaceToView(shopNameLabel,5)
    .heightIs(15)
    .widthIs(200);
    
    orderNumLabel.sd_layout
    .leftSpaceToView(shopNameLabel,15)
    .rightSpaceToView(self.contentView,15)
    .topEqualToView(shopNameLabel)
    .heightIs(15);
    
    stateLabel.sd_layout
    .rightSpaceToView(self.contentView,15)
    .topSpaceToView(menLabel,5)
    .heightRatioToView(sheJiShiNameLabel,1);
    [stateLabel setSingleLineAutoResizeWithMaxWidth:80];
    
    sheJiShiNameLabel.sd_layout
    .leftEqualToView(menLabel)
    .rightSpaceToView(stateLabel,5)
    .centerYEqualToView(stateLabel)
    .heightIs(15);

    yuYueDateLabel.sd_layout
    .leftEqualToView(menLabel)
    .topSpaceToView(sheJiShiNameLabel,5)
    .rightSpaceToView(self.contentView,15)
    .heightIs(15);
    

}

- (void)setModel:(ModelTrackManage *)model
{
    _model = model;
    
    [self.iconImageView sd_setImageWithURL:IMAGE_URL(model.portrait) placeholderImage:[UIImage imageNamed:@"touxiang"]];
    self.shopNameLabel.text = model.customerName;
    self.menLabel.text = [NSString stringWithFormat:@"门店：%@", [ModelMember sharedMemberMySelf].shopName];
    self.sheJiShiNameLabel.text = [NSString stringWithFormat:@"预约调理师：%@",[ModelMember sharedMemberMySelf].name];
    
    self.yuYueDateLabel.text = [NSString stringWithFormat:@"预约时间：%@", TSTRING_NOT_EMPTY(model.track_date)?model.track_date:@""];
    if([model.state isEqualToString:@"1"]) {
        self.stateLabel.text = @"未填写";
        //self.stateLabel.backgroundColor = HEXCOLOR(0xe44751);
       self.stateLabel.backgroundColor = [[UIColor redColor]colorWithAlphaComponent:0.5];
        self.stateLabel.textColor = [UIColor whiteColor];
    }

    if([model.state isEqualToString:@"2"]) {
        self.stateLabel.text = @"审核中";
        self.stateLabel.backgroundColor = [UIColor orangeColor];
        self.stateLabel.textColor = [UIColor whiteColor];
    }
    if([model.state isEqualToString:@"3"]) {
        self.stateLabel.text = @"已审核";
        self.stateLabel.backgroundColor = [UIColor clearColor];
        self.stateLabel.textColor = [UIColor blueColor];
    }

}
@end
