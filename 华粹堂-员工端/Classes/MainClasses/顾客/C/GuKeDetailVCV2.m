//
//  GuKeDetailVCV2.m
//  华粹堂-员工端
//
//  Created by 李强 on 2017/2/21.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "GuKeDetailVCV2.h"
#import "GuKeDetailCell1.h"
#import "GuKeDetailCell2.h"
#import "AccountInfoVC.h"
#import "UserInfoVC.h"
#import "LifeViewController.h"
#import "SubHealthVC.h"
#import "BodyDetailVC.h"
#import "ReCureDetailVC.h"
#import "HighTechDetailVC.h"
#import "MonthDetailVC.h"
#import "HealthFormVC.h"
#import "ReturnVisitVC.h"
#import "SecretLiftVC.h"
#import "SecretTopicVC.h"
#import "NurseHealthVC.h"
#import "HCTConnet.h"
#import "AccountInfoDetailVC.h"
#import "YCXMenu.h"

@interface GuKeDetailVCV2 ()<UITableViewDelegate,UITableViewDataSource,GuKeDetailCell2Delegate>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) UIButton *rightButton;

@property (nonatomic , strong) NSMutableArray *items;
@end

@implementation GuKeDetailVCV2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"顾客详情";
    
    _rightButton = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth - 30, 0, 10, 1)];
    _rightButton.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_rightButton];

    
    [self drawView];
    
    [self requestData];
}

- (void)drawView
{
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_chat_22x22"] style:UIBarButtonItemStylePlain target:self action:@selector(didClickRightBar:)];
    self.navigationItem.rightBarButtonItem = barBtn;
    
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = HEXCOLOR(0xeeeeee);
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    tableView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,0);
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
                    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",self.model.mobile_phone];//回访手机号
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
                }else if (index == 1){
                    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"sms://%@",self.model.mobile_phone];//回访手机号
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
                }else if (index == 2){
                    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
                    [params setValue:self.model.sid forKey:@"customerId"];
                    
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



#pragma mark -
#pragma mark ================= <UITableViewDelegate,UITableViewDataSource> =================
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        GuKeDetailCell1 *cell = [GuKeDetailCell1 cellWithTableView:tableView];
        cell.model = self.model;
        return cell;
    }
    if (indexPath.section == 1) {
        GuKeDetailCell2 *cell = [GuKeDetailCell2 cellWithTableView:tableView];
        cell.delegate = self;
        return cell;
    }
    
    return [UITableViewCell new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 210;
    }
    if (indexPath.section == 1) {
        return ScreenWidth;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

#pragma mark GuKeDetailCell2Delegate 九宫格代理
- (void)guKeDetailBtnActionWithTag:(int)tag
{
    //100开始
    switch (tag) {
        case 10000://账户信息
        {
          AccountInfoVC *vc = [[AccountInfoVC alloc] init];
//            AccountInfoDetailVC *vc = [[AccountInfoDetailVC alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.YongHuId = self.model.sid;
            
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 10001://客户资料
        {
            UserInfoVC *vc = [[UserInfoVC alloc] init];
            vc.YongHuId = self.model.sid;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 10002://生活起居
        {
            LifeViewController *vc = [[LifeViewController alloc] init];
            vc.YongHuId = self.model.sid;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 10003://气医亚健康
        {
            SubHealthVC *vc = [[SubHealthVC alloc] init];
            vc.YongHuId = self.model.sid;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 10004://体质辩证
        {
            BodyDetailVC *vc = [[BodyDetailVC alloc] init];
            vc.YongHuId = self.model.sid;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 10005://调理备忘
        {
            NurseHealthVC *vc = [[NurseHealthVC alloc] init];
            vc.YongHuId = self.model.sid;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 10006://复诊跟踪
        {
            ReCureDetailVC *vc = [[ReCureDetailVC alloc] init];
            vc.YongHuId = self.model.sid;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 10007://高科技跟踪
        {
            HighTechDetailVC *vc = [[HighTechDetailVC alloc] init];
            vc.YongHuId = self.model.sid;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 10008://月度规划
        {
            MonthDetailVC *vc = [[MonthDetailVC alloc] init];
            vc.YongHuId = self.model.sid;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 10009://体检报告
        {
            HealthFormVC *vc = [[HealthFormVC alloc] init];
            vc.YongHuId = self.model.sid;
            vc.name = self.model.name;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 10010://秘密生活
        {
            SecretLiftVC *vc = [[SecretLiftVC alloc] init];
            vc.YongHuId = self.model.sid;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 10011://秘密话题
        {
            SecretTopicVC *vc = [[SecretTopicVC alloc] init];
            vc.YongHuId = self.model.sid;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 10012://回访记录
        {
            ReturnVisitVC *vc = [[ReturnVisitVC alloc] init];
            vc.YongHuId = self.model.sid;

            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark - ======网络======
- (void)requestData
{
    //show hud
    [LCProgressHUD showLoading:@"正在加载..."];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setValue:[ModelMember sharedMemberMySelf].memberId forKey:@"employeeId"];
    [params setValue:self.model.sid forKey:@"customerId"];
    
    [HCTConnet getCustomerInfoV2:params success:^(id responseObject) {
        
       self.model = [ModelGuKe mj_objectWithKeyValues:responseObject];
        
       [self.tableView reloadData];
        
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}

@end
