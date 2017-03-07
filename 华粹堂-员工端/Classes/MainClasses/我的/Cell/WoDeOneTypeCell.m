//
//  WoDeOneTypeCell.m
//  华粹堂-员工端
//
//  Created by liqiang on 2016/11/14.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import "WoDeOneTypeCell.h"

@interface WoDeOneTypeCell ()

@property (nonatomic, weak) UIImageView *iconImageView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *telNumLabel;
@property (nonatomic, weak) UIImageView *genderImageView;

@end

@implementation WoDeOneTypeCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (WoDeOneTypeCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"WoDeOneTypeCell";
    WoDeOneTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[WoDeOneTypeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)drawView
{
    UIImageView *iconImageView = [[UIImageView alloc] init];
//    iconImageView.image = [UIImage imageNamed:<#name#>];
    //iconImageView.backgroundColor = [UIColor redColor];
    iconImageView.image = [UIImage imageNamed:@"touxiang"];
    [self.contentView addSubview:iconImageView];
    self.iconImageView = iconImageView;
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = [UIFont systemFontOfSize:16];
    nameLabel.textColor = HEXCOLOR(0x333333);
    nameLabel.text = @"大强哥";
    [self.contentView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    UILabel *telNumLabel = [[UILabel alloc] init];
    telNumLabel.font = [UIFont systemFontOfSize:14];
    telNumLabel.textColor = HEXCOLOR(0x333333);
    telNumLabel.text = @"12345678909";
    [self.contentView addSubview:telNumLabel];
    self.telNumLabel = telNumLabel;
    
    UIImageView *genderImageView = [[UIImageView alloc] init];
    genderImageView.image = [UIImage imageNamed:@"boy"];
    genderImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:genderImageView];
    self.genderImageView = genderImageView;
    
    UIImageView *arrowImageView = [[UIImageView alloc] init];
    arrowImageView.image = [UIImage imageNamed:@"advance"];
    [self.contentView addSubview:arrowImageView];
    
    UIView *centerView = [[UIView alloc] init];
    centerView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:centerView];
    
    centerView.sd_layout
    .leftSpaceToView(self.contentView,0)
    .rightSpaceToView(self.contentView,0)
    .centerYEqualToView(self.contentView)
    .heightIs(0.05);
    
    iconImageView.sd_layout
    .leftSpaceToView(self.contentView,10)
    .centerYEqualToView(self.contentView)
    .widthIs(60)
    .heightIs(60);
    iconImageView.sd_cornerRadiusFromWidthRatio = @(0.5);
    
    nameLabel.sd_layout
    .leftSpaceToView(iconImageView,15)
    .bottomSpaceToView(centerView,5)
    .heightIs(20);
    [nameLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    genderImageView.sd_layout
    .leftSpaceToView(nameLabel,15)
    .centerYEqualToView(nameLabel)
    .heightIs(10)
    .widthIs(10);
    
    telNumLabel.sd_layout
    .leftEqualToView(nameLabel)
    .topSpaceToView(centerView,10)
    .rightSpaceToView(self.contentView,15)
    .heightIs(20);
    
    arrowImageView.sd_layout
    .rightSpaceToView(self.contentView,10)
    .centerYEqualToView(self.contentView)
    .widthIs(11)
    .heightIs(20);
}

- (void)setModel:(ModelMember *)model
{
    _model = model;
    
    [self.iconImageView sd_setImageWithURL:IMAGE_URL(model.portrait) placeholderImage:[UIImage imageNamed:@"touxiang"]];
    self.nameLabel.text = model.name;
    self.telNumLabel.text = model.telephone;
    self.genderImageView.image = [UIImage imageNamed:[model.sex isEqualToString:@"0"]?@"boy":@"girl"];
}

@end
