//
//  MainThreeTypeCell.h
//  华粹堂-员工端
//
//  Created by liqiang on 2016/11/14.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainThreeTypeCell : UITableViewCell

+ (MainThreeTypeCell *)cellWithTableView:(UITableView *)tableView;

@end


@interface MainThreeTypeView : UIView

@property (nonatomic, weak) UIImageView *iconImageView;
@property (nonatomic, weak) UILabel *label;

@end
