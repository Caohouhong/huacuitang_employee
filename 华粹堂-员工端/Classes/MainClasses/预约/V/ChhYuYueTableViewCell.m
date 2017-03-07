//
//  ChhYuYueTableViewCell.m
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/24.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "ChhYuYueTableViewCell.h"

@implementation ChhYuYueTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        //        self.contentView.backgroundColor = HEXCOLOR(0xeeeeee);
        [self drawView];
    }
    
    return self;
}

+ (ChhYuYueTableViewCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"ChhYuYueTableViewCell";
    ChhYuYueTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[ChhYuYueTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
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
    [self.contentView addSubview:_rightLabel];
    
    UIView *dividerLine = [[UIView alloc] init];
    dividerLine.backgroundColor = backviewColor;
    [self.contentView addSubview:dividerLine];
    
    _leftLabel.sd_layout
    .leftSpaceToView(self.contentView,15)
    .centerYEqualToView(self.contentView)
    .widthIs(ScreenWidth - 30)
    .heightRatioToView(self.contentView,1);
//    [_leftLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    _rightLabel.sd_layout
    .rightEqualToView(self.contentView).offset(-15)
    .centerYEqualToView(self.contentView)
    .widthIs(100)
    .heightRatioToView(self.contentView,1);
    
    
    dividerLine.sd_layout
    .leftEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .widthRatioToView(self.contentView,1)
    .heightIs(1);
}


@end
