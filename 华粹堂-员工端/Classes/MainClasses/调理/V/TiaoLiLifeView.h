//
//  TiaoLiLifeView.h
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/27.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TiaoLiLifeViewBlock)();

typedef void(^TiaoLiLifeViewPingJiaBlock)(NSString *);

typedef void(^TiaoLiLifeViewPingFenBlock)(NSString *);

@interface TiaoLiLifeView : UIView

@property (nonatomic, copy) TiaoLiLifeViewBlock block;

@property (nonatomic, copy) TiaoLiLifeViewPingJiaBlock pingJiaBlock;

@property (nonatomic, copy) TiaoLiLifeViewPingFenBlock pingfenBlock;

@property (nonatomic, strong) NSString *pingJiaStr;

@end
