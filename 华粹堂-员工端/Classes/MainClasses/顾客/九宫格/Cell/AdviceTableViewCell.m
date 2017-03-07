//
//  AdviceTableViewCell.m
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/28.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "AdviceTableViewCell.h"

@implementation AdviceTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self drawView];
    }
    
    return self;
}

+ (AdviceTableViewCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"AdviceTableViewCell";
    AdviceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[AdviceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)drawView{
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = @"院长审核意见";
    _titleLabel.font = SYSTEM_FONT_(15);
    _titleLabel.textColor = COLOR_Black;
    
    UIView *dividerLine1 = [[UIView alloc] init];
    dividerLine1.backgroundColor = COLOR_LineViewColor;
    
    UIView *dividerLine2 = [[UIView alloc] init];
    dividerLine2.backgroundColor = COLOR_LineViewColor;
    
    UIView *dividerLine3 = [[UIView alloc] init];
    dividerLine3.backgroundColor = COLOR_LineViewColor;
    
    _topTextView = [[UITextView alloc] init];
    _topTextView.font = SYSTEM_FONT_(14);
    _topTextView.textColor = COLOR_Gray;
    _topTextView.editable = NO;
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.text = @"审核人：展示";
    _nameLabel.font = SYSTEM_FONT_(12);
    _nameLabel.textColor = COLOR_LightGray;
    
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.text = @"审核时间：2012-12－12";
    _timeLabel.font = SYSTEM_FONT_(12);
    _timeLabel.textColor = COLOR_LightGray;
    
     [self.contentView sd_addSubviews:@[_titleLabel,dividerLine1,dividerLine2,_topTextView,_nameLabel,_timeLabel,dividerLine3]];
    
    _titleLabel.sd_layout
    .leftEqualToView(self.contentView).offset(15)
    .topSpaceToView(self.contentView,0)
    .widthRatioToView(self.contentView,1)
    .heightIs(30);
    
    dividerLine1.sd_layout
    .leftEqualToView(self.contentView)
    .topEqualToView(self.contentView)
    .widthRatioToView(self.contentView,1)
    .heightIs(1);
    
    dividerLine2.sd_layout
    .leftEqualToView(self.contentView)
    .bottomEqualToView(_titleLabel)
    .widthRatioToView(self.contentView,1)
    .heightIs(1);
    
    dividerLine3.sd_layout
    .leftEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .widthRatioToView(self.contentView,1)
    .heightIs(1);
    
    _topTextView.sd_layout
    .leftEqualToView(self.contentView).offset(15)
    .topSpaceToView(_titleLabel,10)
    .widthIs(ScreenWidth - 30)
    .heightIs(60);
    
    _nameLabel.sd_layout
    .leftEqualToView(self.contentView).offset(15)
    .bottomEqualToView(self.contentView)
    .widthIs(100)
    .heightIs(30);
    
    _timeLabel.sd_layout
    .leftSpaceToView(_nameLabel,0)
    .centerYEqualToView(_nameLabel)
    .widthIs(ScreenWidth - 130)
    .heightIs(30);
}
@end
