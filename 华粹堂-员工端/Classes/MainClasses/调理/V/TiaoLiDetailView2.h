//
//  TiaoLiDetailView2.h
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/26.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TiaoLiDetailView2Block)(NSString *, NSString *);

@interface TiaoLiDetailView2 : UIView

@property (nonatomic, copy)TiaoLiDetailView2Block selectBlock;

@end
