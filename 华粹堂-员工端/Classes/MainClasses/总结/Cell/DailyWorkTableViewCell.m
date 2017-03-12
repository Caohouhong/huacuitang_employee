//
//  DailyWorkTableViewCell.m
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/27.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "DailyWorkTableViewCell.h"

@implementation DailyWorkTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        //        self.contentView.backgroundColor = HEXCOLOR(0xeeeeee);
        [self drawView];
    }
    
    return self;
}

+ (DailyWorkTableViewCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"DailyWorkTableViewCell";
    DailyWorkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[DailyWorkTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)drawView{
    
    _leftLabel = [[UILabel alloc] init];
    _leftLabel.font = [UIFont systemFontOfSize:15];
    _leftLabel.textColor = COLOR_Black;
    [self.contentView addSubview:_leftLabel];
    
    _rightLabel = [[UILabel alloc] init];
    _rightLabel.font = [UIFont systemFontOfSize:15];
    _rightLabel.textColor = HEXCOLOR(0x666666);
    _rightLabel.textAlignment = NSTextAlignmentRight;
    _rightLabel.text = @"0";
    [self.contentView addSubview:_rightLabel];
    
    _centerLabel = [[UILabel alloc] init];
    _centerLabel.font = [UIFont systemFontOfSize:15];
    _centerLabel.textColor = HEXCOLOR(0x666666);
    _centerLabel.textAlignment = NSTextAlignmentCenter;
    _centerLabel.text = @"0";
    [self.contentView addSubview:_centerLabel];
    
//    UIView *verLine = [[UIView alloc] init];
//    verLine.backgroundColor = backviewColor;
//    [self.contentView addSubview:verLine];
    
    UIView *dividerLine = [[UIView alloc] init];
    dividerLine.backgroundColor = backviewColor;
    [self.contentView addSubview:dividerLine];
    
    _leftLabel.sd_layout
    .leftSpaceToView(self.contentView,15)
    .centerYEqualToView(self.contentView)
    .widthIs(ScreenWidth/3 - 10)
    .heightRatioToView(self.contentView,1);
    
    _centerLabel.sd_layout
    .centerXEqualToView(self.contentView)
    .centerYEqualToView(self.contentView)
    .widthIs(ScreenWidth/3 - 10)
    .heightRatioToView(self.contentView,1);

    _rightLabel.sd_layout
    .rightEqualToView(self.contentView).offset(-15)
    .centerYEqualToView(self.contentView)
    .widthIs(ScreenWidth/3 - 10)
    .heightRatioToView(self.contentView,1);
    
//    verLine.sd_layout
//    .leftEqualToView(_rightLabel).offset(10)
//    .topEqualToView(self.contentView).offset(5)
//    .widthIs(1)
//    .heightIs(30);
    
    dividerLine.sd_layout
    .leftEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .widthRatioToView(self.contentView,1)
    .heightIs(1);
}


@end
