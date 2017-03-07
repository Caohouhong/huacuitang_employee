//
//  WritingEvaluationStarScoreView.m
//  OAConnectStore
//
//  Created by yindongbo on 16/5/10.
//  Copyright © 2016年 zengxiangrong. All rights reserved.
//

#import "StarScoreView.h"
#import <math.h>
@implementation StarScoreView{
    UIView *_emptyStarsView;
    UIView *_realStarsView;
    BOOL _isSlidingType;
    BOOL _isEnsembleStar;
    
    
    CGFloat _starWidthHeight;
    CGFloat _intervalValue;
    
    NSInteger _num;
}


- (instancetype)initWithFrame:(CGRect)frame isEditable:(BOOL)isEditable ensembleStar:(BOOL)ensembleStar starNum:(NSInteger)num{
    if (self = [super initWithFrame:frame]) {
        CGFloat width = frame.size.width;
        CGFloat height = frame.size.height;
        _num = num;
        _emptyStarsView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        [self addSubview:_emptyStarsView];
        [self createTheStars:_emptyStarsView starImageViewName:@"StarUnSelect"];
        
        _realStarsView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, height)];
        [self addSubview:_realStarsView];
        _realStarsView.layer.masksToBounds = YES;
        [self createTheStars:_realStarsView starImageViewName:@"StarSelected"];
        
        self.openAnimation = YES;
        _isEnsembleStar = ensembleStar;
        if (!isEditable) {
            self.userInteractionEnabled = NO;
        }
    }
    return self;
}

- (void)createTheStars:(UIView*)view starImageViewName:(NSString*)starImageName{
    if (_num == 0)
    {
        _num = 5;
    }
    _starWidthHeight = (_emptyStarsView.frame.size.width * 0.73333)/_num;
    _intervalValue = _emptyStarsView.frame.size.width * 0.0666;
    /*
     宽高为 starWidthHeight
     间隙为
     */
    for (NSInteger i = 0; i <_num; i++) {
        UIImageView * startImageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*(_starWidthHeight + _intervalValue), 0, _starWidthHeight, _starWidthHeight)];
        startImageView.image = [UIImage imageNamed:starImageName];
        [view addSubview:startImageView];
    }
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    [self updataRealStarsViewFrameWith:point];
//    NSLog(@"Began比例为：%f", point.x / self.frame.size.width>1?1:point.x / self.frame.size.width);
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (_isEnsembleStar) {
        return;
    }
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    [self updataRealStarsViewFrameWith:point];
//    NSLog(@"Moved比例为：%f", point.x / self.frame.size.width>1?1:point.x / self.frame.size.width);
    _isSlidingType = YES;
    if (point.x >= 0) {
        CGFloat score = point.x / self.frame.size.width>1?1:point.x / self.frame.size.width;
        if (self.scoreblock) {
            self.scoreblock (score * _num);
        }
        return;
    }else{
        if (self.scoreblock) {
            self.scoreblock (0);
        }
    }
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (_isEnsembleStar) {
        return;
    }
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    [self updataRealStarsViewFrameWith:point];
    if (_isSlidingType) {
        _isSlidingType = NO;
    }
    
    if (point.x >= 0) {
        CGFloat score = point.x / self.frame.size.width>1?1:point.x / self.frame.size.width;
        if (self.scoreblock) {
            self.scoreblock (score * _num);
        }
        return;
    }else{
        if (self.scoreblock) {
            self.scoreblock (0);
        }
    }
}


- (void)updataRealStarsViewFrameWith:(CGPoint)point{
    if (_isEnsembleStar)
    {
        CGFloat starNumberInt = 0;
        if (point.x >=0)
        {
            CGFloat score = point.x / self.frame.size.width>1?1:point.x / self.frame.size.width;
            CGFloat starNumber = score *_num;
            CGFloat width = _emptyStarsView.frame.size.width/_num;
            starNumberInt = ceilf(starNumber);
            [UIView animateWithDuration:0.2 animations:^{
                _realStarsView.frame = CGRectMake(0, 0, width * starNumberInt, _emptyStarsView.frame.size.height);
            }];
        }
        if (self.scoreblock)
        {
            self.scoreblock(ceilf(starNumberInt));
        }
        return;
    }
    
    CGRect realStarsViewFrame = CGRectZero;
    if (point.x >0 && point.x<self.frame.size.width)
    {
        realStarsViewFrame = CGRectMake(0, 0, point.x, _emptyStarsView.frame.size.height);
    }
    else if((point.x >0 && point.x >= self.frame.size.width))
    {
        realStarsViewFrame = CGRectMake(0, 0, _emptyStarsView.frame.size.width, _emptyStarsView.frame.size.height);
    }
    else if (point.x <0)
    {
        realStarsViewFrame = CGRectMake(0, 0, 0, _emptyStarsView.frame.size.height);
    }
    if (_isSlidingType||!self.openAnimation) {
        _realStarsView.frame = realStarsViewFrame;
        return;
    }
    [UIView animateWithDuration:0.2 animations:^{
        _realStarsView.frame = realStarsViewFrame;
    }];
}



- (void)setStarScore:(CGFloat)starScore{
    _starScore = starScore;
    [self accordingToTheScoreLayoutRealStarsView];
}

- (void)accordingToTheScoreLayoutRealStarsView{
    if (self.scoreblock)
    {
        self.scoreblock( self.starScore);
    }
    CGRect realStarsViewFrame = CGRectZero;
    if (_starScore == 0) {
        realStarsViewFrame = CGRectMake(0, 0, 0, _emptyStarsView.frame.size.height);
    }else if (_starScore >= 5){
        realStarsViewFrame = CGRectMake(0, 0,_emptyStarsView.frame.size.width, _emptyStarsView.frame.size.height);
    }else{
        CGFloat differenceValue = self.starScore - floor(self.starScore);
        realStarsViewFrame = CGRectMake(0, 0, (_starWidthHeight + _intervalValue)*floor(self.starScore) +_starWidthHeight * differenceValue, _emptyStarsView.frame.size.height);
    }
    if (!self.openAnimation) {
        _realStarsView.frame = realStarsViewFrame;
        return;
    }else{
        [UIView animateWithDuration:0.2 animations:^{
            _realStarsView.frame = realStarsViewFrame;
        }];
    }
    
}
@end
