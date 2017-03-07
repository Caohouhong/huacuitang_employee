//
//  PerfectionfoCell.h
//  lingdaozhe
//
//  Created by liqiang on 16/5/19.
//  Copyright © 2016年 bckj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PerfectionfoCell : UITableViewCell

@property (nonatomic, weak) UILabel *label;

@property (nonatomic, weak) UILabel *contentLabel;
@property (nonatomic, weak) UIView *lineView;
@property (nonatomic, weak) UIImageView *arrowImageView;

+ (PerfectionfoCell *)cellWithTableView:(UITableView *)tableView;

@end
