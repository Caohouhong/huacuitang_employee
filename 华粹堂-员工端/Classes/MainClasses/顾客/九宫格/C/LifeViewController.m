//
//  LifeViewController.m
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/28.
//  Copyright © 2017年 LiQiang. All rights reserved.
//  生活起居

#import "LifeViewController.h"
#import "ChhYuYueTableViewCell.h"
#import "HuaCuiTangHelper.h"
#import "HCTConnet.h"

@interface LifeViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSArray *titleArray;
    
    NSArray *baseArray;

}
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *totalArray;

@end

@implementation LifeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!self.totalArray){
        _totalArray = [NSMutableArray array];
    }
    
    self.navigationItem.title = @"生活起居";
    titleArray = @[@[@"生活作息",@"工作情况",@"压力情绪"],@[@"饮食状况",@"正常早餐",@"口味偏好",@"口味异感"],@[@"饮水情况",@"量",@"小便",@"量",@"大便",@"间隔"]];
    [self drawView];
    [self requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)drawView{
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    headerView.backgroundColor = COLOR_BackgroundColor;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = COLOR_BackgroundColor;
    tableView.tableHeaderView = headerView;
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return titleArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = titleArray[section];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChhYuYueTableViewCell *cell = [ChhYuYueTableViewCell cellWithTableView:self.tableView];

     cell.leftLabel.attributedText = [HuaCuiTangHelper changeTextColorWithRestltStr:[NSString stringWithFormat:@"%@:  %@",titleArray[indexPath.section][indexPath.row],baseArray[indexPath.section][indexPath.row]] changeText:baseArray[indexPath.section][indexPath.row] andColor:COLOR_Gray];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    footerView.backgroundColor = COLOR_BackgroundColor;
    
    return footerView;
}
#pragma mark - ====网络====
- (void)requestData
{
    [LCProgressHUD showLoading:@"正在加载..."];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:self.YongHuId forKey:@"customerId"];
[HCTConnet getLifeViewController:params success:^(id responseObject) {
    
    self.model = [LifeViewModel mj_objectWithKeyValues:responseObject];
   
    
  baseArray  = @[@[[self judgeString:self.model.dic_ls_values],[self judgeString:self.model.dic_work_values],[self judgeString:self.model.dic_es_values]],@[[self judgeString:self.model.dic_fs_values],[self judgeString:self.model.dic_bf_values],[self judgeString:self.model.dic_flavor_values],[self judgeString:self.model.dic_texture_values]],@[[self judgeString:self.model.dic_ws_values],[self judgeString:self.model.dic_ws_amount_values],[self judgeString:self.model.dic_piss_values],[self judgeString:self.model.dic_piss_amount_values],[self judgeString:self.model.dic_faeces_values],[self judgeString:self.model.dic_faeces_interval]]];
    
    [self.tableView reloadData];
} successBackfailError:^(id responseObject) {
    
} failure:^(NSURLSessionDataTask *operation, NSError *error) {
    
}];
    
}
- (NSString *)judgeString:(id)str{
    NSString *result = str?str:@"";
    return result;
}
@end
