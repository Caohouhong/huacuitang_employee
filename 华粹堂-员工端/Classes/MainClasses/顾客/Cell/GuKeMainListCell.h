//
//  GuKeMainListCell.h
//  华粹堂-员工端
//
//  Created by liqiang on 2016/11/25.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelGuKe.h"

@interface GuKeMainListCell : UITableViewCell

@property (nonatomic, copy) ModelGuKe *model;

+ (GuKeMainListCell *)cellWithTableView:(UITableView *)tableView;

@end
