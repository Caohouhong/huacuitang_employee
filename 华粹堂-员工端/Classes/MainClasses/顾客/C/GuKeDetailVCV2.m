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

@interface GuKeDetailVCV2 ()<UITableViewDelegate,UITableViewDataSource,GuKeDetailCell2Delegate>

@property (nonatomic, weak) UITableView *tableView;

@end

@implementation GuKeDetailVCV2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"顾客详情";
    [self drawView];
    [self requestData];
}

- (void)drawView
{
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_huifang"] style:UIBarButtonItemStylePlain target:self action:@selector(call)];
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

- (void)call
{

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
            
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 10006://复诊跟踪
        {
            ReCureDetailVC *vc = [[ReCureDetailVC alloc] init];
            
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 10007://高科技跟踪
        {
            HighTechDetailVC *vc = [[HighTechDetailVC alloc] init];
            
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 10008://月度规划
        {
            MonthDetailVC *vc = [[MonthDetailVC alloc] init];
            
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 10009://体检报告
        {
            HealthFormVC *vc = [[HealthFormVC alloc] init];
            
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 10010://秘密生活
        {
            SecretLiftVC *vc = [[SecretLiftVC alloc] init];
            
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 10011://秘密话题
        {
            SecretTopicVC *vc = [[SecretTopicVC alloc] init];
            
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 10012://回访记录
        {
            ReturnVisitVC *vc = [[ReturnVisitVC alloc] init];
            
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
