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

+ (BackFourTableViewCell *)cellWithTableView:(UITableView *)tableView;
@end
