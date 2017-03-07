//
//  CheckDetailTableViewCell.h
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/28.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BodyDetailModel.h"
@interface CheckDetailTableViewCell : UITableViewCell

@property (nonatomic, strong)UIImageView *topImageView;
@property (nonatomic, strong)UILabel *leftLabel;
@property (nonatomic, strong)UILabel *bottomLabel;
+ (CheckDetailTableViewCell *)cellWithTableView:(UITableView *)tableView;
@end
