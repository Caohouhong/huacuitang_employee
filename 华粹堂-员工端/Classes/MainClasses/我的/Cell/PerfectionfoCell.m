//
//  PerfectionfoCell.m
//  lingdaozhe
//
//  Created by liqiang on 16/5/19.
//  Copyright © 2016年 bckj. All rights reserved.
//

#import "PerfectionfoCell.h"

@interface PerfectionfoCell()

@end

@implementation PerfectionfoCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (PerfectionfoCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"PerfectionfoCell";
    PerfectionfoCell *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[PerfectionfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)drawView
{
    UILabel *label = [[UILabel alloc] init];
    label.font = FONT_TEXTSIZE_Big;
    label.textColor = COLOR_Black;
//    label.text = @"头像";
    [self.contentView addSubview:label];
    self.label = label;
    
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.font = FONT_TEXTSIZE_Big;
    contentLabel.textColor = COLOR_Gray;
    contentLabel.text = @"未填写";
    contentLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
    UIImageView *arrowImageView = [[UIImageView alloc] init];
    arrowImageView.image = [UIImage imageNamed:@"advance"];
    [self.contentView addSubview:arrowImageView];
    self.arrowImageView = arrowImageView;
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = COLOR_LineViewColor;
    [self.contentView addSubview:lineView];
    self.lineView = lineView;
    
    label.sd_layout
    .leftSpaceToView(self.contentView,15)
    .topSpaceToView(self.contentView,0)
    .bottomSpaceToView(self.contentView,0)
    .widthIs(80);
    
    arrowImageView.sd_layout
    .rightSpaceToView(self.contentView,10)
    .centerYEqualToView(label)
    .widthIs(11)
    .heightIs(20);
    
    contentLabel.sd_layout
    .rightSpaceToView(self.contentView,32)
    .centerYEqualToView(label)
    .leftSpaceToView(label,10)
    .heightIs(30);
    
    
    lineView.sd_layout
    .leftSpaceToView(self.contentView,10)
    .bottomSpaceToView(self.contentView,0)
    .rightSpaceToView(self.contentView,0)
    .heightIs(0.5);
}

@end
