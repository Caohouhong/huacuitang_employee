//
//  GuKeDetailCell2.m
//  华粹堂-员工端
//
//  Created by 李强 on 2017/2/21.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "GuKeDetailCell2.h"

@implementation GuKeDetailCell2


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (GuKeDetailCell2 *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"GuKeDetailCell2";
    GuKeDetailCell2 *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[GuKeDetailCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)drawView
{
    NSArray *array = @[@"账户信息",@"客户资料",@"生活起居",@"气医亚健康",@"体质辩证",@"调理备忘",@"复诊跟踪",@"高科技跟踪",@"月度规划",@"体检报告",@"私密生活",@"私密话题",@"回访记录"];
    
    for (int i = 0; i < array.count; i ++)
    {
        [self drawBtnWithTitle:array[i] image:[UIImage imageNamed:array[i]] tag:10000+i];
    }
    
    UIView *lineView1 = [[UIView alloc] init];
    lineView1.backgroundColor = HEXCOLOR(0xeeeeee);
    [self.contentView addSubview:lineView1];
    
    UIView *lineView2 = [[UIView alloc] init];
    lineView2.backgroundColor = HEXCOLOR(0xeeeeee);
    [self.contentView addSubview:lineView2];
    
    UIView *lineView3 = [[UIView alloc] init];
    lineView3.backgroundColor = HEXCOLOR(0xeeeeee);
    [self.contentView addSubview:lineView3];
    
    UIView *lineView4 = [[UIView alloc] init];
    lineView4.backgroundColor = HEXCOLOR(0xeeeeee);
    [self.contentView addSubview:lineView4];
    
    UIView *lineView5 = [[UIView alloc] init];
    lineView5.backgroundColor = HEXCOLOR(0xeeeeee);
    [self.contentView addSubview:lineView5];
    
    UIView *lineView6 = [[UIView alloc] init];
    lineView6.backgroundColor = HEXCOLOR(0xeeeeee);
    [self.contentView addSubview:lineView6];
    
    lineView1.sd_layout
    .leftSpaceToView(self.contentView,(ScreenWidth - 30 - 3)/4 + 15)
    .topSpaceToView(self.contentView,10)
    .widthIs(1)
    .bottomSpaceToView(self.contentView,10);
    
    lineView2.sd_layout
    .leftSpaceToView(lineView1,(ScreenWidth - 30 - 3)/4)
    .topSpaceToView(self.contentView,10)
    .widthIs(1)
    .bottomSpaceToView(self.contentView,10);
    
    lineView3.sd_layout
    .leftSpaceToView(lineView2,(ScreenWidth - 30 - 3)/4)
    .topSpaceToView(self.contentView,10)
    .widthIs(1)
    .bottomSpaceToView(self.contentView,10);
    
    lineView4.sd_layout
    .leftSpaceToView(self.contentView,10)
    .topSpaceToView(self.contentView,(ScreenWidth - 30 - 3)/4 + 15)
    .heightIs(1)
    .rightSpaceToView(self.contentView,10);
    
    lineView5.sd_layout
    .leftSpaceToView(self.contentView,10)
    .topSpaceToView(lineView4,(ScreenWidth - 30 - 3)/4)
    .heightIs(1)
    .rightSpaceToView(self.contentView,10);
    
    lineView6.sd_layout
    .leftSpaceToView(self.contentView,10)
    .topSpaceToView(lineView5,(ScreenWidth - 30 - 3)/4)
    .heightIs(1)
    .rightSpaceToView(self.contentView,10);
}

- (void)drawBtnWithTitle:(NSString *)title image:(UIImage *)image tag:(int)tag
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    btn.tag = tag;
    
    tag -= 10000;
    long columnIndex = tag % 4;
    long rowIndex = tag / 4;
    CGFloat itemW = (ScreenWidth - 30 - 3)/4;
    CGFloat itemH = (ScreenWidth - 30 - 3)/4;
    btn.frame = CGRectMake(columnIndex * (itemW + 1) + 15, rowIndex * (itemH + 1) + 15, itemW, itemH);
    
    [self.contentView addSubview:btn];
    [btn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
}

- (void)buttonAction:(UIButton *)button
{
    if (self.delegate){
        [self.delegate guKeDetailBtnActionWithTag:(int)button.tag];
    }
}

@end
