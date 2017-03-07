//
//  BianJiTiaoLiCell_1.m
//  华粹堂-员工端
//
//  Created by liqiang on 2016/11/16.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import "BianJiTiaoLiCell_1.h"

@interface BianJiTiaoLiCell_1 ()

@property (nonatomic, weak) UIImageView *iconImageView;
@property (nonatomic, weak) UILabel *shopNameLabel;
@property (nonatomic, weak) UILabel *orderNumLabel;
@property (nonatomic, weak) UILabel *sheJiShiNameLabel;
@property (nonatomic, weak) UILabel *yuYueDateLabel;
@property (nonatomic, weak) UILabel *stateLabel;

@end

@implementation BianJiTiaoLiCell_1


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (BianJiTiaoLiCell_1 *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"BianJiTiaoLiCell_1";
    BianJiTiaoLiCell_1 *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[BianJiTiaoLiCell_1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

-(void)clickBQButton {
    if(self.BQblock) {
        self.BQblock();
    }
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
    shopNameLabel.text = @"大强哥";
    [self.contentView addSubview:shopNameLabel];
    self.shopNameLabel = shopNameLabel;
    
    UIButton *BQButton = [[UIButton alloc]init];
    [BQButton setTitle:@"标签" forState:UIControlStateNormal];
    [BQButton setTitleColor:HEXCOLOR(0xe44751) forState:UIControlStateNormal];
    BQButton.titleLabel.font = TFont(13.0);
    BQButton.layer.cornerRadius = 3.0;
    BQButton.layer.borderColor = HEXCOLOR(0xe44751).CGColor;
    BQButton.layer.borderWidth = 0.5;
    [BQButton addTarget:self action:@selector(clickBQButton) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:BQButton];
    
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
    stateLabel.text = @"已回访";
    stateLabel.hidden = YES;
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
    
    BQButton.sd_layout
    .leftSpaceToView(shopNameLabel,15)
    .topEqualToView(shopNameLabel)
    .heightIs(18)
    .widthIs(50);

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
    
    sheJiShiNameLabel.sd_layout
    .leftEqualToView(yuYueDateLabel)
    .bottomSpaceToView(yuYueDateLabel,5)
    .heightIs(15);
    [sheJiShiNameLabel setSingleLineAutoResizeWithMaxWidth:250];
    
    stateLabel.sd_layout
    .leftSpaceToView(sheJiShiNameLabel,15)
    .centerYEqualToView(sheJiShiNameLabel)
    .rightSpaceToView(self.contentView,15)
    .heightRatioToView(sheJiShiNameLabel,1);
}

- (void)setModel:(ModelTrackManage *)model
{
    _model = model;
    
    [self.iconImageView sd_setImageWithURL:IMAGE_URL(model.portrait) placeholderImage:[UIImage imageNamed:@"touxiang"]];
    self.shopNameLabel.text = model.customerName;
    self.sheJiShiNameLabel.text = [NSString stringWithFormat:@"预约调理师：%@",[ModelMember sharedMemberMySelf].name];
    
    self.yuYueDateLabel.text = [NSString stringWithFormat:@"预约时间：%@",TSTRING_NOT_EMPTY(model.track_date)?model.track_date:@""];
    
}

@end
