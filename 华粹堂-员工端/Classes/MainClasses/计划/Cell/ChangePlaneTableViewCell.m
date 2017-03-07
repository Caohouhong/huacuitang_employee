//
//  ChangePlaneTableViewCell.m
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/27.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "ChangePlaneTableViewCell.h"

@implementation ChangePlaneTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        //        self.contentView.backgroundColor = HEXCOLOR(0xeeeeee);
        [self drawView];
    }
    
    return self;
}

+ (ChangePlaneTableViewCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"ChangePlaneTableViewCell";
    ChangePlaneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[ChangePlaneTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)drawView{
    
    _leftLabel = [[UILabel alloc] init];
    _leftLabel.font = [UIFont systemFontOfSize:15];
    _leftLabel.textAlignment = NSTextAlignmentCenter;
    _leftLabel.textColor = COLOR_Black;
    [self.contentView addSubview:_leftLabel];
    
    _rightTextField = [[UITextField alloc] init];
    _rightTextField.font = [UIFont systemFontOfSize:15];
    _rightTextField.textColor = COLOR_darkGray;
    [self.contentView addSubview:_rightTextField];
    
    UIView *dividerLine = [[UIView alloc] init];
    dividerLine.backgroundColor = backviewColor;
    [self.contentView addSubview:dividerLine];
    
    _leftLabel.sd_layout
    .leftSpaceToView(self.contentView,15)
    .centerYEqualToView(self.contentView)
    .widthIs(40)
    .heightRatioToView(self.contentView,1);
    
    _rightTextField.sd_layout
    .leftSpaceToView(_leftLabel,0)
    .centerYEqualToView(self.contentView)
    .widthIs(ScreenWidth - 70)
    .heightRatioToView(self.contentView,1);
    
    dividerLine.sd_layout
    .leftEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .widthRatioToView(self.contentView,1)
    .heightIs(1);
}

@end
