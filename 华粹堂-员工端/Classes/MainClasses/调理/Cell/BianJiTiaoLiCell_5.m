//
//  BianJiTiaoLiCell_5.m
//  华粹堂-员工端
//
//  Created by liqiang on 2016/11/16.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import "BianJiTiaoLiCell_5.h"


@interface BianJiTiaoLiCell_5()
@property (nonatomic, weak) UITextView * textView;
@property (nonatomic, weak) UILabel *timeLabel;
@end
@implementation BianJiTiaoLiCell_5


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (BianJiTiaoLiCell_5 *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"BianJiTiaoLiCell_5";
    BianJiTiaoLiCell_5 *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[BianJiTiaoLiCell_5 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)drawView
{
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = HEXCOLOR(0x333333);
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"业务经理意见";
    [self.contentView addSubview:label];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = backviewColor;
    [self.contentView addSubview:lineView];
    
    UITextView *textView = [[UITextView alloc] init];
    textView.font = [UIFont systemFontOfSize:14];
    textView.text = @"业务经理意见： 回家好好治病";
    textView.layer.borderColor = HEXCOLOR(0x666666).CGColor;
    textView.layer.borderWidth = 0.5;
    [self.contentView addSubview:textView];
    self.textView = textView;
    
    UILabel *tiaoLiShiLabel = [[UILabel alloc] init];
    tiaoLiShiLabel.font = [UIFont systemFontOfSize:12];
    tiaoLiShiLabel.textColor = HEXCOLOR(0x666666);
    tiaoLiShiLabel.text = @"审核时间： 2016-11-25 00:22";
    tiaoLiShiLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:tiaoLiShiLabel];
    self.timeLabel = tiaoLiShiLabel;
    
    label.sd_layout
    .leftSpaceToView(self.contentView,10)
    .topSpaceToView(self.contentView,5)
    .rightSpaceToView(self.contentView,10)
    .heightIs(18);
    
    lineView.sd_layout
    .leftSpaceToView(self.contentView,0)
    .topSpaceToView(label,8)
    .rightSpaceToView(self.contentView,0)
    .heightIs(1);
    
    textView.sd_layout
    .leftEqualToView(label)
    .rightSpaceToView(self.contentView,10)
    .topSpaceToView(lineView,15)
    .heightIs(120);
    
    tiaoLiShiLabel.sd_layout
    .rightSpaceToView(self.contentView,10)
    .topSpaceToView(textView,7)
    .heightIs(15);
    [tiaoLiShiLabel setSingleLineAutoResizeWithMaxWidth:200];

}


-(void)setModel:(ModelTrackManage *)model {
    _model = model;
    
    
    self.textView.text = [NSString stringWithFormat:@"业务经理意见：%@", TSTRING_NOT_EMPTY(model.dean_check_view)?model.dean_check_view:@""];
    self.timeLabel.text = [NSString stringWithFormat:@"审核时间：%@", TSTRING_NOT_EMPTY(model.dean_check_date)?model.dean_check_date:@""];
}


@end
