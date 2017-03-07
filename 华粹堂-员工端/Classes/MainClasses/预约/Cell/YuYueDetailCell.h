//
//  YuYueDetailCell.h
//  华粹堂-员工端
//
//  Created by liqiang on 2016/11/14.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelHealthBooking.h"

typedef void(^clickPhone)();

@interface YuYueDetailCell : UITableViewCell

@property (nonatomic, strong) ModelHealthBooking *model;

+ (YuYueDetailCell *)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, copy) clickPhone block;

@end
