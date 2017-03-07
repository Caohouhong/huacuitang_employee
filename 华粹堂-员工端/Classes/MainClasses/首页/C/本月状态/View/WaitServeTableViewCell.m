//
//  WaitServeTableViewCell.m
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/23.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "WaitServeTableViewCell.h"
#import "HuaCuiTangHelper.h"

@interface WaitServeTableViewCell()
@property (nonatomic, strong) UILabel *leftTopLabel;
@property (nonatomic, strong) UILabel *leftTimeLabel;
@property (nonatomic, strong) UILabel *leftDoctorLabel;
@property (nonatomic, strong) UILabel *rightExpertLabel; //专家
@property (nonatomic, strong) UILabel *leftBottomLabel;  //手机号
@property (nonatomic, strong) UIImageView *statusImageView;
@property (nonatomic, strong) UIButton *alertButton;

@end

@implementation WaitServeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self drawView];
    }
    
    return self;
}

+ (WaitServeTableViewCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *idenifier = @"WaitServeTableViewCell";
    WaitServeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (cell == nil)
    {
        cell = [[WaitServeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}
- (void)drawView{
    
    _leftTopLabel = [[UILabel alloc] init];
    _leftTopLabel.font = [UIFont systemFontOfSize:18];
    _leftTopLabel.textColor = COLOR_darkGray;
    _leftTopLabel.text = @"姓名";
    [self.contentView addSubview:_leftTopLabel];
    
    _leftTimeLabel = [[UILabel alloc] init];
    _leftTimeLabel.font = [UIFont systemFontOfSize:15];
    _leftTimeLabel.textColor = COLOR_darkGray;
    _leftTimeLabel.text = @"预约时间：";
    [self.contentView addSubview:_leftTimeLabel];
    
    _leftDoctorLabel = [[UILabel alloc] init];
    _leftDoctorLabel.font = [UIFont systemFontOfSize:12];
    _leftDoctorLabel.textColor = COLOR_Gray;
    _leftDoctorLabel.text = @"预约门店：";
    [self.contentView addSubview:_leftDoctorLabel];
    
    _leftBottomLabel = [[UILabel alloc] init];
    _leftBottomLabel.font = [UIFont systemFontOfSize:12];
    _leftBottomLabel.textColor = COLOR_LightGray;
    _leftBottomLabel.text = @"手机号：";
    [self.contentView addSubview:_leftBottomLabel];
    
    _rightExpertLabel = [[UILabel alloc] init];
    _rightExpertLabel.font = [UIFont systemFontOfSize:12];
    _rightExpertLabel.textColor = COLOR_Gray;
    _rightExpertLabel.text = @"专家看诊：";
    [self.contentView addSubview:_rightExpertLabel];
    
    //状态
    _rightBottomLabel = [[UILabel alloc] init];
    _rightBottomLabel.font = [UIFont systemFontOfSize:12];
    _rightBottomLabel.textColor = COLOR_Gray;
    _rightBottomLabel.text = @"状态：审核中";
    [self.contentView addSubview:_rightBottomLabel];
    
    UIView *dividerLine = [[UIView alloc] init];
    dividerLine.backgroundColor = backviewColor;
    [self.contentView addSubview:dividerLine];
    
    UIView *dividerTopView = [[UIView alloc] init];
    dividerTopView.backgroundColor = COLOR_BackgroundColor;
    [self.contentView addSubview:dividerTopView];
    
    UIView *dividerBottomView = [[UIView alloc] init];
    dividerBottomView.backgroundColor = COLOR_BackgroundColor;
    [self.contentView addSubview:dividerBottomView];
    
    _statusImageView = [[UIImageView alloc] init];
    _statusImageView.image = [UIImage imageNamed:@"h_serve_wait_48x19"];
    _statusImageView.hidden = YES;
    [self.contentView addSubview:_statusImageView];
    
    _alertButton = [[UIButton alloc] init];
    _alertButton.hidden = YES;
    [_alertButton setBackgroundImage:[UIImage imageNamed:@"h_serve_wait_remind_63x22"] forState:UIControlStateNormal];
    [_alertButton addTarget:self action:@selector(remindAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_alertButton];
    
    _leftTopLabel.sd_layout
    .leftSpaceToView(self.contentView,15)
    .topSpaceToView(self.contentView,10)
    .widthIs(120).heightIs(20);

    _leftTimeLabel.sd_layout
    .leftSpaceToView(self.contentView,15)
    .topEqualToView(_leftTopLabel).offset(25)
    .widthIs(ScreenWidth - 30).heightIs(15);

    _leftDoctorLabel.sd_layout
    .leftSpaceToView(self.contentView,15)
    .topEqualToView(_leftTimeLabel).offset(20)
    .widthIs(150)
    .heightIs(15);
    
    _rightExpertLabel.sd_layout
    .leftSpaceToView(self.contentView,ScreenWidth/2)
    .centerYEqualToView(_leftDoctorLabel)
    .widthIs(150)
    .heightIs(20);
    
    _leftBottomLabel.sd_layout
    .leftSpaceToView(self.contentView,15)
    .bottomEqualToView(self.contentView).offset(-10)
    .widthIs(200)
    .heightIs(40);
    
    _rightBottomLabel.sd_layout
    .rightEqualToView(self.contentView).offset(-15)
    .centerYEqualToView(_leftBottomLabel)
    .widthIs(100)
    .heightIs(40);
    
    _statusImageView.sd_layout
    .rightEqualToView(self.contentView).offset(-10)
    .topEqualToView(self.contentView)
    .widthIs(48)
    .heightIs(19);
    
    _alertButton.sd_layout
    .rightEqualToView(self.contentView).offset(-10)
    .centerYEqualToView(_leftBottomLabel)
    .widthIs(62)
    .heightIs(22);
    
    dividerLine.sd_layout
    .leftSpaceToView(self.contentView,10)
    .bottomEqualToView(self.contentView).offset(-50)
    .widthIs(ScreenWidth - 20)
    .heightIs(1);
    
    dividerTopView.sd_layout
    .leftEqualToView(self.contentView)
    .topEqualToView(self.contentView)
    .widthRatioToView(self.contentView,1)
    .heightIs(2);
    
    dividerBottomView.sd_layout
    .leftEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .widthRatioToView(self.contentView,1)
    .heightIs(8);
}

//按钮点击
- (void)remindAction
{
    
}

- (void)setModel:(ServeModel *)model
{
    _model = model;
    
    self.statusImageView.hidden = NO;
    self.alertButton.hidden = NO;
    self.rightBottomLabel.hidden = YES;
    
    self.leftTopLabel.text = model.name;
    self.leftTimeLabel.text = [NSString stringWithFormat:@"预约时间： %@~%@",model.book_start_time,model.book_end_time];
    self.leftDoctorLabel.text = [NSString stringWithFormat:@"预约门店： %@",model.s_name];
    //  1 － 专家看诊
    self.rightExpertLabel.text = [NSString stringWithFormat:@"专家看诊：%@",([@"1" isEqualToString:model.book_type]) ? @"是" : @"否"];
    self.leftBottomLabel.text = [NSString stringWithFormat:@"手机号：%@",model.mobile_phone];
    /* 到店提醒  1 已提醒  0 － 未提醒 */
    if ([@"1" isEqualToString:model.isRemind]) {
        [self.alertButton setBackgroundImage:[UIImage imageNamed:@"h_serve_reminded_63x22"] forState:UIControlStateNormal];
        [_alertButton setUserInteractionEnabled:NO];
    }else {
        [self.alertButton setBackgroundImage:[UIImage imageNamed:@"h_serve_wait_remind_63x22"] forState:UIControlStateNormal];
        [_alertButton setUserInteractionEnabled:YES];
    }
}

- (void)setTrackModel:(ModelTrackManage *)trackModel
{
    _trackModel = trackModel;
    
    self.statusImageView.hidden = YES;
    self.alertButton.hidden = YES;
    self.rightBottomLabel.hidden = YES;
    
    self.leftTopLabel.text = trackModel.customerName;
    self.leftTimeLabel.text = [NSString stringWithFormat:@"预约时间： %@",trackModel.track_date];
    self.leftDoctorLabel.text = [NSString stringWithFormat:@"预约门店： %@",trackModel.shopName];
    //  1 － 专家看诊
    self.rightExpertLabel.text = [NSString stringWithFormat:@"专家看诊：%@",([@"1" isEqualToString:trackModel.track_type]) ? @"是" : @"否"];
    self.leftBottomLabel.text = [NSString stringWithFormat:@"手机号：%@",trackModel.customerMobilePhone];
}

- (void)setHuiFangModel:(HuiFangModel *)huiFangModel
{
    _huiFangModel = huiFangModel;
    
    self.statusImageView.hidden = YES;
    self.alertButton.hidden = YES;
    self.rightBottomLabel.hidden = YES;
    
    self.leftTopLabel.text = huiFangModel.customerName;
    self.leftTimeLabel.text = [NSString stringWithFormat:@"预约时间： %@",[HuaCuiTangHelper changeTimeStyleWithTimeStemp:huiFangModel.serverTime]];
    self.leftDoctorLabel.text = [NSString stringWithFormat:@"预约门店： %@",[ModelMember sharedMemberMySelf].shopName];
    //  1 － 专家看诊
    self.rightExpertLabel.text = [NSString stringWithFormat:@"专家看诊：%@",([@"1" isEqualToString:huiFangModel.isExpert]) ? @"是" : @"否"];
    self.leftBottomLabel.text = [NSString stringWithFormat:@"手机号：%@",huiFangModel.customerTel];
    
}

@end
