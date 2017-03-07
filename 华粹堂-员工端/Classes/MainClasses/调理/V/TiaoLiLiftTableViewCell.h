//
//  TiaoLiLiftTableViewCell.h
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/27.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TiaoliOnceCellView.h"

@interface TiaoLiLiftTableViewCell : UITableViewCell
@property (nonatomic, strong)TiaoliOnceCellView *topPlanCell;

+ (TiaoLiLiftTableViewCell *)cellWithTableView:(UITableView *)tableView;
@end
