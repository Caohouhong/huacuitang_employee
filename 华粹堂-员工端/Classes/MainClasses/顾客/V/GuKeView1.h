//
//  GuKeView1.h
//  华粹堂-员工端
//
//  Created by 唐硕 on 16/11/29.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelGuKe.h"

typedef void(^clickMobile)();

@interface GuKeView1 : UIView

@property (nonatomic, copy) NSString *urlStr;

@property (nonatomic, strong) ModelGuKe *model;

@property (nonatomic, copy) clickMobile block;

@end
