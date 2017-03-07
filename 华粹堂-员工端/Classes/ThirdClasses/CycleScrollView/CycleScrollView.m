//
//  CycleScrollView.m
//  UIScrollViewHomework
//
//  Created by GJ1991 on 16/1/30.
//  Copyright © 2016年 Gidoor All rights reserved.
//

#import "CycleScrollView.h"
#import "NSTimer+Addition.h"

#define kWidth self.frame.size.width
#define kHeight self.frame.size.height

@interface CycleScrollView()<UIScrollViewDelegate>
{
    NSInteger _imagesCount; // 记录传入的数组元素的个数

    NSTimeInterval _animationDuration; // 定义自动滚动的时间间隔
}
@property (nonatomic, retain) NSArray *imagesArray; // 接收传入的图片数组
@property (nonatomic, retain) UIScrollView *scrollView;
// 使用NSTimer让图片自动滚动
@property (nonatomic, retain) NSTimer *timer;

@end

@implementation CycleScrollView

- (instancetype)initWithFrame:(CGRect)frame imagesArray:(NSArray *)imagesArray titlesArray:(NSArray *)titlesArray animationDuration:(NSTimeInterval)animationDuration
{
    self = [super initWithFrame:frame];
    if (self) {
        _imagesArray = imagesArray;
        _imagesCount = imagesArray.count;
        _animationDuration = animationDuration;
        // 初始化UIScrollView对象
        
        [self createScrollView];
        // 初始化UIPageControl对象
        [self createPageControl];
        [self createImageViews];
        // 初始化NStimer对象，并且让它进行滚动，如果给的时间间隔为0的话，那么不能自动滚动
        if (animationDuration != 0) {
            _timer = [NSTimer scheduledTimerWithTimeInterval:animationDuration target:self selector:@selector(autoChangeFrame:) userInfo:nil repeats:YES];
            // 保证在主界面滑动的时候NSTimer也不暂停
            [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
        }
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame imagesArray:(NSArray *)imagesArray animationDuration:(NSTimeInterval)animationDuration
{
    self = [super initWithFrame:frame];
    if (self) {
        _imagesArray = imagesArray;
        _imagesCount = imagesArray.count;
        _animationDuration = animationDuration;
        // 初始化UIScrollView对象

        [self createScrollView];
        // 初始化UIPageControl对象
        [self createPageControl];
        [self createImageViews];
        // 初始化NStimer对象，并且让它进行滚动，如果给的时间间隔为0的话，那么不能自动滚动
        if (animationDuration != 0) {
            _timer = [NSTimer scheduledTimerWithTimeInterval:animationDuration target:self selector:@selector(autoChangeFrame:) userInfo:nil repeats:YES];
            // 保证在主界面滑动的时候NSTimer也不暂停
            [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
        }
    }
    return self;
}

// 自动滚动
- (void)autoChangeFrame:(NSTimer *)timer
{
    // 进行纠偏(为了防止出现便宜量在屏幕一半的情况)
    NSInteger currentPage = _scrollView.contentOffset.x / kWidth;
    CGPoint newOffset = CGPointMake(currentPage * kWidth + kWidth, 0);
    [_scrollView setContentOffset:newOffset animated:YES];
    [self changeCurrentPageAuto];
}

#pragma mark - UIPageControl的初始化
- (void)createPageControl
{
    // 创建UIPageControl对象
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(100, 600, 200, 30)];
    pageControl.numberOfPages = _imagesCount;
    pageControl.currentPage = 0;
    pageControl.center = CGPointMake(kWidth / 2.0, kHeight - 30 );
    pageControl. userInteractionEnabled = NO;
    pageControl.pageIndicatorTintColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.3];
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    pageControl.tag = 20000; // 通过tag值找到对应控件
    [self addSubview:pageControl];
    
    pageControl.sd_layout
    .centerXEqualToView(self)
    .bottomSpaceToView(self,0)
    .widthIs(100)
    .heightIs(30);

}

#pragma mark - 更改UIPageControl的当前指示页（自动滚动的时候）
- (void)changeCurrentPageAuto
{
    UIPageControl *pageControl = (UIPageControl *)[self viewWithTag:20000];
    if (_scrollView.contentOffset.x / kWidth == _imagesCount) {
        pageControl.currentPage = 0;

    } else if (_scrollView.contentOffset.x / kWidth == 0) {
        pageControl.currentPage = _imagesCount - 1;
    } else {
        pageControl.currentPage = _scrollView.contentOffset.x / kWidth; // 根据视图偏移的距离，更改pageControl的当前选中的页
    }
}

#pragma mark - UIScrollView的初始化
- (void)createScrollView
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    _scrollView.contentSize = CGSizeMake((_imagesCount + 2) * kWidth, kHeight);
    // 隐藏水平滚动条
    _scrollView.showsHorizontalScrollIndicator = NO;
    // 设置一次滚动一页
    _scrollView.pagingEnabled = YES;
    // 设置偏移量
    _scrollView.contentOffset = CGPointMake(kWidth, 0);
    // 设置delegate为当前对象
    _scrollView.delegate = self;
    // 循环设置图片
    // 把scrollView添加到self上
    [self addSubview:_scrollView];
}

#pragma mark - 循环设置UImageView
- (void)createImageViews
{
    for (int i = 0; i < _imagesCount + 2; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth * i, 0, kWidth, kHeight)];
        imageView.userInteractionEnabled = YES;

        if (i == 0) {
            //第一张  显示最后一张图片
            imageView.image = [UIImage imageNamed:[_imagesArray lastObject]];
//            imageView.image = [_imagesArray lastObject];
//            [imageView sd_setImageWithURL:IMAGE_URL([_imagesArray lastObject]) placeholderImage:[UIImage imageNamed:@"default_1"]];
            imageView.tag = 1000;
        } else if (i == _imagesCount + 1) {
            //最后一张  显示第一张图片
            imageView.image = [UIImage imageNamed:[_imagesArray firstObject]];
//            imageView.image = [_imagesArray firstObject];
//            [imageView sd_setImageWithURL:IMAGE_URL([_imagesArray firstObject]) placeholderImage:[UIImage imageNamed:@"default_1"]];
            imageView.tag = 1100;
        } else {
            imageView.image = [UIImage imageNamed:_imagesArray[i - 1]];
//            imageView.image = _imagesArray[i - 1];
//            [imageView sd_setImageWithURL:IMAGE_URL(_imagesArray[i - 1]) placeholderImage:[UIImage imageNamed:@"default_1"]];
            imageView.tag = 1000+i;
        }
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapp:)];
        [imageView addGestureRecognizer:tap];
        
        [_scrollView addSubview:imageView];
    }
}

- (void)tapp:(UITapGestureRecognizer *)tap
{
    NSLog(@"---->%@",tap.view);
    
    if (self.didTapImageBlock)
    {
        UIView *vv = tap.view;
        self.didTapImageBlock((int)vv.tag - 1001);
    }
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 首先得到当前的偏移量
    CGPoint currentPoint = scrollView.contentOffset;
    if (currentPoint.x <= kWidth / 2) {
        scrollView.contentOffset = CGPointMake(_imagesCount * kWidth + currentPoint.x, 0);
    } else if (currentPoint.x > (_imagesCount + 0.5) * kWidth) {
        scrollView.contentOffset = CGPointMake(currentPoint.x - _imagesCount * kWidth, 0);
    }
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_timer pauseTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [_timer resumeTimerAfterTimeInterval:_animationDuration];
    [self changeCurrentPageManual];
}

#pragma mark - 手动滑动的时候触发该方法
- (void)changeCurrentPageManual
{
    UIPageControl *pageControl = (UIPageControl *)[self viewWithTag:20000];
    pageControl.currentPage = _scrollView.contentOffset.x / kWidth - 1; // 根据视图偏移的距离，更改pageControl的当前选中的页
}

- (void)pauseScroll
{
    [_timer pauseTimer];
}

- (void)restoreTheScroll
{
    [_timer resumeTimerAfterTimeInterval:_animationDuration];
}

- (void)dealloc
{
    [_timer invalidate];
    _timer = nil;
}


@end
