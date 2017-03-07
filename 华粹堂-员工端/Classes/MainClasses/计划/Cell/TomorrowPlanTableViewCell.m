//
//  TomorrowPlanTableViewCell.m
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/27.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "TomorrowPlanTableViewCell.h"

@implementation TomorrowPlanTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        //        self.contentView.backgroundColor = HEXCOLOR(0xeeeeee);
        [self drawView];
    }
    
    return self;
}

+ (TomorrowPlanTableViewCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"TomorrowPlanTableViewCell";
    TomorrowPlanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[TomorrowPlanTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)drawView{
    
    _leftLabel = [[UILabel alloc] init];
    _leftLabel.font = [UIFont systemFontOfSize:15];
    _leftLabel.textAlignment = NSTextAlignmentCenter;
    _leftLabel.textColor = COLOR_Black;
    [self.contentView addSubview:_leftLabel];
    
    _rightLabel = [[UILabel alloc] init];
    _rightLabel.font = [UIFont systemFontOfSize:15];
    _rightLabel.textColor = HEXCOLOR(0x666666);
    _rightLabel.textAlignment = NSTextAlignmentCenter;
    _rightLabel.text = @"0";
    [self.contentView addSubview:_rightLabel];
    
    _centerLabel1 = [[UILabel alloc] init];
    _centerLabel1.font = [UIFont systemFontOfSize:15];
    _centerLabel1.textColor = HEXCOLOR(0x666666);
    _centerLabel1.textAlignment = NSTextAlignmentCenter;
    _centerLabel1.text = @"0";
    [self.contentView addSubview:_centerLabel1];
    
    _centerLabel2 = [[UILabel alloc] init];
    _centerLabel2.font = [UIFont systemFontOfSize:15];
    _centerLabel2.textColor = HEXCOLOR(0x666666);
    _centerLabel2.textAlignment = NSTextAlignmentCenter;
    _centerLabel2.text = @"0";
    [self.contentView addSubview:_centerLabel2];
    
    UIView *dividerLine = [[UIView alloc] init];
    dividerLine.backgroundColor = backviewColor;
    [self.contentView addSubview:dividerLine];
    
    _leftLabel.sd_layout
    .leftSpaceToView(self.contentView,0)
    .centerYEqualToView(self.contentView)
    .widthIs(ScreenWidth/4)
    .heightRatioToView(self.contentView,1);
    
    _centerLabel1.sd_layout
    .leftSpaceToView(_leftLabel,0)
    .centerYEqualToView(self.contentView)
    .widthIs(ScreenWidth/4)
    .heightRatioToView(self.contentView,1);
    
    _centerLabel2.sd_layout
    .leftSpaceToView(_centerLabel1,0)
    .centerYEqualToView(self.contentView)
    .widthIs(ScreenWidth/4)
    .heightRatioToView(self.contentView,1);
    
    _rightLabel.sd_layout
    .leftSpaceToView(_centerLabel2,0)
    .centerYEqualToView(self.contentView)
    .widthIs(ScreenWidth/4)
    .heightRatioToView(self.contentView,1);
    
    dividerLine.sd_layout
    .leftEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .widthRatioToView(self.contentView,1)
    .heightIs(1);
}

- (void)setModel:(TomPlanListModel *)model
{
    _model = model;
    
//    public static final short TYPE_SERVICE 		= 0;//服务
//    public static final short TYPE_SALES	= 1;//销售
//    public static final short TYPE_BEDDING		= 2;//铺垫
//    public static final short TYPE_STUDY		= 3;//学习
    
    NSString *taskType = model.task_type?model.task_type:@"0";
    NSString *typeName;
    if ([taskType isEqualToString:@"1"]){
        typeName = @"销售";
    }else if ([taskType isEqualToString:@"2"]){
        typeName = @"铺垫";
    }else if ([taskType isEqualToString:@"3"]){
        typeName = @"学习";
    }else {
        typeName = @"服务";
    }
    _leftLabel.text = typeName; //1234-转
    _centerLabel1.text = model.target_customer;
    _centerLabel2.text = model.target_money;
    _rightLabel.text = model.target_content;
    
}

@end
