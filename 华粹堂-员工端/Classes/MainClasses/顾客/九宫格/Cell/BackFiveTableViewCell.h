//
//  BackFiveTableViewCell.h
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/28.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BackFiveTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *rightLabel;
@property (nonatomic, strong) UIButton *adviceBtn0;
@property (nonatomic, strong) UIButton *adviceBtn1;
@property (nonatomic, strong) UIButton *adviceBtn2;
@property (nonatomic, strong) UIButton *adviceBtn3;
@property (nonatomic, strong) UIButton *adviceBtn4;
@property (nonatomic,strong) UIButton *selectedBtn;


+ (BackFiveTableViewCell *)cellWithTableView:(UITableView *)tableView;
@end
