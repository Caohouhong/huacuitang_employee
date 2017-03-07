//
//  MainOneTypeCell.m
//  华粹堂-员工端
//
//  Created by liqiang on 2016/11/14.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import "MainOneTypeCell.h"

@interface MainOneTypeCell ()

@property (nonatomic, weak) UIImageView *iconImageView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *shopNameLabel;
@property (nonatomic, weak) UILabel *telNumLabel;

@end

@implementation MainOneTypeCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
//        self.contentView.backgroundColor = HEXCOLOR(0xeeeeee);
        [self drawView];
    }
    
    return self;
}

+ (MainOneTypeCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"MainOneTypeCell";
    MainOneTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[MainOneTypeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)drawView
{
    [self addUnderlineWithLeftMargin:10 rightMargin:10 lineHeight:0.5];
    
    UIImageView *iconImageView = [[UIImageView alloc] init];
    iconImageView.image = [UIImage imageNamed:@"touxiang"];
    //iconImageView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:iconImageView];
    self.iconImageView = iconImageView;
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = [UIFont systemFontOfSize:16];
    nameLabel.textColor = HEXCOLOR(0x333333);
    nameLabel.text = @"大强哥";
    [self.contentView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    UILabel *shopNameLabel = [[UILabel alloc] init];
    shopNameLabel.font = [UIFont systemFontOfSize:14];
    shopNameLabel.textColor = HEXCOLOR(0x999999);
    shopNameLabel.text = @"阳光店";
    [self.contentView addSubview:shopNameLabel];
    self.shopNameLabel = shopNameLabel;
    
    UILabel *telNumLabel = [[UILabel alloc] init];
    telNumLabel.font = [UIFont systemFontOfSize:14];
    telNumLabel.textColor = HEXCOLOR(0x999999);
    telNumLabel.text = @"调理师";
    [self.contentView addSubview:telNumLabel];
    self.telNumLabel = telNumLabel;
    
    UIImageView *levelImageView = [[UIImageView alloc] init];
    levelImageView.image = [UIImage imageNamed:@"icon_sanxing"];
    [self.contentView addSubview:levelImageView];
    
    UIView *centerView = [[UIView alloc] init];
    centerView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:centerView];
    
    centerView.sd_layout
    .leftSpaceToView(self.contentView,0)
    .rightSpaceToView(self.contentView,0)
    .centerYEqualToView(self.contentView)
    .heightIs(0.05);
    
    iconImageView.sd_layout
    .leftSpaceToView(self.contentView,20)
    .centerYEqualToView(self.contentView)
    .heightIs(60)
    .widthIs(60);
    iconImageView.sd_cornerRadiusFromWidthRatio = @(0.5);
    
    nameLabel.sd_layout
    .leftSpaceToView(iconImageView,20)
    .bottomSpaceToView(centerView,5)
    .heightIs(20);
    [nameLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    shopNameLabel.sd_layout
    .leftEqualToView(nameLabel)
    .topSpaceToView(centerView,5)
    .widthIs(150)
    .heightIs(20);
    
    telNumLabel.sd_layout
    .leftSpaceToView(nameLabel,10)
    .centerYEqualToView(nameLabel)
    .heightIs(20);
    [telNumLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    levelImageView.sd_layout
    .leftSpaceToView(telNumLabel,15)
    .topEqualToView(telNumLabel)
    .heightIs(22)
    .widthIs(40);
}

- (void)setModel:(ModelMember *)model
{
    _model = model;
    
    [self.iconImageView sd_setImageWithURL:IMAGE_URL(model.portrait) placeholderImage:[UIImage imageNamed:@"touxiang"]];
    self.nameLabel.text = model.name;
    self.shopNameLabel.text = [NSString stringWithFormat:@"门店：%@",model.shopName];
//    self.telNumLabel.text = model.telephone;
    
}

@end
