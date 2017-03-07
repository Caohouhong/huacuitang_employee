//
//  BianJiTiaoLiCell_1.h
//  华粹堂-员工端
//
//  Created by liqiang on 2016/11/16.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelTrackManage.h"


typedef void(^clickBiaoQianButton)();

@interface BianJiTiaoLiCell_1 : UITableViewCell

@property (nonatomic, strong) ModelTrackManage *model;

+ (BianJiTiaoLiCell_1 *)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, copy) clickBiaoQianButton BQblock;


@end
