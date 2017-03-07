//
//  HuiFangCell.m
//  华粹堂-员工端
//
//  Created by 唐硕 on 16/11/25.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import "HuiFangCell.h"

@interface HuiFangCell()
@property (nonatomic, weak) UIImageView *iconImageView;
@property (nonatomic, weak) UILabel *shopNameLabel;
@property (nonatomic, weak) UILabel *orderNumLabel;
@property (nonatomic, weak) UILabel *sexLabel;
@property (nonatomic, weak) UILabel *stateLabel;
@property (nonatomic, weak) UIImageView *telImageView;
@property (nonatomic, weak) UIButton *huBtn;
@end

@implementation HuiFangCell

+(instancetype)cellWithTableview:(UITableView *)tableview {
    static NSString *idenifier = @"HuiFangCell";
    HuiFangCell *cell = [tableview dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[HuiFangCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initViews];
    }
    return self;
}

-(void)tap {
    if(self.block) {
        self.block();
    }
}

-(void)initViews {
    
    UIImageView *iconImageView = [[UIImageView alloc] init];
    //iconImageView.image = [UIImage imageNamed:@"default"];
    iconImageView.image = [UIImage imageNamed:@"touxiang"];
    
    [self.contentView addSubview:iconImageView];
    self.iconImageView = iconImageView;
    
    UILabel *shopNameLabel = [[UILabel alloc] init];
    shopNameLabel.font = [UIFont systemFontOfSize:14];
    shopNameLabel.textColor = HEXCOLOR(0x333333);
    shopNameLabel.text = @"大强哥";
    [self.contentView addSubview:shopNameLabel];
    self.shopNameLabel = shopNameLabel;
    
    UILabel *orderNumLabel = [[UILabel alloc] init];
    orderNumLabel.font = [UIFont systemFontOfSize:11];
    orderNumLabel.textColor = HEXCOLOR(0x333333);
    orderNumLabel.textAlignment = NSTextAlignmentRight;
    orderNumLabel.text = @"2015-10-10 00:11";
    [self.contentView addSubview:orderNumLabel];
    self.orderNumLabel = orderNumLabel;
    
    UILabel *sexLabel = [[UILabel alloc] init];
    sexLabel.font = [UIFont systemFontOfSize:12];
    sexLabel.textColor = HEXCOLOR(0x333333);
    sexLabel.text = @"男: 55岁";
    [self.contentView addSubview:sexLabel];
    self.sexLabel = sexLabel;

    
    UILabel *stateLabel = [[UILabel alloc] init];
    stateLabel.font = [UIFont systemFontOfSize:12];
    stateLabel.textColor = HEXCOLOR(0xe31830);
    stateLabel.text = @"未填写";
    stateLabel.backgroundColor = [UIColor whiteColor];
    stateLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:stateLabel];
    self.stateLabel = stateLabel;
    
    UIImageView *telImageView = [[UIImageView alloc] init];
    telImageView.image = [UIImage imageNamed:@"telephone"];
    telImageView.contentMode = UIViewContentModeScaleAspectFit;
    telImageView.userInteractionEnabled = YES;
    [self.contentView addSubview:telImageView];
    self.telImageView = telImageView;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [telImageView addGestureRecognizer:tap];
    
    UIButton *huBtn = [[UIButton alloc]init];
    huBtn.backgroundColor = [UIColor clearColor];
    [huBtn setTitle:@"忽略" forState:UIControlStateNormal];
    [huBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    huBtn.titleLabel.font = TFont(15);
    [huBtn addTarget:self action:@selector(clickHuLuo) forControlEvents:UIControlEventTouchUpInside];
    huBtn.hidden = YES;
    [self.contentView addSubview:huBtn];
    self.huBtn = huBtn;
    
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
    
    sexLabel.sd_layout
    .leftEqualToView(shopNameLabel)
    .topSpaceToView(shopNameLabel,8)
    .heightIs(15)
    .widthIs(200);
    
    orderNumLabel.sd_layout
    .leftEqualToView(shopNameLabel)
    .bottomEqualToView(iconImageView)
    .heightIs(15);
    [orderNumLabel setSingleLineAutoResizeWithMaxWidth:250];
    
    stateLabel.sd_layout
    .leftSpaceToView(orderNumLabel,20)
    .centerYEqualToView(orderNumLabel)
    .heightRatioToView(orderNumLabel,1);
    [stateLabel setSingleLineAutoResizeWithMaxWidth:80];
    
    telImageView.sd_layout
    .rightSpaceToView(self.contentView,20)
    .centerYEqualToView(self.contentView)
    .widthIs(35).heightIs(35);

    huBtn.sd_layout
    .rightSpaceToView(self.contentView,10)
    .centerYEqualToView(self.contentView)
    .heightIs(25).widthIs(50);
    
    
}

-(void)clickHuLuo{
    if(self.removeBlock) {
        self.removeBlock();
    }
}

-(void)setModel:(HuiFangModel *)model {
    _model = model;
    
    [self.iconImageView sd_setImageWithURL:IMAGE_URL(model.portrait) placeholderImage:[UIImage imageNamed:@"touxiang"]];
    self.shopNameLabel.text = model.customerName;
    
    
    if([model.sex isEqualToString:@"1"]) {
        self.sexLabel.text = [NSString stringWithFormat:@"女：%@岁",TSTRING_NOT_EMPTY(model.customerAge)?model.customerAge:@""];
    }else {
       self.sexLabel.text = [NSString stringWithFormat:@"男：%@岁",TSTRING_NOT_EMPTY(model.customerAge)?model.customerAge:@""];
    }
    
    self.orderNumLabel.text = [NSString stringWithFormat:@"%@",TSTRING_NOT_EMPTY(model.visit_time)?model.visit_time:@""];
    
    if([model.state isEqualToString:@"1"]) {
        self.stateLabel.text = @"未审核";
//        self.stateLabel.backgroundColor = HEXCOLOR(0xe44751);
        self.stateLabel.textColor = [[UIColor redColor]colorWithAlphaComponent:0.5];
        self.stateLabel.textColor = [UIColor whiteColor];
        self.telImageView.hidden = YES;
        self.huBtn.hidden = NO;
    }

    if([model.state isEqualToString:@"2"]) {
        self.stateLabel.text = @"审核中";
        self.stateLabel.backgroundColor = [UIColor orangeColor];
        self.stateLabel.textColor = [UIColor whiteColor];
        self.telImageView.hidden = NO;
        self.huBtn.hidden = YES;
    }
    if([model.state isEqualToString:@"3"]) {
        self.stateLabel.text = @"已审核";
        self.stateLabel.backgroundColor = [UIColor clearColor];
        self.stateLabel.textColor = [UIColor blueColor];
        self.telImageView.hidden = NO;
        self.huBtn.hidden = YES;
    }

}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
