//
//  BianJiTiaoLiCell_3.h
//  华粹堂-员工端
//
//  Created by liqiang on 2016/11/16.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelTrackManage.h"

@interface BianJiTiaoLiCell_3 : UITableViewCell

@property (nonatomic, strong) ModelTrackManage *model;

@property (nonatomic, copy) NSString *str;
+ (BianJiTiaoLiCell_3 *)cellWithTableView:(UITableView *)tableView;

@end
