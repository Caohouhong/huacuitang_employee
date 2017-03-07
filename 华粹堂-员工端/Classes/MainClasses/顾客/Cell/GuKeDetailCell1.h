//
//  GuKeDetailCell1.h
//  华粹堂-员工端
//
//  Created by 李强 on 2017/2/21.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelGuKe.h"

@interface GuKeDetailCell1 : UITableViewCell

@property (nonatomic, strong) ModelGuKe *model;
+ (GuKeDetailCell1 *)cellWithTableView:(UITableView *)tableView;

@end
