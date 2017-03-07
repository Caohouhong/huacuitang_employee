//
//  TioaliDetailVC.m
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/26.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "TiaoliDetailVC.h"
#import "ChhYuYueDetailHeaderView.h"
#import "TopSelectView.h"
#import "TiaoLiServeLogView.h"
#import "TiaoLiLifeView.h"
#import "TiaoLiAdviceIView.h"


@interface TiaoliDetailVC ()<TopSelectViewDelegate>
@property (nonatomic, strong)ChhYuYueDetailHeaderView *headerView;
@property (nonatomic, strong)TopSelectView *topSelectView;
@property (nonatomic, strong)UIScrollView *mScrollView;
@property (nonatomic, strong)UIButton *keepButton;
@property (nonatomic, strong)UIButton *commitButton;
@end

@implementation TiaoliDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"调理详情";
    self.view.backgroundColor = COLOR_BackgroundColor;
    [self initHeaderView];
    [self initCenterView];
    [self initBottomView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initHeaderView{
    
    _headerView = [[ChhYuYueDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 80)];
    [self.view addSubview:self.headerView];
    
    UIView *dividerLine1 = [[UIView alloc] initWithFrame:CGRectMake(0, 80, ScreenWidth, 1)];
    dividerLine1.backgroundColor = COLOR_LineViewColor;
    [self.view addSubview:dividerLine1];
    
    _topSelectView = [[TopSelectView alloc] initWithFrame:CGRectMake(0, 81, ScreenWidth, 35)];
    [_topSelectView.leftButton setTitle:@"服务日志" forState:UIControlStateNormal];
    [self.topSelectView.leftButton setTitleColor:COLOR_Text_Blue forState:UIControlStateNormal];
    [_topSelectView.centerButton setTitle:@"家居养生" forState:UIControlStateNormal];
    [_topSelectView.rightButton setTitle:@"审核意见" forState:UIControlStateNormal];
    
    _topSelectView.delegate = self;
    
    [self.view addSubview:self.topSelectView];
    
}

- (void)initCenterView{
    
    _mScrollView = [[UIScrollView alloc] init];
    _mScrollView.backgroundColor = COLOR_BackgroundColor;
    _mScrollView.contentSize = CGSizeMake(ScreenWidth, ScreenHeight - 116 - 45 + 1);
    _mScrollView.pagingEnabled = YES;
    _mScrollView.scrollEnabled = NO;
    [self.view addSubview:self.mScrollView];
    
    TiaoLiServeLogView *serveLogView = [[TiaoLiServeLogView alloc] init];
    [self.mScrollView addSubview:serveLogView];
    
    TiaoLiLifeView *liftView = [[TiaoLiLifeView alloc] init];
    [self.mScrollView addSubview:liftView];
    
    TiaoLiAdviceIView *adviceView = [[TiaoLiAdviceIView alloc] init];
    [self.mScrollView addSubview:adviceView];
    
    _mScrollView.sd_layout
    .leftEqualToView(self.view)
    .topSpaceToView(_topSelectView,0)
    .widthIs(ScreenWidth*3)
    .heightIs(ScreenHeight - 116 - 45);
    
    serveLogView.sd_layout
    .leftEqualToView(self.mScrollView)
    .topSpaceToView(self.mScrollView,0)
    .widthIs(ScreenWidth)
    .heightRatioToView(self.mScrollView,1);
    
    liftView.sd_layout
    .leftEqualToView(self.mScrollView).offset(ScreenWidth)
    .topSpaceToView(self.mScrollView,0)
    .widthIs(ScreenWidth)
    .heightRatioToView(self.mScrollView,1); //heightIs(430)
    
    adviceView.sd_layout
    .leftEqualToView(self.mScrollView).offset(2*ScreenWidth)
    .topSpaceToView(self.mScrollView,0)
    .widthIs(ScreenWidth)
    .heightRatioToView(self.mScrollView,1);
}

- (void)initBottomView
{
    UIView *holdView = [[UIView alloc] init];
    holdView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:holdView];
    
    _keepButton = [[UIButton alloc] init];
    _keepButton.titleLabel.font = SYSTEM_FONT_(14);
    _keepButton.tag = 10000;
    [_keepButton setTitle:@"保存草稿" forState:UIControlStateNormal];
    [_keepButton setBackgroundColor:[UIColor whiteColor]];
    [_keepButton setTitleColor:COLOR_darkGray forState:UIControlStateNormal];
    [_keepButton addTarget:self action:@selector(bottomButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [holdView addSubview:_keepButton];
    
    _commitButton = [[UIButton alloc] init];
    _commitButton.titleLabel.font = SYSTEM_FONT_(14);
    _commitButton.tag = 10001;
    [_commitButton setTitle:@"提交" forState:UIControlStateNormal];
    [_commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_commitButton setBackgroundColor:COLOR_Text_Blue];
    [_commitButton addTarget:self action:@selector(bottomButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [holdView addSubview:_commitButton];
    
    UIView *dividerLine1 = [[UIView alloc] init];
    dividerLine1.backgroundColor = COLOR_LineViewColor;
    [holdView addSubview:dividerLine1];
    
    holdView.sd_layout
    .leftEqualToView(self.view)
    .bottomEqualToView(self.view)
    .widthRatioToView(self.view,1)
    .heightIs(45);
    
    _keepButton.sd_layout
    .leftEqualToView(holdView)
    .topEqualToView(holdView)
    .widthIs(ScreenWidth/2)
    .heightRatioToView(holdView,1);
    
    _commitButton.sd_layout
    .rightEqualToView(holdView)
    .topEqualToView(holdView)
    .widthIs(ScreenWidth/2)
    .heightRatioToView(holdView,1);
    
    dividerLine1.sd_layout
    .leftEqualToView(holdView)
    .topEqualToView(holdView)
    .widthRatioToView(holdView,1)
    .heightIs(1);

}

#pragma mark - TopSelectViewDelegate 顶部按钮代理
- (void)topButtonClickWithTag:(TopSelectViewType)tag
{
    [self.topSelectView.leftButton setTitleColor:COLOR_darkGray forState:UIControlStateNormal];
    [self.topSelectView.rightButton setTitleColor:COLOR_darkGray forState:UIControlStateNormal];
    [self.topSelectView.centerButton setTitleColor:COLOR_darkGray forState:UIControlStateNormal];
    
    switch (tag) {
        case TopSelectViewTypeLeft:
        {
            [self.topSelectView.leftButton setTitleColor:COLOR_Text_Blue forState:UIControlStateNormal];
            [UIView animateWithDuration:0.3 animations:^{
                self.mScrollView.contentOffset = CGPointMake(0, 0);
            }];
        }
            break;
        case TopSelectViewTypeCenter:
        {
            [self.topSelectView.centerButton setTitleColor:COLOR_Text_Blue forState:UIControlStateNormal];
            [UIView animateWithDuration:0.3 animations:^{
                self.mScrollView.contentOffset = CGPointMake(ScreenWidth, 0);
            }];
        }
            break;
        case TopSelectViewTypeRight:
        {
            [self.topSelectView.rightButton setTitleColor:COLOR_Text_Blue forState:UIControlStateNormal];
            [UIView animateWithDuration:0.3 animations:^{
                self.mScrollView.contentOffset = CGPointMake(ScreenWidth*2, 0);
            }];
        }
            break;
        default:
            break;
    }
}

#pragma mark Action 
- (void)bottomButtonAction:(UIButton *)button
{
    if (button.tag == 10000){ //保存草稿
        
    }else if (button.tag == 10001){//提交
        
    }
}
@end
