//
//  WoDeVC.m
//  华粹堂-员工端
//
//  Created by liqiang on 2016/11/14.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import "WoDeVC.h"
#import "WoDeOneTypeCell.h"
#import "WoDeTwoTypeCell.h"
#import "PerfectInfoVC.h"
#import "ChangePasswordViewController.h"
#import "LoginVC.h"

#define TitleArray @[@"账户安全",@"店面电话",@"我的业绩",@"退出登录"]

@interface WoDeVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;

@end

@implementation WoDeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"个人信息";
    
    [self drawView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

- (void)drawView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    //    tableView.tableFooterView = [self drawFooterView];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    tableView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,0);
    
//    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefersh)];
//    tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefersh)];
}


#pragma mark -
#pragma mark ================= <UITableViewDelegate,UITableViewDataSource> =================
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        WoDeOneTypeCell *cell = [WoDeOneTypeCell cellWithTableView:tableView];
        cell.model = [ModelMember sharedMemberMySelf];
        return cell;
    }
    
    
    WoDeTwoTypeCell *cell = [WoDeTwoTypeCell cellWithTableView:tableView];
    cell.iconImageView.image = [UIImage imageNamed:TitleArray[indexPath.section-1]];
    cell.titleLabel.text = TitleArray[indexPath.section - 1];
    
    if (indexPath.section == 2) {
        cell.detailLabel.hidden = NO;
        cell.arrowImageView.hidden = YES;
        cell.detailLabel.text = @"0510-82792222";
    }else{
        cell.detailLabel.hidden = YES;
        cell.arrowImageView.hidden = NO;
    }
    
    return cell;
    
    return [UITableViewCell new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 100;
    }
    
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0 || section == 1)
    {
        return 10;
    }
    
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        PerfectInfoVC *vc = [[PerfectInfoVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section == 1) {
        ChangePasswordViewController *vc = [[ChangePasswordViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section == 4) {
        [[ModelMember sharedMemberMySelf] logOut];
        WINDOW.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[LoginVC alloc] init]];
    }
}

@end
