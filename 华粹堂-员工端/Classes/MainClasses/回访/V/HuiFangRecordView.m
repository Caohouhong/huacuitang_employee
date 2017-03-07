//
//  HuiFangRecordView.m
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/27.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "HuiFangRecordView.h"
#import "TiaoliOnceCellView.h"
#import "TiaoLiDetailView1.h"

@implementation HuiFangRecordView

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
    
    TiaoliOnceCellView *lifeCell = [[TiaoliOnceCellView alloc] init];
    lifeCell.leftNameLabel.text = @"家居养生方案";
    [lifeCell.rightButton setTitle:@"查看" forState:UIControlStateNormal];
    [lifeCell.rightButton setTitleColor:COLOR_Text_Blue forState:UIControlStateNormal];
    [self addSubview:lifeCell];
    
    TiaoliOnceCellView *timeCell = [[TiaoliOnceCellView alloc] init];
    timeCell.leftNameLabel.text = @"回访时间：";
    timeCell.rightButton.hidden = YES;
    timeCell.rightLabel.textColor = COLOR_LightGray;
    timeCell.rightLabel.text = @"2012-12-12 12:00:00";
    [self addSubview:timeCell];
    
    TiaoLiDetailView1 *detailView1 = [[TiaoLiDetailView1 alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 110)];
    detailView1.titleLabel.text = @"客户反馈：";
    detailView1.titleLabel.textColor = COLOR_Black;
    detailView1.titleLabel.font = SYSTEM_FONT_(15);
    detailView1.topTextView.placeholder = @"请填写反馈";
    [self addSubview:detailView1];
    
    TiaoLiDetailView1 *detailView2 = [[TiaoLiDetailView1 alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 110)];
    detailView2.titleLabel.text = @"备注：";
    detailView2.titleLabel.textColor = COLOR_Black;
    detailView2.titleLabel.font = SYSTEM_FONT_(15);
    detailView2.topTextView.placeholder = @"请填写备注";
    [self addSubview:detailView2];
    
    planCell.sd_layout
    .leftEqualToView(self)
    .topSpaceToView(self,10)
    .widthRatioToView(self,1)
    .heightIs(37);
    
    lifeCell.sd_layout
    .leftEqualToView(self)
    .topSpaceToView(planCell,10)
    .widthRatioToView(self,1)
    .heightIs(37);
    
    timeCell.sd_layout
    .leftEqualToView(self)
    .topSpaceToView(lifeCell,10)
    .widthRatioToView(self,1)
    .heightIs(37);
    
    detailView1.sd_layout
    .leftEqualToView(self)
    .topSpaceToView(timeCell,5)
    .widthRatioToView(self,1)
    .heightIs(110);
    
    detailView2.sd_layout
    .leftEqualToView(self)
    .topSpaceToView(detailView1,0)
    .widthRatioToView(self,1)
    .heightIs(110);
}


@end
