//
//  AccountTableViewCell.m
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/28.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "AccountTableViewCell.h"

@implementation AccountTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        //        self.contentView.backgroundColor = HEXCOLOR(0xeeeeee);
        [self drawView];
    }
    
    return self;
}

+ (AccountTableViewCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"AccountTableViewCell";
    AccountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[AccountTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}
- (void)drawView{
    
    //H 测试，图片不对
    _topImageView = [[UIImageView alloc] init];
    _topImageView.image = [UIImage imageNamed:@"icon_yiwancheng"];
    [self.contentView addSubview:_topImageView];
    
    _leftLabel = [[UILabel alloc] init];
    _leftLabel.font = [UIFont systemFontOfSize:15];
    _leftLabel.textColor = COLOR_darkGray;
    [self.contentView addSubview:_leftLabel];
    
    _rightLabel = [[UILabel alloc] init];
    _rightLabel.font = [UIFont systemFontOfSize:15];
    _rightLabel.textColor = COLOR_darkGray;
    _rightLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_rightLabel];
    
    _arrowImageView = [[UIImageView alloc] init];
    _arrowImageView.image = [UIImage imageNamed:@"g_arrow_blue_9x15"];
    [self.contentView addSubview:_arrowImageView];
    
    UIView *dividerLine = [[UIView alloc] init];
    dividerLine.backgroundColor = backviewColor;
    [self.contentView addSubview:dividerLine];
    
    _topImageView.sd_layout
    .leftSpaceToView(self.contentView,15)
    .centerYEqualToView(self.contentView)
    .widthIs(25).heightIs(25);
    
    _leftLabel.sd_layout
    .leftSpaceToView(_topImageView,10)
    .centerYEqualToView(self.contentView)
    .widthIs(100)
    .heightRatioToView(self.contentView,1);
    
    _arrowImageView.sd_layout
    .rightEqualToView(self.contentView).offset(-15)
    .centerYEqualToView(self.contentView)
    .widthIs(9).heightIs(15);
    
    _rightLabel.sd_layout
    .rightEqualToView(self.contentView).offset(-30)
    .centerYEqualToView(self.contentView)
    .widthIs(150)
    .heightRatioToView(self.contentView,1);
    
    dividerLine.sd_layout
    .leftEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .widthRatioToView(self.contentView,1)
    .heightIs(1);
}

- (void)setModel:(AccountModel *)model
{
    _model = model;
}

@end
