//
//  BianJiTiaoLiCell_2.m
//  华粹堂-员工端
//
//  Created by liqiang on 2016/11/16.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import "BianJiTiaoLiCell_2.h"

@interface BianJiTiaoLiCell_2 ()

@property (nonatomic, weak) UILabel *label;

@end

@implementation BianJiTiaoLiCell_2


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (BianJiTiaoLiCell_2 *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"BianJiTiaoLiCell_2";
    BianJiTiaoLiCell_2 *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[BianJiTiaoLiCell_2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)drawView
{
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = HEXCOLOR(0x333333);
    label.text = @"调理方案";
    [self.contentView addSubview:label];
    self.label = label;
    
    UILabel *kanlabel = [[UILabel alloc] init];
    kanlabel.font = [UIFont systemFontOfSize:14];
    kanlabel.textColor = [UIColor blueColor];
    kanlabel.text = @"查看";
    [self.contentView addSubview:kanlabel];
    
//    UIImageView *arrowImageView = [[UIImageView alloc] init];
//    arrowImageView.image = [UIImage imageNamed:@"advance"];
//    [self.contentView addSubview:arrowImageView];
    
//    arrowImageView.sd_layout
//    .rightSpaceToView(self.contentView,20)
//    .centerYEqualToView(self.contentView)
//    .widthIs(11)
//    .heightIs(20);
    
    label.sd_layout
    .leftSpaceToView(self.contentView,10)
    .topSpaceToView(self.contentView,0)
    .bottomSpaceToView(self.contentView,0)
    .widthIs(100);
    
    kanlabel.sd_layout
    .rightSpaceToView(self.contentView,10)
    .topSpaceToView(self.contentView,0)
    .bottomSpaceToView(self.contentView,0);
    [kanlabel setSingleLineAutoResizeWithMaxWidth:80];
    
}

- (void)setStr:(NSString *)str
{
    _str = str;
    
    self.label.text = str;
}

@end
