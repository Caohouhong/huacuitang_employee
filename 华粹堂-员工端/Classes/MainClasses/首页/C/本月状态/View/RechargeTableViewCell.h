//
//  RechargeTableViewCell.h
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/22.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TodayTargetModel.h"
#import "DailySummaryModel.h"

@interface RechargeTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *rightLabel;

@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *centerLabel;


@property (nonatomic, strong) TodayTargetModel *todayTargetModel;

@property (nonatomic, strong) DailySummaryModel *dailySumModel;

+ (RechargeTableViewCell *)cellWithTableView:(UITableView *)tableView;
@end
