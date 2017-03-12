//
//  TiaoLiServeLogView.m
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/27.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "TiaoLiServeLogView.h"
#import "TiaoLiDetailView1.h"
#import "TiaoLiDetailView2.h"
@interface TiaoLiServeLogView()
{
    
}
@end

@implementation TiaoLiServeLogView

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
    
    TiaoliOnceCellView *planCell = [[TiaoliOnceCellView alloc] init];
    planCell.leftNameLabel.text = @"调理方案";
    [planCell.rightButton setTitle:@"查看" forState:UIControlStateNormal];
    [planCell.rightButton setTitleColor:COLOR_Text_Blue forState:UIControlStateNormal];
    planCell.rightButton.tag = TiaoLiServeLogViewButtonTagPlan;
    [planCell.rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:planCell];
    
    TiaoLiDetailView1 *detailView1 = [[TiaoLiDetailView1 alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 110)];
    WEAK(weakSelf);
    detailView1.textBlock = ^(NSString *text){
        weakSelf.projectText = text;
        if (weakSelf.viewBlock){
            weakSelf.viewBlock(weakSelf.projectText,weakSelf.LiLiaoResult,weakSelf.feedBackResult);
        }
    };
    
    detailView1.trackTime = self.trackTime;
    [self addSubview:detailView1];
    
    TiaoLiDetailView2 *detailView2 = [[TiaoLiDetailView2 alloc] init];
    detailView2.selectBlock = ^(NSString *LiLiaoStr, NSString *feedBackStr){
        weakSelf.LiLiaoResult = LiLiaoStr;
        weakSelf.feedBackResult = feedBackStr;
        if (weakSelf.viewBlock){
            weakSelf.viewBlock(weakSelf.projectText,weakSelf.LiLiaoResult,weakSelf.feedBackResult);
        }
    };
    [self addSubview:detailView2];
    
    _lifeCell = [[TiaoliOnceCellView alloc] init];
    _lifeCell.leftNameLabel.text = @"私密生活：";
    [_lifeCell.rightButton setTitle:@"未填写" forState:UIControlStateNormal];
    [_lifeCell.rightButton setTitleColor:COLOR_TEXT_ORANGE_RED forState:UIControlStateNormal];
    [_lifeCell.rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    _lifeCell.rightButton.tag = TiaoLiServeLogViewButtonTagLift;
    [self addSubview:_lifeCell];
    
    _topicCell = [[TiaoliOnceCellView alloc] init];
    _topicCell.leftNameLabel.text = @"私密话题：";
    [_topicCell.rightButton setTitle:@"已填写" forState:UIControlStateNormal];
    [_topicCell.rightButton setTitleColor:COLOR_TEXT_GREEN_RED forState:UIControlStateNormal];
    [_topicCell.rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    _topicCell.rightButton.tag = TiaoLiServeLogViewButtonTagTopic;
    [self addSubview:_topicCell];
    
    planCell.sd_layout
    .leftEqualToView(self)
    .topSpaceToView(self,10)
    .widthRatioToView(self,1)
    .heightIs(37);
    
    detailView1.sd_layout
    .leftEqualToView(self)
    .topSpaceToView(planCell,0)
    .widthRatioToView(self,1)
    .heightIs(110);
    
    detailView2.sd_layout
    .leftEqualToView(self)
    .topSpaceToView(detailView1,0)
    .widthRatioToView(self,1)
    .heightIs(180);
    
    _lifeCell.sd_layout
    .leftEqualToView(self)
    .topSpaceToView(detailView2,0)
    .widthRatioToView(self,1)
    .heightIs(30);
    
    _topicCell.sd_layout
    .leftEqualToView(self)
    .topSpaceToView(_lifeCell,10)
    .widthRatioToView(self,1)
    .heightIs(30);
}

- (void)rightButtonAction:(UIButton *)button
{
    //用按钮的title作为标志
    if (self.block){
        self.block(button.tag);
    }
}

@end
