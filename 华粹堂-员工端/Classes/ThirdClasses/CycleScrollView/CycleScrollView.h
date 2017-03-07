//
//  CycleScrollView.h
//  UIScrollViewHomework
//
//  Created by GJ1991 on 16/1/30.
//  Copyright © 2016年 Gidoor All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DidTapImageBlock)(int index);

@interface CycleScrollView : UIView

/**
 *  根据传入的图片数组，初始化一个轮播图对象
 *
 *  @param frame       轮播图对象的frame
 *  @param imagesArray 图片数组，包含了要进行轮播的图片
 *  @param animationDuration 自动滚动的时间间隔, 如果给的值为0的时候，不能自动进行轮播
 *
 *  @return 初始化完成的轮播图对象
 */
- (instancetype)initWithFrame:(CGRect)frame imagesArray:(NSArray *)imagesArray animationDuration:(NSTimeInterval)animationDuration;
- (instancetype)initWithFrame:(CGRect)frame imagesArray:(NSArray *)imagesArray titlesArray:(NSArray *)titlesArray animationDuration:(NSTimeInterval)animationDuration;

@property (nonatomic, retain, readonly) NSArray *imagesArray;
@property (nonatomic, copy) DidTapImageBlock didTapImageBlock;


/**
 *  暂停滚动
 */
- (void)pauseScroll;

/**
 *  恢复滚动
 */
- (void)restoreTheScroll;

@end
