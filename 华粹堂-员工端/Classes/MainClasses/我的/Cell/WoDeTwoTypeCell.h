//
//  WoDeTwoTypeCell.h
//  华粹堂-员工端
//
//  Created by liqiang on 2016/11/14.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WoDeTwoTypeCell : UITableViewCell

@property (nonatomic, weak) UIImageView *iconImageView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *detailLabel;
@property (nonatomic, weak) UIImageView *arrowImageView;

+ (WoDeTwoTypeCell *)cellWithTableView:(UITableView *)tableView;

@end
