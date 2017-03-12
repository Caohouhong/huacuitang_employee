//
//  HuiFangDetailVC.m
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/27.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "HuiFangDetailVC.h"
#import "ChhYuYueDetailHeaderView.h"
#import "TopSelectViewTwoBtnView.h"
#import "TiaoLiAdviceIView.h"
#import "HuiFangRecordView.h"
#import "HCTConnet.h"
#import "ProDetailAndHealthModel.h"
#import "ShowPlanViewController.h"
#import "WSDatePickerView.h"
#import "HuaCuiTangHelper.h"

@interface HuiFangDetailVC ()<TopSelectViewTwoBtnViewDelegate>
{
    NSString *huifangTime; //回访时间
}
@property (nonatomic, strong)ChhYuYueDetailHeaderView *headerView;
@property (nonatomic, strong)TopSelectViewTwoBtnView *topSelectView;
@property (nonatomic, strong)UIScrollView *mScrollView;
@property (nonatomic, strong)UIButton *keepButton;
@property (nonatomic, strong)UIButton *commitButton;
@property (nonatomic, strong)ProDetailAndHealthModel *proAndHealthModel;

@property (nonatomic, strong)HuiFangRecordView *recordView;

@property (nonatomic, strong)NSString *feedBackStr; //客户反馈
@property (nonatomic, strong)NSString *remarkStr; //备注

@end

@implementation HuiFangDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"回访详情";
    self.view.backgroundColor = COLOR_BackgroundColor;
    [self initHeaderView];
    [self initCenterView];
    [self initBottomView];
    [self initDataWithModel];
    [self requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initHeaderView{
    
    _headerView = [[ChhYuYueDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 80)];
    
    _headerView.huifangModel = self.model;
    
    [self.view addSubview:self.headerView];
    
    UIView *dividerLine1 = [[UIView alloc] initWithFrame:CGRectMake(0, 80, ScreenWidth, 1)];
    dividerLine1.backgroundColor = COLOR_LineViewColor;
    [self.view addSubview:dividerLine1];
    
    _topSelectView = [[TopSelectViewTwoBtnView alloc] initWithFrame:CGRectMake(0, 81, ScreenWidth, 35)];
    [_topSelectView.leftButton setTitle:@"回访记录" forState:UIControlStateNormal];
    [self.topSelectView.leftButton setTitleColor:COLOR_Text_Blue forState:UIControlStateNormal];

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
    
    self.recordView = [[HuiFangRecordView alloc] init];
    
    self.recordView.model = self.model;
    
    WEAK(weakSelf);
    
    _recordView.textBlock = ^(NSString *feedBack, NSString *remark){
        weakSelf.feedBackStr = feedBack;
        weakSelf.remarkStr = remark;
    };
    
    _recordView.block = ^(HuiFangRecordViewButtonTag tag){
        switch (tag) {
            case HuiFangRecordViewButtonTagPlan:
            {
                ShowPlanViewController *vc = [[ShowPlanViewController alloc] init];
                vc.viewTitle = @"调理方案";
                vc.viewContent = weakSelf.proAndHealthModel.d_program_detail;
                vc.hidesBottomBarWhenPushed = YES;
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }
                break;
            case HuiFangRecordViewButtonTagLift:
            {
                ShowPlanViewController *vc = [[ShowPlanViewController alloc] init];
                vc.viewTitle = @"家居养生方案";
                vc.viewContent = weakSelf.proAndHealthModel.home_health_req;
                vc.hidesBottomBarWhenPushed = YES;
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }
                break;
            case HuiFangRecordViewButtonTagTime:
            {

                WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithCompleteBlock:^(NSDate *startDate) {
                    NSString *date = [startDate stringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
                    NSLog(@"时间： %@",date);
                    weakSelf.recordView.timeCell.rightLabel.text = date;
                    
                    huifangTime = [HuaCuiTangHelper changeDateToTimeStmp:startDate];
                    
                }];
                datepicker.datePickerStyle = DateStyleShowYearMonthDayHourMinute;
                datepicker.themeColor = COLOR_Text_Blue;
                datepicker.minLimitDate = [NSDate date:@"1970-1-01 00:00" WithFormat:@"yyyy-MM-dd HH:mm"];
                datepicker.maxLimitDate = [NSDate date:@"2049-12-31 23:59" WithFormat:@"yyyy-MM-dd HH:mm"];
                [datepicker show];

            }
                break;
            default:
                break;
        }
    };
    
    [self.mScrollView addSubview:self.recordView];
    
    TiaoLiAdviceIView *adviceView = [[TiaoLiAdviceIView alloc] init];
    [self.mScrollView addSubview:adviceView];
    
    _mScrollView.sd_layout
    .leftEqualToView(self.view)
    .topSpaceToView(_topSelectView,0)
    .widthIs(ScreenWidth*2)
    .heightIs(ScreenHeight - 116 - 45);
    
    self.recordView.sd_layout
    .leftEqualToView(self.mScrollView)
    .topSpaceToView(self.mScrollView,0)
    .widthIs(ScreenWidth)
    .heightRatioToView(self.mScrollView,1);
    
    adviceView.sd_layout
    .leftEqualToView(self.mScrollView).offset(ScreenWidth)
    .topSpaceToView(self.mScrollView,0)
    .widthIs(ScreenWidth)
    .heightRatioToView(self.mScrollView,1);
}

- (void)initBottomView
{
    UIView *holdView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 45)];
    holdView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:holdView];
    
    _commitButton = [[UIButton alloc] init];
    _commitButton.titleLabel.font = SYSTEM_FONT_(16);
    _commitButton.tag = 10001;
    [_commitButton setTitle:@"提交" forState:UIControlStateNormal];
    [_commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_commitButton setBackgroundColor:COLOR_Text_Blue];
    [_commitButton addTarget:self action:@selector(bottomButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [holdView addSubview:_commitButton];
    
    UIView *dividerLine1 = [[UIView alloc] init];
    dividerLine1.backgroundColor = COLOR_LineViewColor;
    [holdView addSubview:dividerLine1];

    _commitButton.sd_layout
    .leftEqualToView(holdView)
    .rightEqualToView(holdView)
    .topEqualToView(holdView)
    .heightRatioToView(holdView,1);
    
    dividerLine1.sd_layout
    .leftEqualToView(holdView)
    .topEqualToView(holdView)
    .widthRatioToView(holdView,1)
    .heightIs(1);
    
    [UIView animateWithDuration:0.5 animations:^{
        holdView.frame = CGRectMake(0, ScreenHeight - 45, ScreenWidth, 45);
    }];
}

- (void)initDataWithModel{
    self.feedBackStr = self.model.feedback;
    self.remarkStr = self.model.remark;
    if (self.model.visit_time){
        huifangTime = [HuaCuiTangHelper changeTimeToTimeStmp:self.model.visit_time];
    }
}

#pragma mark - TopSelectViewDelegate 顶部按钮代理
- (void)topButtonClickWithTag:(TopSelectViewTwoBtnViewType)tag
{
    [self.topSelectView.leftButton setTitleColor:COLOR_darkGray forState:UIControlStateNormal];
    [self.topSelectView.rightButton setTitleColor:COLOR_darkGray forState:UIControlStateNormal];
    
    switch (tag) {
        case TopSelectViewTwoBtnViewTypeLeft:
        {
            [self.topSelectView.leftButton setTitleColor:COLOR_Text_Blue forState:UIControlStateNormal];
            [UIView animateWithDuration:0.3 animations:^{
                self.mScrollView.contentOffset = CGPointMake(0, 0);
            }];
        }
            break;
       
        case TopSelectViewTwoBtnViewTypeRight:
        {
            [self.topSelectView.rightButton setTitleColor:COLOR_Text_Blue forState:UIControlStateNormal];
            [UIView animateWithDuration:0.3 animations:^{
                self.mScrollView.contentOffset = CGPointMake(ScreenWidth, 0);
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
    [self submitHuifangContent];
}

#pragma mark ============网络===========
//获取家居养生方案和调理方案
- (void)requestData
{
    [LCProgressHUD showLoading:@"正在加载..."];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:self.model.c_id forKey:@"customerId"];
    
    [HCTConnet getHomeProDetailAndHomeHealth:params success:^(id responseObject)  {
        
        self.proAndHealthModel = [ProDetailAndHealthModel mj_objectWithKeyValues:responseObject];
        
    } successBackfailError:^(ModelFieldError *responseObject) {
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}

////获取回访信息
//- (void)getHuiFangData{
//    
//    //H 测试 telephonevisitId有误
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    [params setValue:self.model.c_id forKey:@"telephonevisitId"];
//    
//    [HCTConnet getHomeTelVisit:params success:^(id responseObject)  {
//        
//        self.proAndHealthModel = [ProDetailAndHealthModel mj_objectWithKeyValues:responseObject];
//        
//    } successBackfailError:^(ModelFieldError *responseObject) {
//        
//    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
//        
//    }];
//}

//提交回访信息
- (void)submitHuifangContent
{
    if (!huifangTime.length){
        [LCProgressHUD showFailure:@"请选择服务时间"];
        return;
    }
    if (!self.feedBackStr.length){
        [LCProgressHUD showFailure:@"请填写反馈"];
        return;
    }
    [LCProgressHUD showLoading:@"正在加载..."];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:self.model.c_id forKey:@"c_id"];
    [params setValue:self.model.e_id forKey:@"e_id"];
    [params setValue:self.model.s_id forKey:@"s_id"];
    [params setValue:huifangTime forKey:@"visit_time"];//时间戳
    [params setValue:self.feedBackStr forKey:@"feedback"];//反馈信息
    [params setValue:self.remarkStr forKey:@"remark"];//备注
    //H 测试 uuid暂时无法获取
    [params setValue:self.model.uuid forKey:@"uuid"];//uuid
    
    [HCTConnet getHomeAddTelVisit:params success:^(id responseObject)  {
        
        self.proAndHealthModel = [ProDetailAndHealthModel mj_objectWithKeyValues:responseObject];
        
    } successBackfailError:^(ModelFieldError *responseObject) {
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}



@end
