//
//  AdviceTableViewCell.h
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/28.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdviceTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *titleLabel; //title
@property (nonatomic, strong) UITextView *topTextView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeLabel;

+ (AdviceTableViewCell *)cellWithTableView:(UITableView *)tableView;
@end
