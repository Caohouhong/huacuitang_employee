//
//  ServeTableViewCell.m
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/22.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "ServeTableViewCell.h"
#import "HuaCuiTangHelper.h"

@interface ServeTableViewCell(){
    
}
@property (nonatomic, strong) UILabel *leftTopLabel;
@property (nonatomic, strong) UILabel *rightLabel;
@property (nonatomic, strong) UILabel *leftBottomLabel;
@end

@implementation ServeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        //        self.contentView.backgroundColor = HEXCOLOR(0xeeeeee);
        [self drawView];
    }
    
    return self;
}

+ (ServeTableViewCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"ServeTableViewCell";
    ServeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[ServeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}
- (void)drawView{
    
    _leftTopLabel = [[UILabel alloc] init];
    _leftTopLabel.font = [UIFont systemFontOfSize:18];
    _leftTopLabel.textColor = HEXCOLOR(0x666666);
    [self.contentView addSubview:_leftTopLabel];
    
    _leftBottomLabel = [[UILabel alloc] init];
    _leftBottomLabel.font = [UIFont systemFontOfSize:12];
    _leftBottomLabel.textColor = COLOR_Gray;
    [self.contentView addSubview:_leftBottomLabel];
    
    _rightLabel = [[UILabel alloc] init];
    _rightLabel.font = [UIFont systemFontOfSize:12];
    _rightLabel.textColor = HEXCOLOR(0x666666);
    _rightLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_rightLabel];
    
    UIView *dividerView = [[UIView alloc] init];
    dividerView.backgroundColor = COLOR_BackgroundColor;
    [self.contentView addSubview:dividerView];
    
    _leftTopLabel.sd_layout
    .leftSpaceToView(self.contentView,15)
    .topSpaceToView(self.contentView,15)
    .widthIs(120).heightIs(20);
    
    _leftBottomLabel.sd_layout
    .leftSpaceToView(self.contentView,15)
    .topEqualToView(_leftTopLabel).offset(30)
    .widthRatioToView(self.contentView,1)
    .heightIs(20);
    
    _rightLabel.sd_layout
    .rightEqualToView(self.contentView).offset(-15)
    .centerYEqualToView(_leftTopLabel)
    .widthIs(150).heightIs(25);
    
    dividerView.sd_layout
    .leftEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .widthRatioToView(self.contentView,1)
    .heightIs(5);
}

- (void)setModel:(ServeModel *)model
{
    _model = model;
    
    self.leftTopLabel.text = model.name;
    
    if (self.viewType == ServedVCTypeHaveServed) {
        self.leftBottomLabel.text = [NSString stringWithFormat:@"最后一次服务时间：%@",model.book_end_time];
        NSString *result = [NSString stringWithFormat:@"已服务：%@次",model.serviceNum];
        self.rightLabel.attributedText = [HuaCuiTangHelper changeTextColorWithRestltStr:result changeText:model.serviceNum andColor:COLOR_Text_Blue];
    }else {
        self.leftBottomLabel.text = [NSString stringWithFormat:@"下次服务时间：%@",model.book_start_time];
        NSString *result = [NSString stringWithFormat:@"待服务：%@次",model.serviceNum];
        self.rightLabel.attributedText = [HuaCuiTangHelper changeTextColorWithRestltStr:result changeText:model.serviceNum andColor:COLOR_Text_Blue];
    }
}

@end
