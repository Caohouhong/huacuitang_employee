//
//  DailySumWriteCell.h
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/27.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^writeTextBolck)(NSString *);

@interface DailySumWriteCell : UITableViewCell

@property (nonatomic, copy) writeTextBolck block;
@property (nonatomic, strong) UITextView *topTextView;
+ (DailySumWriteCell *)cellWithTableView:(UITableView *)tableView;
@end
