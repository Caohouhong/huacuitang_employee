//
//  ServeTableViewCell.h
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/22.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServeModel.h"
#import "ServedViewController.h"

@interface ServeTableViewCell : UITableViewCell

@property (nonatomic, strong) ServeModel *model;
@property (nonatomic, assign) ServedVCType viewType;

+ (ServeTableViewCell *)cellWithTableView:(UITableView *)tableView;
@end
