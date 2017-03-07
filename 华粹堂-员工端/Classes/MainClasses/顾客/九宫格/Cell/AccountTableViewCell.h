//
//  AccountTableViewCell.h
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/28.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccountModel.h"

@interface AccountTableViewCell : UITableViewCell

@property (nonatomic, strong) AccountModel *model; 

@property (nonatomic, strong)UIImageView *topImageView;
@property (nonatomic, strong)UILabel *leftLabel;
@property (nonatomic, strong)UILabel *rightLabel;
@property (nonatomic, strong)UIImageView *arrowImageView;

+ (AccountTableViewCell *)cellWithTableView:(UITableView *)tableView;

@end
