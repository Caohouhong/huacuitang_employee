//
//  StarScoreView.h
//  OAConnectStore
//
//  Created by yindongbo on 16/5/10.
//  Copyright © 2016年 zengxiangrong. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!将选择的评分参数返回给VC的block*/
typedef void(^updataScoreBlock)(CGFloat scoreNumber);

@interface StarScoreView : UIView

/*!
 星星评分控件初始化
 isEditable是否允许编辑评分功能 Yes则可对星星进行操作 
 EnsembleStar 是否只能显示整个星星空间，Yes则只能显示整个星星，否则可以根据评分显示百分比覆盖
 */
- (instancetype)initWithFrame:(CGRect)frame isEditable:(BOOL)isEditable ensembleStar:(BOOL)ensembleStar starNum:(NSInteger)num;

/*! 将用户返回的参数回调给VC */
@property(nonatomic, strong)updataScoreBlock scoreblock;

/*! 将获取到的评分展示到 控件之上*/
@property(nonatomic, assign)CGFloat starScore;

/*! 开启动画 默认为开启*/
@property(nonatomic, assign)BOOL openAnimation;
@end
