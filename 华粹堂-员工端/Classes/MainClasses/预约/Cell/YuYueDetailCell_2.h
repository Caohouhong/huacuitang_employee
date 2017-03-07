//
//  YuYueDetailCell_2.h
//  华粹堂-员工端
//
//  Created by liqiang on 2016/11/14.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YuYueDetailCell_2 : UITableViewCell

@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *contentLabel;

+ (YuYueDetailCell_2 *)cellWithTableView:(UITableView *)tableView;

@end
