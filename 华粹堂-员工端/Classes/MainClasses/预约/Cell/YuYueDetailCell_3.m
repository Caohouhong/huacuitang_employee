//
//  YuYueDetailCell_3.m
//  华粹堂-员工端
//
//  Created by liqiang on 2016/11/14.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import "YuYueDetailCell_3.h"

@implementation YuYueDetailCell_3


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        
        [self drawView];
    }
    
    return self;
}

+ (YuYueDetailCell_3 *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"YuYueDetailCell_3";
    YuYueDetailCell_3 *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[YuYueDetailCell_3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)drawView
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:@"标记完成" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    btn.backgroundColor = HEXCOLOR(0xe44751);
    btn.userInteractionEnabled = NO;
    btn.layer.cornerRadius = 5;
    [self.contentView addSubview:btn];
    
    btn.sd_layout
    .leftSpaceToView(self.contentView,20)
    .rightSpaceToView(self.contentView,20)
    .topSpaceToView(self.contentView,10)
    .bottomSpaceToView(self.contentView,10);
}
@end
