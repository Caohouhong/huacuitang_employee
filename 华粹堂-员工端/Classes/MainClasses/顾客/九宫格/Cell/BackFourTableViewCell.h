//
//  BackFourTableViewCell.h
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/28.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BackFourTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *adviceBtn0;
@property (nonatomic, strong) UIButton *adviceBtn1;
@property (nonatomic, strong) UIButton *adviceBtn2;
@property (nonatomic, strong) UIButton *adviceBtn3;


+ (BackFourTableViewCell *)cellWithTableView:(UITableView *)tableView;
@end
