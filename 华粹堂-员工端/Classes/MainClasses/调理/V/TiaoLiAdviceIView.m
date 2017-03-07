//
//  TiaoLiAdviceIView.m
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/27.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "TiaoLiAdviceIView.h"
#import "TiaoLiAdviceCellView.h"

@implementation TiaoLiAdviceIView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){
        self.backgroundColor = COLOR_BackgroundColor;
        [self initView];
        
    }
    return self;
}

- (void)initView
{
    TiaoLiAdviceCellView *adviceView1 = [[TiaoLiAdviceCellView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 170)];
    adviceView1.titleLabel.text = @"院长审核意见";
    [self addSubview:adviceView1];
    
     TiaoLiAdviceCellView *adviceView2 = [[TiaoLiAdviceCellView alloc] initWithFrame:CGRectMake(0, 170, ScreenWidth, 170)];
    adviceView2.titleLabel.text = @"专家审核意见";
     [self addSubview:adviceView2];
}

@end
