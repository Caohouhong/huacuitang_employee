//
//  MainThreeTypeCell.m
//  华粹堂-员工端
//
//  Created by liqiang on 2016/11/14.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import "MainThreeTypeCell.h"

@implementation MainThreeTypeCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.contentView.backgroundColor = HEXCOLOR(0xeeeeee);
        [self drawView];
    }
    
    return self;
}

+ (MainThreeTypeCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"MainThreeTypeCell";
    MainThreeTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[MainThreeTypeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)drawView
{
    UIView *bgv1 = [[UIView alloc] init];
    bgv1.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:bgv1];
    
    UIView *bgv2 = [[UIView alloc] init];
    bgv2.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:bgv2];
    
    UIView *bgv3 = [[UIView alloc] init];
    bgv3.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:bgv3];
    
    UIView *bgv4 = [[UIView alloc] init];
    bgv4.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:bgv4];
    
    MainThreeTypeView *view1 = [[MainThreeTypeView alloc] init];
    view1.label.text = @"今日预约";
    [bgv1 addSubview:view1];
    
    MainThreeTypeView *view2 = [[MainThreeTypeView alloc] init];
    view2.label.text = @"调理";
    [bgv2 addSubview:view2];
    
    MainThreeTypeView *view3 = [[MainThreeTypeView alloc] init];
    view3.label.text = @"回访";
    [bgv3 addSubview:view3];
    
    MainThreeTypeView *view4 = [[MainThreeTypeView alloc] init];
    view4.label.text = @"顾客";
    [bgv4 addSubview:view4];
    
    UIImageView *arrowImageView = [[UIImageView alloc] init];
    arrowImageView.image = [UIImage imageNamed:@"advance"];
    [self.contentView addSubview:arrowImageView];
    
    bgv1.sd_layout
    .leftSpaceToView(self.contentView,0)
    .topSpaceToView(self.contentView,10)
    .widthIs((ScreenWidth - 10)/2)
    .heightEqualToWidth();
    
    bgv2.sd_layout
    .leftSpaceToView(bgv1,10)
    .topSpaceToView(self.contentView,10)
    .widthIs((ScreenWidth - 10)/2)
    .heightEqualToWidth();
    
    bgv3.sd_layout
    .leftSpaceToView(self.contentView,0)
    .topSpaceToView(bgv1,10)
    .widthIs((ScreenWidth - 10)/2)
    .heightEqualToWidth();
    
    bgv4.sd_layout
    .leftSpaceToView(bgv1,10)
    .topSpaceToView(bgv2,10)
    .widthIs((ScreenWidth - 10)/2)
    .heightEqualToWidth();
    
    view1.sd_layout
    .centerXEqualToView(bgv1)
    .centerYEqualToView(bgv1)
    .widthIs(70)
    .heightIs(100);
    
    view2.sd_layout
    .centerXEqualToView(bgv2)
    .centerYEqualToView(bgv2)
    .widthIs(70)
    .heightIs(100);
    
    view3.sd_layout
    .centerXEqualToView(bgv3)
    .centerYEqualToView(bgv3)
    .widthIs(70)
    .heightIs(100);
    
    view4.sd_layout
    .centerXEqualToView(bgv4)
    .centerYEqualToView(bgv4)
    .widthIs(70)
    .heightIs(100);
    
    arrowImageView.sd_layout
    .rightSpaceToView(self.contentView,10)
    .centerYEqualToView(self.contentView)
    .widthIs(11)
    .heightIs(20);
}

@end

@implementation MainThreeTypeView

- (instancetype)init
{
    if (self = [super init])
    {
        [self drawView];
    }
    
    return self;
}

- (void)drawView
{
    UIImageView *iconImageView = [[UIImageView alloc] init];
//    iconImageView.image = [UIImage imageNamed:<#name#>];
    iconImageView.backgroundColor = [UIColor redColor];
    [self addSubview:iconImageView];
    self.iconImageView = iconImageView;
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = [UIFont systemFontOfSize:16];
    nameLabel.textColor = HEXCOLOR(0x333333);
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:nameLabel];
    self.label = nameLabel;
    
    iconImageView.sd_layout
    .topSpaceToView(self,0)
    .leftSpaceToView(self,0)
    .rightSpaceToView(self,0)
    .heightEqualToWidth();
    
    nameLabel.sd_layout
    .leftSpaceToView(self,0)
    .bottomSpaceToView(self,0)
    .rightSpaceToView(self,0)
    .heightIs(20);
}

@end
