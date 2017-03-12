//
//  TiaoLiLiftTableViewCell.h
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/27.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TiaoliOnceCellView.h"

typedef void(^TiaoLiLiftTableViewCellBlock)(NSString *, int);

@interface TiaoLiLiftTableViewCell : UITableViewCell
@property (nonatomic, strong)TiaoliOnceCellView *topPlanCell;

@property (nonatomic, copy) TiaoLiLiftTableViewCellBlock cellBlock;

+ (TiaoLiLiftTableViewCell *)cellWithTableView:(UITableView *)tableView;


@end
