//
//  ChhYuYueTableViewCell.h
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/24.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChhYuYueTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *rightLabel;
+ (ChhYuYueTableViewCell *)cellWithTableView:(UITableView *)tableView;
@end
