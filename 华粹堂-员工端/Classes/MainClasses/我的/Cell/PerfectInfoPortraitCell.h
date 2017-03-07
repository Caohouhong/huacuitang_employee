//
//  PerfectInfoPortraitCell.h
//  WaterMan
//
//  Created by liqiang on 15/12/25.
//  Copyright © 2015年 baichun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PerfectInfoPortraitCell : UITableViewCell

@property (nonatomic, weak) UIImageView *iconImageView;

+ (PerfectInfoPortraitCell *)cellWithTableView:(UITableView *)tableView;

@end
