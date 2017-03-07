//
//  MoveStarScoreView.h
//  MoveStarScoreDemo
//
//  Created by yindongbo on 16/5/10.
//  Copyright © 2016年 ydb. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^updataScoreBlock)(CGFloat scoreNumber);



@interface MoveStarScoreView : UIView



- (instancetype)initWithFrame:(CGRect)frame isEditable:(BOOL)isEditable;

@property(nonatomic, strong)updataScoreBlock scoreblock;


@property(nonatomic, assign)CGFloat starScore;


/*! 开启动画 默认为开启*/
@property(nonatomic, assign)BOOL openAnimation;
@end
