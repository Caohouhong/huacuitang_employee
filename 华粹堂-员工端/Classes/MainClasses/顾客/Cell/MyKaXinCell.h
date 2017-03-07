//
//  MyKaXinCell.h
//  华粹堂-客户端
//
//  Created by 唐硕 on 16/12/1.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyKaXinModel.h"

@interface MyKaXinCell : UITableViewCell


+(instancetype)cellWithTableview:(UITableView *)tableview ;

@property (nonatomic, strong) MyKaXinModel *model;

@end
