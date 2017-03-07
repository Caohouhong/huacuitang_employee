//
//  MoveStarScoreView.m
//  MoveStarScoreDemo
//
//  Created by yindongbo on 16/5/10.
//  Copyright © 2016年 ydb. All rights reserved.
//

#import "MoveStarScoreView.h"

@implementation MoveStarScoreView{
    UIView *_emptyStarsView;
    UIView *_realStarsView;
    
    BOOL _isSlidingType;
    
    CGFloat _starWidthHeight;
    CGFloat _intervalValue;
}



- (instancetype)initWithFrame:(CGRect)frame isEditable:(BOOL)isEditable{
    if (self = [super initWithFrame:frame]) {
        CGFloat width = frame.size.width;
        CGFloat height = frame.size.height;
        _emptyStarsView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,width,height)];
        [self addSubview:_emptyStarsView];
        [self createTheStars:_emptyStarsView starImageViewName:@"StarUnSelect"];
        
        _realStarsView = [[UIView alloc] initWithFrame:CGRectMake(0,0,0,height)];
        [self addSubview:_realStarsView];
        _realStarsView.layer.masksToBounds = YES;
        [self createTheStars:_realStarsView starImageViewName:@"StarSelected"];
        
        self.openAnimation = YES;
        if (!isEditable) {
            self.userInteractionEnabled = NO;
        }
    }
    return self;
}

- (void)createTheStars:(UIView*)view starImageViewName:(NSString*)starImageName{
    CGFloat starWidthHeight = _emptyStarsView.frame.size.width/5;
    for (NSInteger i = 0; i <5; i++) {
        UIImageView * startImageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*starWidthHeight, 0, starWidthHeight, starWidthHeight)];
        startImageView.image = [UIImage imageNamed:starImageName];
        [view addSubview:startImageView];
    }
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    [self updataRealStarsViewFrameWith:point];
    NSLog(@"Began比例为：%f", point.x / self.frame.size.width>1?1:point.x / self.frame.size.width);
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    [self updataRealStarsViewFrameWith:point];
    NSLog(@"Moved比例为：%f", point.x / self.frame.size.width>1?1:point.x / self.frame.size.width);
    _isSlidingType = YES;
    if (point.x >= 0) {
        CGFloat score = point.x / self.frame.size.width>1?1:point.x / self.frame.size.width;
        if (self.scoreblock) {
            self.scoreblock (score * 5);
        }
        return;
    }else{
        if (self.scoreblock) {
            self.scoreblock (0);
        }
    }
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    [self updataRealStarsViewFrameWith:point];
    if (_isSlidingType) {
        _isSlidingType = NO;
    }
    
    if (point.x >= 0) {
        CGFloat score = point.x / self.frame.size.width>1?1:point.x / self.frame.size.width;
        if (self.scoreblock) {
            self.scoreblock (score * 5);
        }
        return;
    }else{
        if (self.scoreblock) {
            self.scoreblock (0);
        }
    }
}


- (void)updataRealStarsViewFrameWith:(CGPoint)point{
    CGRect realStarsViewFrame = CGRectZero;
    if (point.x >0 && point.x<self.frame.size.width) {
        realStarsViewFrame = CGRectMake(0, 0, point.x, _emptyStarsView.frame.size.height);
    }else if((point.x >0 && point.x >= self.frame.size.width)){
        realStarsViewFrame = CGRectMake(0, 0, _emptyStarsView.frame.size.width, _emptyStarsView.frame.size.height);
    }else if (point.x <0){
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
    if (self.scoreblock) {
        self.scoreblock( self.starScore);
    }
    CGRect realStarsViewFrame = CGRectZero;
    if (_starScore == 0) {
        realStarsViewFrame = CGRectMake(0, 0, 0, _emptyStarsView.frame.size.height);
    }else if (_starScore == 5){
        realStarsViewFrame = CGRectMake(0, 0,_emptyStarsView.frame.size.width, _emptyStarsView.frame.size.height);
    }else{
        CGFloat fractionRatio = self.starScore / 5;
        realStarsViewFrame = CGRectMake(0, 0, _emptyStarsView.frame.size.width * fractionRatio, _emptyStarsView.frame.size.height);
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
