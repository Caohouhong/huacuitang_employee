//
//  HuiFangBGCell1.m
//  华粹堂-员工端
//
//  Created by 唐硕 on 16/11/28.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import "HuiFangBGCell1.h"

@interface HuiFangBGCell1()
@property (nonatomic, weak) UITextView * textView;
@property (nonatomic, weak) UILabel *timeLabel;
@end

@implementation HuiFangBGCell1

+(instancetype)cellWithTableview:(UITableView *)tableview {
    static NSString *idenifier = @"HuiFangBaoGaoCell";
    HuiFangBGCell1 *cell = [tableview dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil){
        cell = [[HuiFangBGCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
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

-(void)initViews {
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = HEXCOLOR(0x333333);
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"调理师回访";
    [self.contentView addSubview:label];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = backviewColor;
    [self.contentView addSubview:lineView];
    
    UITextView *textView = [[UITextView alloc] init];
    textView.font = [UIFont systemFontOfSize:14];
    textView.text = @"今日调理师内容如下： 你有病要治~";
    textView.layer.borderColor = HEXCOLOR(0x666666).CGColor;
    textView.layer.borderWidth = 0.5;
    textView.userInteractionEnabled = NO;
    [self.contentView addSubview:textView];
    self.textView = textView;
    
    UILabel *tiaoLiShiLabel = [[UILabel alloc] init];
    tiaoLiShiLabel.font = [UIFont systemFontOfSize:12];
    tiaoLiShiLabel.textColor = HEXCOLOR(0x666666);
    tiaoLiShiLabel.text = @"根据今日调理情况： 2016-11-25 00:22";
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

-(void)setModel:(HuiFangModel *)model {
    _model = model;
    
    self.textView.text = [NSString stringWithFormat:@"今日调理师内容如下：%@", model.feedback];
    self.timeLabel.text = [NSString stringWithFormat:@"回访时间:%@", model.visit_time];
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
