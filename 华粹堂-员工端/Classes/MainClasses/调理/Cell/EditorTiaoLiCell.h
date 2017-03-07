//
//  EditorTiaoLiCell.h
//  华粹堂-员工端
//
//  Created by 唐硕 on 16/11/28.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelTrackManage.h"

typedef void(^clickKanLabel)();

@interface EditorTiaoLiCell : UITableViewCell

+(instancetype)cellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) ModelTrackManage *model;

@property (nonatomic, copy) clickKanLabel block;

@end
