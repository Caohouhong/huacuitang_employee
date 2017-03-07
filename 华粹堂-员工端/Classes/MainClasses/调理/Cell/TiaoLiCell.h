//
//  TiaoLiCell.h
//  华粹堂-员工端
//
//  Created by liqiang on 2016/11/14.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelTrackManage.h"

@interface TiaoLiCell : UITableViewCell

@property (nonatomic, strong) ModelTrackManage *model;

+ (TiaoLiCell *)cellWithTableView:(UITableView *)tableView;


@end
