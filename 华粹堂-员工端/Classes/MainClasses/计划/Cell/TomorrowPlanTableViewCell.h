//
//  TomorrowPlanTableViewCell.h
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/27.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TomPlanListModel.h"

@interface TomorrowPlanTableViewCell : UITableViewCell
@property (nonatomic,strong)UILabel *leftLabel;
@property (nonatomic,strong)UILabel *rightLabel;
@property (nonatomic,strong)UILabel *centerLabel1;
@property (nonatomic,strong)UILabel *centerLabel2;

@property (nonatomic, strong) TomPlanListModel *model;
+ (TomorrowPlanTableViewCell *)cellWithTableView:(UITableView *)tableView;

@end
