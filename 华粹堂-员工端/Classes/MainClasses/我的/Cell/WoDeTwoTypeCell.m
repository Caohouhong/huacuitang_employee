//
//  WoDeTwoTypeCell.m
//  华粹堂-员工端
//
//  Created by liqiang on 2016/11/14.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import "WoDeTwoTypeCell.h"

@implementation WoDeTwoTypeCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (WoDeTwoTypeCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"WoDeTwoTypeCell";
    WoDeTwoTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[WoDeTwoTypeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)drawView
{
    UIImageView *iconImageView = [[UIImageView alloc] init];
    iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:iconImageView];
    self.iconImageView = iconImageView;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textColor = HEXCOLOR(0x333333);
    titleLabel.text = @"飒飒大师的";
    [self.contentView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UILabel *detailLabel = [[UILabel alloc] init];
    detailLabel.font = [UIFont systemFontOfSize:16];
    detailLabel.textColor = HEXCOLOR(0x333333);
    detailLabel.text = @"飒飒大师的";
    detailLabel.hidden = YES;
    detailLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:detailLabel];
    self.detailLabel = detailLabel;
    
    UIImageView *arrowImageView = [[UIImageView alloc] init];
    arrowImageView.image = [UIImage imageNamed:@"advance"];
    [self.contentView addSubview:arrowImageView];
    self.arrowImageView = arrowImageView;
    
    iconImageView.sd_layout
    .leftSpaceToView(self.contentView,40)
    .centerYEqualToView(self.contentView)
    .widthIs(30)
    .heightIs(30);
    
    titleLabel.sd_layout
    .leftSpaceToView(iconImageView,15)
    .topSpaceToView(self.contentView,0)
    .bottomSpaceToView(self.contentView,0)
    .widthIs(100);
    
    arrowImageView.sd_layout
    .rightSpaceToView(self.contentView,20)
    .centerYEqualToView(self.contentView)
    .widthIs(11)
    .heightIs(20);
    
    detailLabel.sd_layout
    .rightSpaceToView(self.contentView,20)
    .centerYEqualToView(self.contentView)
    .widthIs(150)
    .heightIs(20);
}

@end
