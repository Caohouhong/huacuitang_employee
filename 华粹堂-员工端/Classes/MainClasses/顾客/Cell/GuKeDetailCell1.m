//
//  GuKeDetailCell1.m
//  华粹堂-员工端
//
//  Created by 李强 on 2017/2/21.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "GuKeDetailCell1.h"
#import "HuaCuiTangHelper.h"
@interface GuKeDetailCell1()
{
    UIImageView *iconImageView;
    UILabel *titleLabel;
    UILabel *telNumLabel;
    UILabel *label1;
    UILabel *label2;
    UILabel *label3;
    UILabel *label4;
}
@end

@implementation GuKeDetailCell1


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (GuKeDetailCell1 *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"GuKeDetailCell1";
    GuKeDetailCell1 *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[GuKeDetailCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)drawView
{
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = HEXCOLOR(0x38afed);
    [self.contentView addSubview:lineView];
    
    iconImageView = [[UIImageView alloc] init];
    iconImageView.image = [UIImage imageNamed:@"default"];
    [self.contentView addSubview:iconImageView];
    
    titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor = HEXCOLOR(0x333333);
    titleLabel.text = @"某某  女 18岁";
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:titleLabel];
    
    
    telNumLabel = [[UILabel alloc] init];
    telNumLabel.font = [UIFont systemFontOfSize:14];
    telNumLabel.textColor = HEXCOLOR(0x333333);
    telNumLabel.text = @"电话:";
    telNumLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:telNumLabel];
    
    UIView *infoView = [[UIView alloc] init];
    infoView.backgroundColor = HEXCOLOR(0xf9fafb);
    infoView.layer.borderColor = HEXCOLOR(0x999999).CGColor;
    infoView.layer.borderWidth = 0.5;
    infoView.layer.cornerRadius = 3;
    [self.contentView addSubview:infoView];
    
    
    label1 = [[UILabel alloc] init];
    label1.font = [UIFont systemFontOfSize:12];
    label1.textColor = HEXCOLOR(0x333333);
    label1.text = @"调理师：";
    label1.textAlignment = NSTextAlignmentLeft;
    [infoView addSubview:label1];
    
    label2 = [[UILabel alloc] init];
    label2.font = [UIFont systemFontOfSize:12];
    label2.textColor = HEXCOLOR(0x333333);
    label2.text = @"门店：";
    label2.textAlignment = NSTextAlignmentLeft;
    [infoView addSubview:label2];
    
    label3 = [[UILabel alloc] init];
    label3.font = [UIFont systemFontOfSize:12];
    label3.textColor = HEXCOLOR(0x333333);
    label3.text = @"近三个月到店次数：0次";
    label3.textAlignment = NSTextAlignmentLeft;
    [infoView addSubview:label3];
    
    label4 = [[UILabel alloc] init];
    label4.font = [UIFont systemFontOfSize:12];
    label4.textColor = HEXCOLOR(0x333333);
    label4.text = @"最后到店：";
    label4.textAlignment = NSTextAlignmentLeft;
    [infoView addSubview:label4];
    
    lineView.sd_layout
    .topSpaceToView(self.contentView,0)
    .leftSpaceToView(self.contentView,0)
    .widthIs(5)
    .heightIs(80);
    
    iconImageView.sd_layout
    .leftSpaceToView(lineView,20)
    .topSpaceToView(self.contentView,15)
    .widthIs(60)
    .heightIs(60);
    
    titleLabel.sd_layout
    .leftSpaceToView(iconImageView,15)
    .topEqualToView(iconImageView)
    .rightSpaceToView(self.contentView,15)
    .heightIs(20);
    
    telNumLabel.sd_layout
    .leftEqualToView(titleLabel)
    .topSpaceToView(titleLabel,10)
    .rightEqualToView(titleLabel)
    .heightIs(20);
    
    infoView.sd_layout
    .leftSpaceToView(self.contentView,15)
    .topSpaceToView(iconImageView,15)
    .rightSpaceToView(self.contentView,15)
    .heightIs(110);
    
    label1.sd_layout
    .leftSpaceToView(infoView,15)
    .topSpaceToView(infoView,10)
    .rightSpaceToView(infoView,15)
    .autoHeightRatio(0);
    
    label2.sd_layout
    .leftSpaceToView(infoView,15)
    .topSpaceToView(label1,10)
    .rightSpaceToView(infoView,15)
    .autoHeightRatio(0);
    
    label3.sd_layout
    .leftSpaceToView(infoView,15)
    .topSpaceToView(label2,10)
    .rightSpaceToView(infoView,15)
    .autoHeightRatio(0);
    
    label4.sd_layout
    .leftSpaceToView(infoView,15)
    .topSpaceToView(label3,10)
    .rightSpaceToView(infoView,15)
    .autoHeightRatio(0);
}

- (void)setModel:(ModelGuKe *)model
{
    _model = model;
    
    //头像
   [iconImageView sd_setImageWithURL:IMAGE_URL(model.portrait) placeholderImage:[UIImage imageNamed:@"default"]];
    
    titleLabel.text = [NSString stringWithFormat:@"%@  %@  %@岁",model.name, ([@"0"  isEqualToString:model.sex]) ? @"男" : @"女",model.customerAge?model.customerAge:@"0"];
    
    telNumLabel.text = [NSString stringWithFormat:@"电话：%@",model.mobile_phone?model.mobile_phone:@""];
    
    label1.text = [NSString stringWithFormat:@"调理师：%@",model.ename?model.ename:@""];
    
    label2.text = [NSString stringWithFormat:@"门店：%@",model.shopName?model.shopName:@""];
    
    label3.text = [NSString stringWithFormat:@"近三个月到店次数：%@次",model.last3_into_store_num?model.last3_into_store_num:@"0"];
    
    label4.text = [NSString stringWithFormat:@"最后到店：%@",model.last_into_store_time?model.last_into_store_time:@""];
}
@end
