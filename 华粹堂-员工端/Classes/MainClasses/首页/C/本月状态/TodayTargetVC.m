//
//  TodayTargetVC.m
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/22.
//  Copyright © 2017年 LiQiang. All rights reserved.
//  今日目标

#import "TodayTargetVC.h"
#import "RechargeTableViewCell.h"
#import "HCTConnet.h"
#import "TodayTargetModel.h"
#import "HuaCuiTangHelper.h"

@interface TodayTargetVC ()<UITableViewDelegate, UITableViewDataSource>
{
    UILabel *topTextlabel;
}
@property (nonatomic, strong) NSMutableArray *beddingDataArray; //铺垫目标
@property (nonatomic, strong) NSMutableArray *salesDataArray;//销售目标
@property (nonatomic, strong) NSMutableArray *serviceDataArray;//基础服务目标
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSDictionary *responseDic; //返回结果
@end

@implementation TodayTargetVC

- (NSMutableArray *)beddingDataArray
{
    if (!_beddingDataArray) {
        _beddingDataArray = [NSMutableArray array];
    }
    
    return _beddingDataArray;
}

- (NSMutableArray *)salesDataArray
{
    if (!_salesDataArray) {
        _salesDataArray = [NSMutableArray array];
    }
    
    return _salesDataArray;
}

- (NSMutableArray *)serviceDataArray
{
    if (!_serviceDataArray) {
        _serviceDataArray = [NSMutableArray array];
    }
    
    return _serviceDataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"今日目标";
    [self drawView];
    
    [self requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)drawView{
    
    [self initHeaderView];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = COLOR_BackgroundColor;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    tableView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,35)
    .bottomSpaceToView(self.view,0);
}

//headerView
- (void)initHeaderView{
    UIView *holdView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 35)];
    holdView.backgroundColor = COLOR_BackgroundColor;
    [self.view addSubview:holdView];
    
    topTextlabel = [[UILabel alloc] init];
    topTextlabel.font = SYSTEM_FONT_(12);
    topTextlabel.textColor = COLOR_Gray;
    topTextlabel.text = [NSString stringWithFormat:@"时间：%@  计划人数：0人",[HuaCuiTangHelper getCurrentDateWithStyleYYYYMMDD]];
    [holdView addSubview:topTextlabel];
    
    topTextlabel.sd_layout
    .leftEqualToView(holdView).offset(15)
    .topEqualToView(holdView)
    .widthIs(ScreenWidth)
    .heightRatioToView(holdView,1);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0){
        return self.beddingDataArray.count;
    }else if (section == 1){
        return self.salesDataArray.count;
    }else {
        return self.serviceDataArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RechargeTableViewCell *cell = [RechargeTableViewCell cellWithTableView:self.tableView];
    if (indexPath.section == 0){
        cell.todayTargetModel = self.beddingDataArray[indexPath.row];
    }else if (indexPath.section == 1){
        cell.todayTargetModel = self.salesDataArray[indexPath.row];
    }else {
        cell.todayTargetModel = self.serviceDataArray[indexPath.row];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0){
        return (self.beddingDataArray.count > 0) ? 40 : 0;
    }else if (section == 1){
        return (self.salesDataArray.count > 0) ? 40 : 0;
    }else {
        return (self.serviceDataArray.count > 0) ? 40 : 0;
    }
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
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UIView *dividerLine1 = [[UIView alloc] init];
    dividerLine1.backgroundColor = backviewColor;
    [headerView addSubview:dividerLine1];
    
    UILabel *textlabel = [[UILabel alloc] init];
    textlabel.font = SYSTEM_FONT_BOLD_(15);
    textlabel.textColor = COLOR_Text_Blue;
    [headerView addSubview:textlabel];
    
    dividerLine1.sd_layout
    .leftEqualToView(headerView)
    .bottomEqualToView(headerView)
    .widthRatioToView(headerView,1)
    .heightIs(1);
    
    textlabel.sd_layout
    .leftSpaceToView(headerView,15)
    .topEqualToView(headerView)
    .widthRatioToView(headerView,0.8)
    .heightRatioToView(headerView,1);
    
    if (section == 0){
        NSString *bedSum = [NSString stringWithFormat:@"%@",[self.responseDic objectForKey:@"bedding_sum"]];
        NSString *result = [NSString stringWithFormat:@"铺垫目标%@人",bedSum];
        if (bedSum.length > 0){
            textlabel.attributedText = [HuaCuiTangHelper changeTextColorWithRestltStr:result changeText:bedSum andColor:COLOR_Red];
        }
        
    }else if (section == 1){
        NSString *salesSum = [NSString stringWithFormat:@"%@",[self.responseDic objectForKey:@"sales_sum"]];
        NSString *result = [NSString stringWithFormat:@"销售目标%@人",salesSum];
        if (salesSum.length > 0){
            textlabel.attributedText = [HuaCuiTangHelper changeTextColorWithRestltStr:result changeText:salesSum andColor:COLOR_Red];
        }
    }else {
        NSString *serviceSum = [NSString stringWithFormat:@"%@",[self.responseDic objectForKey:@"service_sum"]];
        NSString *result = [NSString stringWithFormat:@"基础服务%@人",serviceSum];
        if (serviceSum.length > 0){
            textlabel.attributedText = [HuaCuiTangHelper changeTextColorWithRestltStr:result changeText:serviceSum andColor:COLOR_Red];
        }
    }
    
    return headerView;
}

- (void)requestData{
    
    [LCProgressHUD showLoading:@"正在加载..."];
    
    NSMutableDictionary *requestParams = [[NSMutableDictionary alloc] init];
    [requestParams setValue:[ModelMember sharedMemberMySelf].memberId forKey:@"employeeId"];
    
    [HCTConnet getHomeDailyWork:requestParams success:^(id responseObject) {
        
        self.responseDic = responseObject;
        
        
        NSArray *bedArray =  [TodayTargetModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"beddingList"]];
        NSArray *salesArray =  [TodayTargetModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"salesList"]];
        NSArray *serviceArray =  [TodayTargetModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"serviceList"]];
        
        self.beddingDataArray = [NSMutableArray arrayWithArray:bedArray];
        self.salesDataArray = [NSMutableArray arrayWithArray:salesArray];
        self.serviceDataArray = [NSMutableArray arrayWithArray:serviceArray];
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        [self refreshUIWith:responseObject];

        
    } successBackfailError:^(id responseObject) {
        
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}

- (void)refreshUIWith:(NSDictionary *)dic{
    
    topTextlabel.text = [NSString stringWithFormat:@"时间：%@  计划人数：%@人",[dic objectForKey:@"todayTimeStr"],[dic objectForKey:@"target_sum"]];
}
@end
