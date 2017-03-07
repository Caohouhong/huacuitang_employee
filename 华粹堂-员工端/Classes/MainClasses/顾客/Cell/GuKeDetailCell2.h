//
//  GuKeDetailCell2.h
//  华粹堂-员工端
//
//  Created by 李强 on 2017/2/21.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GuKeDetailCell2Delegate <NSObject>

- (void)guKeDetailBtnActionWithTag:(int)tag;

@end


@interface GuKeDetailCell2 : UITableViewCell

@property (nonatomic, weak)id<GuKeDetailCell2Delegate> delegate;
+ (GuKeDetailCell2 *)cellWithTableView:(UITableView *)tableView;

@end
