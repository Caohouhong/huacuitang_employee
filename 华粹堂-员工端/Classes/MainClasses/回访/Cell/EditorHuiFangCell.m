//
//  EditorHuiFangCell.m
//  华粹堂-员工端
//
//  Created by 唐硕 on 16/11/25.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import "EditorHuiFangCell.h"

@interface EditorHuiFangCell ()

@property (nonatomic, weak) UIImageView *iconImageView;
@property (nonatomic, weak) UILabel *shopNameLabel;
@property (nonatomic, weak) UILabel *sheJiShiNameLabel;
@property (nonatomic, weak) UILabel *yuYueDateLabel;

@end

@implementation EditorHuiFangCell

+(instancetype)cellWithTableview:(UITableView *)tableview {
    static NSString *idenifier = @"EditorHuiFangCell";
    EditorHuiFangCell *cell = [tableview dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[EditorHuiFangCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
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

-(void)clickBQButton {
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
    shopNameLabel.text = @"大硕哥";
    [self.contentView addSubview:shopNameLabel];
    self.shopNameLabel = shopNameLabel;
    
    UIButton *BQButton = [[UIButton alloc]init];
    [BQButton setTitle:@"标签" forState:UIControlStateNormal];
    [BQButton setTitleColor:HEXCOLOR(0xe44751) forState:UIControlStateNormal];
    BQButton.titleLabel.font = TFont(13.0);
    BQButton.layer.cornerRadius = 3.0;
    BQButton.layer.borderColor = HEXCOLOR(0xe44751).CGColor;
    BQButton.layer.borderWidth = 0.5;
    [BQButton addTarget:self action:@selector(clickBQButton) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:BQButton];
    
    UILabel *sheJiShiNameLabel = [[UILabel alloc] init];
    sheJiShiNameLabel.font = [UIFont systemFontOfSize:10];
    sheJiShiNameLabel.textColor = HEXCOLOR(0x333333);
    sheJiShiNameLabel.text = @"预约调理师：大硕哥";
    [self.contentView addSubview:sheJiShiNameLabel];
    self.sheJiShiNameLabel = sheJiShiNameLabel;
    
    UILabel *yuYueDateLabel = [[UILabel alloc] init];
    yuYueDateLabel.font = [UIFont systemFontOfSize:10];
    yuYueDateLabel.textColor = HEXCOLOR(0x333333);
    yuYueDateLabel.text = @"预约时间：2016年11月11日 10:12";
    [self.contentView addSubview:yuYueDateLabel];
    self.yuYueDateLabel = yuYueDateLabel;
    
    
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
    .widthIs(100);
    
    BQButton.sd_layout
    .leftSpaceToView(shopNameLabel,15)
    .topEqualToView(shopNameLabel)
    .heightIs(18)
    .widthIs(50);
    
    yuYueDateLabel.sd_layout
    .leftEqualToView(shopNameLabel)
    .bottomEqualToView(iconImageView)
    .rightSpaceToView(self.contentView,15)
    .heightIs(15);
    
    sheJiShiNameLabel.sd_layout
    .leftEqualToView(yuYueDateLabel)
    .bottomSpaceToView(yuYueDateLabel,5)
    .heightIs(15);
    [sheJiShiNameLabel setSingleLineAutoResizeWithMaxWidth:300];
    
}

-(void)setModel:(HuiFangModel *)model {
    _model = model;
    
    [self.iconImageView sd_setImageWithURL:IMAGE_URL(model.portrait) placeholderImage:[UIImage imageNamed:@"touxiang"]];
    self.shopNameLabel.text = model.customerName;
    self.sheJiShiNameLabel.text = [NSString stringWithFormat:@"预约调理师：%@",[ModelMember sharedMemberMySelf].name];
    self.yuYueDateLabel.text = [NSString stringWithFormat:@"预约时间：%@",TSTRING_NOT_EMPTY(model.visit_time)?model.visit_time:@""];
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
