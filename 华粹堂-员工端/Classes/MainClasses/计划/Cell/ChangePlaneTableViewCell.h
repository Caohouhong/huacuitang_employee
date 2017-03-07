//
//  ChangePlaneTableViewCell.h
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/27.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangePlaneTableViewCell : UITableViewCell
@property (nonatomic,strong)UILabel *leftLabel;
@property (nonatomic,strong)UITextField *rightTextField;
+ (ChangePlaneTableViewCell *)cellWithTableView:(UITableView *)tableView;
@end
