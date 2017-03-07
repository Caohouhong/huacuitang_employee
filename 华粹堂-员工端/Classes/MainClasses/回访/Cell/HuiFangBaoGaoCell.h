//
//  HuiFangBaoGaoCell.h
//  华粹堂-员工端
//
//  Created by 唐硕 on 16/11/28.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HuiFangModel.h"

typedef void(^clickQBBtn)();
@interface HuiFangBaoGaoCell : UITableViewCell

+(instancetype)cellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) HuiFangModel *model;
@property (nonatomic, copy) clickQBBtn block;

@end
