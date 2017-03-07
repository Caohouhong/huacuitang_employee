//
//  MyKaXiangCell.h
//  华粹堂-客户端
//
//  Created by liqiang on 2016/11/22.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyKaModel.h"

@interface MyKaXiangCell : UITableViewCell
+ (MyKaXiangCell *)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) MyKaModel *model;

@end
