//
//  MessageCell.h
//  华粹堂-员工端
//
//  Created by 唐硕 on 16/12/2.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define nameArray @[@"通知",@"公司公告",@"阿三", @"萨斯",@"啊呜"]
#define subArray @[@"新通知",@"新公告",@"这条消息", @"那条消息",@"消息预览"]

@interface MessageCell : UITableViewCell

+(instancetype)cellWithTableview:(UITableView *)tableview ;

@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *SubLabel;

@end
