//
//  CheckDetailTableViewCell.m
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/28.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "CheckDetailTableViewCell.h"

@implementation CheckDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (CheckDetailTableViewCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"CheckDetailTableViewCell";
    CheckDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[CheckDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}
- (void)drawView{
    
    _topImageView = [[UIImageView alloc] init];
    _topImageView.image = [UIImage imageNamed:@"g_check_20x20"];
    [self.contentView addSubview:_topImageView];
    
    _leftLabel = [[UILabel alloc] init];
    _leftLabel.font = [UIFont systemFontOfSize:15];
    _leftLabel.textColor = COLOR_Black;
    [self.contentView addSubview:_leftLabel];
    
    _bottomLabel = [[UILabel alloc] init];
    _bottomLabel.font = [UIFont systemFontOfSize:14];
    _bottomLabel.textColor = COLOR_Gray;
    _bottomLabel.numberOfLines = 2;
    _bottomLabel.text = @"默认值显示2行，完整的通过“查看”跳转到另一个显示,默认值显示2行，完整的通过“查看”跳转到另一个显示";
    [self.contentView addSubview:_bottomLabel];
    
    UIView *dividerLine = [[UIView alloc] init];
    dividerLine.backgroundColor = backviewColor;
    [self.contentView addSubview:dividerLine];
    
    UIView *dividerLine1 = [[UIView alloc] init];
    dividerLine.backgroundColor = backviewColor;
    [self.contentView addSubview:dividerLine1];

    UIView *dividerLine2 = [[UIView alloc] init];
    dividerLine.backgroundColor = backviewColor;
    [self.contentView addSubview:dividerLine2];
    
    _leftLabel.sd_layout
    .leftSpaceToView(self.contentView,15)
    .topEqualToView(self.contentView)
    .widthIs(150)
    .heightIs(40);
    
    _topImageView.sd_layout
    .rightEqualToView(self.contentView).offset(-15)
    .centerYEqualToView(_leftLabel)
    .widthIs(20).heightIs(20);
    
    dividerLine.sd_layout
    .leftEqualToView(self.contentView)
    .bottomEqualToView(_leftLabel)
    .widthRatioToView(self.contentView,1)
    .heightIs(1);
    
    dividerLine1.sd_layout
    .leftEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .widthRatioToView(self.contentView,1)
    .heightIs(1);
    
    dividerLine2.sd_layout
    .leftEqualToView(self.contentView)
    .topEqualToView(self.contentView)
    .widthRatioToView(self.contentView,1)
    .heightIs(1);
    
    _bottomLabel.sd_layout
    .leftEqualToView(self.contentView).offset(15)
    .bottomEqualToView(self.contentView)
    .widthIs(ScreenWidth - 30)
    .heightIs(50);
}


@end
