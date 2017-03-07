//
//  TSMainThreeTypeCell.h
//  华粹堂-员工端
//
//  Created by 唐硕 on 16/11/24.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define titleArray  @[@"顾客预约", @"调理备忘", @"服务回访", @"今日总结",@"明日计划"]
#define imageviewArray  @[@"icon_yuyue", @"icon_tlbw", @"icon_gzbw", @"icon_fwhf",@"icon_yuyue"]


@interface TSMainThreeTypeCell : UITableViewCell


+(instancetype)cellWithTableview:(UITableView *)tableview;


@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UIImageView *iconimageView;
@property (nonatomic, weak) UILabel *rightLabel;


@end
