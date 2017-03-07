//
//  GuKeMainListCell.m
//  华粹堂-员工端
//
//  Created by liqiang on 2016/11/25.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import "GuKeMainListCell.h"

@interface GuKeMainListCell ()
{
    
}
@property (nonatomic, weak) UIImageView *iconImageView;
@property (nonatomic, weak) UIImageView *genderImageView;;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *numLabel;
@property (nonatomic, weak) UILabel *ageLabel;
@property (nonatomic, weak) UILabel *tiaoLiShiLabel;
@property (nonatomic, weak) UILabel *mengDianLabel;

@end

@implementation GuKeMainListCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (GuKeMainListCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"GuKeMainListCell";
    GuKeMainListCell *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[GuKeMainListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)drawView
{
//    [self addUnderlineWithLeftMargin:0];
    
    UIImageView *iconImageView = [[UIImageView alloc] init];
    iconImageView.image = [UIImage imageNamed:@"default"];
    [self.contentView addSubview:iconImageView];
    self.iconImageView = iconImageView;
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = [UIFont systemFontOfSize:15];
    nameLabel.textColor = HEXCOLOR(0x333333);
    nameLabel.text = @"名字";
    [self.contentView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    UIImageView *genderImageView = [[UIImageView alloc] init];
    genderImageView.image = [UIImage imageNamed:@"icon_boy"];
    [self.contentView addSubview:genderImageView];
    self.genderImageView = genderImageView;
    
    UILabel *ageLabel = [[UILabel alloc] init];
    ageLabel.font = [UIFont systemFontOfSize:15];
    ageLabel.textColor = HEXCOLOR(0x333333);
    ageLabel.text = @"0岁";
    [self.contentView addSubview:ageLabel];
    self.ageLabel = ageLabel;
    
    
    UIImageView *tiaoLiShiImageView = [[UIImageView alloc] init];
    tiaoLiShiImageView.image = [UIImage imageNamed:@"icon_tiaolishi"];
    [self.contentView addSubview:tiaoLiShiImageView];
    
    
    UILabel *tiaoLiShiLabel = [[UILabel alloc] init];
    tiaoLiShiLabel.font = [UIFont systemFontOfSize:14];
    tiaoLiShiLabel.textColor = HEXCOLOR(0x333333);
    tiaoLiShiLabel.text = @"";
    [self.contentView addSubview:tiaoLiShiLabel];
    self.tiaoLiShiLabel = tiaoLiShiLabel;
    
    UIImageView *mengDianImageView = [[UIImageView alloc] init];
    mengDianImageView.image = [UIImage imageNamed:@"icon_mendian"];
    [self.contentView addSubview:mengDianImageView];
    
    UILabel *mengDianLabel = [[UILabel alloc] init];
    mengDianLabel.font = [UIFont systemFontOfSize:14];
    mengDianLabel.textColor = HEXCOLOR(0x333333);
    mengDianLabel.text = @"";
    [self.contentView addSubview:mengDianLabel];
    self.mengDianLabel = mengDianLabel;
    
    UILabel *numLabel = [[UILabel alloc] init];
    numLabel.font = [UIFont systemFontOfSize:15];
    numLabel.textColor = HEXCOLOR(0x666666);
//    [self.contentView addSubview:numLabel];
    self.numLabel = numLabel;
    
    UIImageView *arrowImageView = [[UIImageView alloc] init];
    arrowImageView.image = [UIImage imageNamed:@"g_arrow_blue_9x15"];
    [self.contentView addSubview:arrowImageView];
    
    arrowImageView.sd_layout
    .rightSpaceToView(self.contentView,10)
    .centerYEqualToView(self.contentView)
    .widthIs(9)
    .heightIs(15);
    
    iconImageView.sd_layout
    .leftSpaceToView(self.contentView,15)
    .centerYEqualToView(self.contentView)
    .widthIs(60)
    .heightIs(60);
    iconImageView.sd_cornerRadiusFromWidthRatio = @(0.5);
    
    nameLabel.sd_layout
    .leftSpaceToView(iconImageView,15)
    .topSpaceToView(self.contentView,15)
    .heightIs(20);
    [nameLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    genderImageView.sd_layout
    .leftSpaceToView(nameLabel,10)
    .centerYEqualToView(nameLabel)
    .widthIs(12)
    .heightIs(12);
    
    ageLabel.sd_layout
    .leftSpaceToView(genderImageView,5)
    .centerYEqualToView(genderImageView)
    .heightIs(20);
    [ageLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    tiaoLiShiImageView.sd_layout
    .leftEqualToView(nameLabel)
    .bottomSpaceToView(self.contentView,15)
    .widthIs(94/2)
    .heightIs(33/2);
    
    tiaoLiShiLabel.sd_layout
    .leftSpaceToView(tiaoLiShiImageView,5)
    .centerYEqualToView(tiaoLiShiImageView)
    .heightIs(33/2);
    [tiaoLiShiLabel setSingleLineAutoResizeWithMaxWidth:80];
    
    mengDianImageView.sd_layout
    .leftSpaceToView(tiaoLiShiLabel,15)
    .bottomSpaceToView(self.contentView,15)
    .widthIs(73/2)
    .heightIs(33/2);
    
    mengDianLabel.sd_layout
    .leftSpaceToView(mengDianImageView,5)
    .centerYEqualToView(mengDianImageView)
    .heightIs(33/2);
    [mengDianLabel setSingleLineAutoResizeWithMaxWidth:80];
    
    numLabel.sd_layout
    .leftEqualToView(nameLabel)
    .bottomSpaceToView(self.contentView,15)
    .heightRatioToView(nameLabel,1)
    .rightEqualToView(nameLabel);
}

- (void)setModel:(ModelGuKe *)model
{
    _model = model;
    
    [self.iconImageView sd_setImageWithURL:IMAGE_URL(model.portrait) placeholderImage:[UIImage imageNamed:@"default"]];
    self.nameLabel.text = model.name;
    //性别
    self.genderImageView.image = [UIImage imageNamed:([@"0" isEqualToString:model.sex]) ? @"icon_boy" : @"icon_girl"];
    
    self.ageLabel.text = [NSString stringWithFormat:@"%@岁",model.customerAge?model.customerAge:@"18"];

    self.tiaoLiShiLabel.text = [NSString stringWithFormat:@"%@",model.ename?model.ename:@""];
    
    self.mengDianLabel.text = [NSString stringWithFormat:@"%@",model.shopName?model.shopName:@""];
}

@end
