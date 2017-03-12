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
#import "HCTConnet.h"
#import "ProDetailAndHealthModel.h"
#import "ShowPlanViewController.h"
#import "YCXMenu.h"
#import "WriteSecretVC.h"
#import "ModelGuKe.h"


@interface TiaoliDetailVC ()<TopSelectViewDelegate>
{
    NSString *dialectics_program;
    NSString *con_eva;
    NSString *con_home_heal;
    
    NSString *home_health_req;
    NSString *total_string;
    
    
}
@property (nonatomic, strong)ChhYuYueDetailHeaderView *headerView;
@property (nonatomic, strong)TopSelectView *topSelectView;
@property (nonatomic, strong)UIScrollView *mScrollView;
@property (nonatomic, strong)UIButton *keepButton;
@property (nonatomic, strong)UIButton *commitButton;

@property (nonatomic, strong) UIButton *rightButton;

@property (nonatomic , strong) NSMutableArray *items;

@property (nonatomic, strong)ProDetailAndHealthModel *proAndHealthModel;
@end

@implementation TiaoliDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"调理详情";
    self.view.backgroundColor = COLOR_BackgroundColor;
    
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_chat_22x22"] style:UIBarButtonItemStylePlain target:self action:@selector(didClickRightBar:)];
    self.navigationItem.rightBarButtonItem = rightBar;
    
    _rightButton = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth - 30, 0, 10, 1)];
    _rightButton.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_rightButton];
    
    [self initHeaderView];
    [self initCenterView];
    [self initBottomView];
    
    [self requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initHeaderView{
    
    _headerView = [[ChhYuYueDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 80)];
    _headerView.trackModel = self.model;
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
    
    CGFloat viewHeight = ScreenHeight - 116 - 45;
    _mScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topSelectView.frame), ScreenWidth*3, viewHeight)];
    _mScrollView.backgroundColor = COLOR_BackgroundColor;
    _mScrollView.contentSize = CGSizeMake(ScreenWidth, ScreenHeight - 116 - 45 + 1);
    _mScrollView.pagingEnabled = YES;
    _mScrollView.scrollEnabled = NO;
    [self.view addSubview:self.mScrollView];
    
    //服务日志
    TiaoLiServeLogView *serveLogView = [[TiaoLiServeLogView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, viewHeight)];
    
    serveLogView.trackTime = self.model.track_date;
    
    //服务日志数据
    serveLogView.viewBlock = ^(NSString *projectStr, NSString *LiLiaoStr, NSString *feedBack){
        dialectics_program = projectStr;
        con_eva = LiLiaoStr;
        con_home_heal = feedBack;
    };
    
    serveLogView.block = ^(TiaoLiServeLogViewButtonTag tag){
         WEAK(weakSelf);
        switch (tag) {
            case TiaoLiServeLogViewButtonTagPlan:
            {
                ShowPlanViewController *vc = [[ShowPlanViewController alloc] init];
                vc.viewTitle = @"调理方案";
                vc.viewContent = self.proAndHealthModel.d_program_detail;
                vc.hidesBottomBarWhenPushed = YES;
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }
                break;
            case TiaoLiServeLogViewButtonTagLift:
            {
                WriteSecretVC *vc = [[WriteSecretVC alloc] init];
                vc.type = WriteSecretViewTypeLife;
                vc.hidesBottomBarWhenPushed = YES;
                vc.employeeModel = self.model;
                [weakSelf.navigationController pushViewController:vc animated:YES];

            }
                break;
            case TiaoLiServeLogViewButtonTagTopic:
            {
                WriteSecretVC *vc = [[WriteSecretVC alloc] init];
                vc.type = WriteSecretViewTypeTopic;
                vc.hidesBottomBarWhenPushed = YES;
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }
                
                break;
            default:
                break;
        }
    };
    
    [self.mScrollView addSubview:serveLogView];
    
    //家居养生
    TiaoLiLifeView *liftView = [[TiaoLiLifeView alloc] initWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, viewHeight)];
    liftView.block = ^{
        ShowPlanViewController *vc = [[ShowPlanViewController alloc] init];
        vc.viewTitle = @"家居养生方案";
        vc.viewContent = self.proAndHealthModel.home_health_req;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    };
    
    liftView.pingJiaBlock = ^(NSString *text){
        home_health_req = text;
    };
    
    liftView.pingfenBlock = ^(NSString *text){
        total_string = text;
    };
    
    [self.mScrollView addSubview:liftView];
    
    TiaoLiAdviceIView *adviceView = [[TiaoLiAdviceIView alloc] initWithFrame:CGRectMake(ScreenWidth*2, 0, ScreenWidth, viewHeight)];
    [self.mScrollView addSubview:adviceView];
    
}

- (void)initBottomView
{
    UIView *bottomHoldView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 45)];
    bottomHoldView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomHoldView];
    
    _commitButton = [[UIButton alloc] init];
    _commitButton.titleLabel.font = SYSTEM_FONT_(16);
    _commitButton.tag = 10001;
    [_commitButton setTitle:@"提交" forState:UIControlStateNormal];
    [_commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_commitButton setBackgroundColor:COLOR_Text_Blue];
    [_commitButton addTarget:self action:@selector(bottomButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [bottomHoldView addSubview:_commitButton];
    
    UIView *dividerLine1 = [[UIView alloc] init];
    dividerLine1.backgroundColor = COLOR_LineViewColor;
    [bottomHoldView addSubview:dividerLine1];
    
    _commitButton.sd_layout
    .leftEqualToView(bottomHoldView)
    .rightEqualToView(bottomHoldView)
    .topEqualToView(bottomHoldView)
    .heightRatioToView(bottomHoldView,1);
    
    dividerLine1.sd_layout
    .leftEqualToView(bottomHoldView)
    .topEqualToView(bottomHoldView)
    .widthRatioToView(bottomHoldView,1)
    .heightIs(1);
    
    [UIView animateWithDuration:0.5 animations:^{
        bottomHoldView.frame = CGRectMake(0, ScreenHeight - 45, ScreenWidth, 45);
    }];

}

#pragma mark － =========== 网络 =================
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


//提交调理详情
- (void)submitTiaoLiData{
    
    [LCProgressHUD showLoading:@"正在提交..."];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@(0) forKey:@"type"];//提交类型：0新增 1：编辑
    [params setValue:self.model.c_id forKey:@"c_id"];//客户标识
    [params setValue:self.model.e_id forKey:@"e_id"];//员工标识
    [params setValue:self.model.s_id forKey:@"s_id"];//门店编号
    [params setValue:self.model.track_date forKey:@"track_date"];//调理日期
    [params setValue:dialectics_program forKey:@"dialectics_program"];//调理项目
    [params setValue:self.proAndHealthModel.d_program_detail forKey:@"d_program_detail"];//调理方案
    [params setValue:self.proAndHealthModel.home_health_req forKey:@"problem_description"];//家居养生方案
    
    [params setValue:home_health_req forKey:@"home_health_req"];//总体评价
    [params setValue:self.model.c_id forKey:@"other_description"];//调理说明
    [params setValue:con_eva forKey:@"con_eva"];//客户综合反馈（1-4整数）1：不太满意  2：一般  3：较满意  4：很满意
    [params setValue:self.model.track_date forKey:@"createdtime"];//服务时间
    
    //到店理疗配合（-100,0,60,100整数字）对应字符串  null：不选  -100：较差  0：一般 60：较好 100：好
     [params setValue:con_home_heal forKey:@"con_home_heal"];
    //家居养生总评分有以下8项计算评价所得： 不选：不参加计算平均分 差：-100  一般：0 较好：60 好：100
    [params setValue:@"80" forKey:@"con_home_heal_value_total"];
    //家居养生评价   家居养生下八项评分  以“,”分割  不选：无效 差：-100  一般：0  较好：60 好：100
    [params setValue:total_string forKey:@"total_string"];
    [params setValue:self.model.c_id forKey:@"uuid"]; //暂时先传预约的id
    //私密生活填写(刚创建默认未填写，填写完自动修改成已填写) 0：未填写  1：已填写
    [params setValue:@(1) forKey:@"shenghuo_write"];
    //私密话题填写  0：未填写  1：已填写
    [params setValue:@(1) forKey:@"huati_write"];
    
    
    [HCTConnet getHomeSubmitTrackManagerV2:params success:^(id responseObject)  {
        
        
    } successBackfailError:^(ModelFieldError *responseObject) {
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
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
    [self submitTiaoLiData];
}


- (void)didClickRightBar:(id)sender{

    // 通过NavigationBarItem显示Menu
    if (sender == self.navigationItem.rightBarButtonItem) {
        [YCXMenu setTintColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]];
        
        [YCXMenu setSelectedColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8]];
        if ([YCXMenu isShow]){
            [YCXMenu dismissMenu];
        } else {
            [YCXMenu showMenuInView:self.view fromRect:self.rightButton.frame menuItems:self.items selected:^(NSInteger index, YCXMenuItem *item) {
                
                if (index == 0){
                    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",self.model.customerMobilePhone];//回访手机号
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
                }else if (index == 1){
                    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"sms://%@",self.model.customerMobilePhone];//回访手机号
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
                }else if (index == 2){
                    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
                    [params setValue:self.model.c_id forKey:@"customerId"];
                    
                    [[LQHTTPSessionManager sharedManager] LQPost:@"customer/getCustomer" parameters:params showTips:@"" success:^(id responseObject) {
                        ModelGuKe *GukeModel = [ModelGuKe mj_objectWithKeyValues:responseObject];
                        
                        if (!GukeModel.imUserName.length) {
                            
                            [LCProgressHUD showFailure:@"当前客户不可聊天"];
                            return;
                        }
                        
                        EaseMessageViewController *vc = [[EaseMessageViewController alloc] initWithConversationChatter:GukeModel.imUserName conversationType:EMConversationTypeChat];
                        vc.navigationItem.title = GukeModel.name;
                        vc.receiverMemberId = GukeModel.sid;
                        vc.receiverPortrait = GukeModel.portrait;
                        vc.receiverName = GukeModel.name;
                        vc.receiverPhone = GukeModel.telephone;
                        [self.navigationController pushViewController:vc animated:YES];
                        
                    } successBackfailError:^(id responseObject) {
                        
                    } failure:^(NSError *error) {
                        
                    }];

                }
            }];
        }
    }
   
}

#pragma mark - setter/getter
- (NSMutableArray *)items {
    if (!_items) {
        //set item
        _items = [@[
                    [YCXMenuItem menuItem:@"打电话"
                                    image:[UIImage imageNamed:@"yuyue_phone"]
                                      tag:100
                                 userInfo:nil],
                    [YCXMenuItem menuItem:@"发短信"
                                    image:[UIImage imageNamed:@"yuyue_message"]
                                      tag:101
                                 userInfo:nil],
                    [YCXMenuItem menuItem:@"在线沟通"
                                    image:[UIImage imageNamed:@"yuyue_huanxin"]
                                      tag:102
                                 userInfo:nil]
                    ] mutableCopy];
    }
    return _items;
}



@end
