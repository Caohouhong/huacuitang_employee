//
//  MainTypeListViewCell.h
//  华粹堂-员工端
//
//  Created by 唐硕 on 16/11/24.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define titleArray  @[@"账户安全", @"店面电话", @"我的业绩", @"退出登录"]
#define imageviewArray  @[@"", @"", @"", @""]

@interface MainTypeListViewCell : UITableViewCell


@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UIImageView *iconimageView;
@property (nonatomic, weak) UIImageView *arrowimageView;
@property (nonatomic, weak) UILabel *phoneLabel;

+(instancetype)cellWithTableview:(UITableView *)tableview;

@end
