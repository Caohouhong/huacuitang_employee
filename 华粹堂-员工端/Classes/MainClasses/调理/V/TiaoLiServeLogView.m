//
//  TiaoLiServeLogView.m
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/27.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "TiaoLiServeLogView.h"
#import "TiaoliOnceCellView.h"
#import "TiaoLiDetailView1.h"
#import "TiaoLiDetailView2.h"

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
    [self addSubview:planCell];
    
    TiaoLiDetailView1 *detailView1 = [[TiaoLiDetailView1 alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 110)];
    [self addSubview:detailView1];
    
    TiaoLiDetailView2 *detailView2 = [[TiaoLiDetailView2 alloc] init];
    [self addSubview:detailView2];
    
    TiaoliOnceCellView *lifeCell = [[TiaoliOnceCellView alloc] init];
    lifeCell.leftNameLabel.text = @"私密生活：";
    [lifeCell.rightButton setTitle:@"未填写" forState:UIControlStateNormal];
    [self addSubview:lifeCell];
    
    TiaoliOnceCellView *topicCell = [[TiaoliOnceCellView alloc] init];
    topicCell.leftNameLabel.text = @"私密话题：";
    [topicCell.rightButton setTitle:@"已填写" forState:UIControlStateNormal];
    [self addSubview:topicCell];
    
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
    
    lifeCell.sd_layout
    .leftEqualToView(self)
    .topSpaceToView(detailView2,0)
    .widthRatioToView(self,1)
    .heightIs(30);
    
    topicCell.sd_layout
    .leftEqualToView(self)
    .topSpaceToView(lifeCell,10)
    .widthRatioToView(self,1)
    .heightIs(30);
}
@end
