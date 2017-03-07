//
//  YuYueDetailCell.m
//  华粹堂-员工端
//
//  Created by liqiang on 2016/11/14.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import "YuYueDetailCell.h"
#import "TheLabelViewController.h"

@interface YuYueDetailCell ()

@property (nonatomic, weak) UIImageView *iconImageView;
@property (nonatomic, weak) UILabel *shopNameLabel;
@property (nonatomic, weak) UILabel *telNumLabel;
@property (nonatomic, weak) UILabel *yuYueDateLabel;

@end

@implementation YuYueDetailCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (YuYueDetailCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"YuYueDetailCell";
    YuYueDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[YuYueDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)drawView
{
    UIImageView *iconImageView = [[UIImageView alloc] init];
    //iconImageView.image = [UIImage imageNamed:@"default"];
    iconImageView.image = [UIImage imageNamed:@"touxiang"];
    [self.contentView addSubview:iconImageView];
    self.iconImageView = iconImageView;
    
    UILabel *shopNameLabel = [[UILabel alloc] init];
    shopNameLabel.font = [UIFont systemFontOfSize:14];
    shopNameLabel.textColor = HEXCOLOR(0x333333);
    shopNameLabel.text = @"阳光店";
    [self.contentView addSubview:shopNameLabel];
    self.shopNameLabel = shopNameLabel;
    
    UIButton *tagBtn = [[UIButton alloc] init];
    [tagBtn setTitle:@"标签" forState:UIControlStateNormal];
    [tagBtn setTitleColor:HEXCOLOR(0xe44751) forState:UIControlStateNormal];
    tagBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    tagBtn.backgroundColor = [UIColor clearColor];
    tagBtn.layer.borderColor = HEXCOLOR(0xe44751).CGColor;
    tagBtn.layer.borderWidth = 0.5;
    tagBtn.layer.cornerRadius = 3;
    [tagBtn addTarget:self action:@selector(didClickTagBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:tagBtn];
    
    UILabel *telNumLabel = [[UILabel alloc] init];
    telNumLabel.font = [UIFont systemFontOfSize:10];
    telNumLabel.textColor = HEXCOLOR(0x333333);
    telNumLabel.text = @"电话：12345678909";
    [self.contentView addSubview:telNumLabel];
    self.telNumLabel = telNumLabel;
    
    UILabel *yuYueDateLabel = [[UILabel alloc] init];
    yuYueDateLabel.font = [UIFont systemFontOfSize:10];
    yuYueDateLabel.textColor = HEXCOLOR(0x333333);
    yuYueDateLabel.text = @"预约时间：2016年11月11日 10:12";
    [self.contentView addSubview:yuYueDateLabel];
    self.yuYueDateLabel = yuYueDateLabel;
    
    UIImageView *telImageView = [[UIImageView alloc] init];
    telImageView.image = [UIImage imageNamed:@"telephone"];
    telImageView.contentMode = UIViewContentModeScaleAspectFit;
    telImageView.userInteractionEnabled = YES;
    telImageView.hidden = YES;
    [self.contentView addSubview:telImageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [telImageView addGestureRecognizer:tap];
    
    iconImageView.sd_layout
    .leftSpaceToView(self.contentView,20)
    .centerYEqualToView(self.contentView)
    .widthIs(70)
    .heightIs(70);
    iconImageView.sd_cornerRadiusFromWidthRatio = @(0.5);
    
    shopNameLabel.sd_layout
    .leftSpaceToView(iconImageView,15)
    .topEqualToView(iconImageView)
    .heightIs(20)
    .widthIs(70);
    
    tagBtn.sd_layout
    .leftSpaceToView(shopNameLabel,15)
    .topEqualToView(iconImageView)
    .heightIs(18)
    .widthIs(50);
    
    yuYueDateLabel.sd_layout
    .leftEqualToView(shopNameLabel)
    .bottomEqualToView(iconImageView)
    .rightSpaceToView(self.contentView,15)
    .heightIs(15);
    
    telNumLabel.sd_layout
    .leftEqualToView(yuYueDateLabel)
    .bottomSpaceToView(yuYueDateLabel,5)
    .heightIs(15)
    .widthIs(150);
    
    telImageView.sd_layout
    .rightSpaceToView(self.contentView,15)
    .centerYEqualToView(self.contentView)
    .widthIs(35)
    .heightIs(35);
}

- (void)setModel:(ModelHealthBooking *)model
{
    _model = model;
    
    [self.iconImageView sd_setImageWithURL:IMAGE_URL(model.portrait) placeholderImage:[UIImage imageNamed:@"touxiang"]];
    self.shopNameLabel.text = model.name;
    
    self.telNumLabel.text = [NSString stringWithFormat:@"电话：%@",TSTRING_NOT_EMPTY(model.mobile_phone)?model.mobile_phone:@""];
    self.yuYueDateLabel.text = [NSString stringWithFormat:@"预约时间：%@",model.book_start_time];
}

- (void)didClickTagBtn
{
    TheLabelViewController *vc = [[TheLabelViewController alloc] init];
    vc.c_id = self.model.c_id;
    [DCURLRouter pushViewController:vc animated:YES];
}

- (void)tap
{
    NSLog(@"....");
    if(self.block) {
        self.block();
    }
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.model.mobile_phone]]; //拨号
}

@end
