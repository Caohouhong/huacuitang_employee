//
//  WaitingServeVC.m
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/23.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "WaitingServeVC.h"
#import "WaitServeTableViewCell.h"
#import "HCTConnet.h"
#import "ServeModel.h"
#import "HuaCuiTangHelper.h"

@interface WaitingServeVC ()<UITableViewDelegate, UITableViewDataSource>
{
    UILabel *topTextlabel;
}
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, assign) int pageNo;
@end

@implementation WaitingServeVC

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"今明日待服务";
    self.pageNo = 1;
    [self drawView];
    //show hud
    [LCProgressHUD showLoading:@"正在加载..."];
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
    
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefersh)];
    tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefersh)];
}

//headerView
- (void)initHeaderView{
    UIView *holdView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 35)];
    holdView.backgroundColor = COLOR_BackgroundColor;
    [self.view addSubview:holdView];
    
    topTextlabel = [[UILabel alloc] init];
    topTextlabel.font = SYSTEM_FONT_(12);
    topTextlabel.text = [NSString stringWithFormat:@"时间：%@~%@",[HuaCuiTangHelper getPriousorLaterDateFromNowWithDay:0], [HuaCuiTangHelper getPriousorLaterDateFromNowWithDay:1]];
    topTextlabel.textColor = COLOR_Gray;
    [holdView addSubview:topTextlabel];
    
    topTextlabel.sd_layout
    .leftEqualToView(holdView).offset(15)
    .topEqualToView(holdView)
    .widthIs(ScreenWidth)
    .heightRatioToView(holdView,1);

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WaitServeTableViewCell *cell = [WaitServeTableViewCell cellWithTableView:self.tableView];
    
    cell.model = self.dataArray[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 125;
}

#pragma mark ============= 网络 =================
- (void)requestData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:[ModelMember sharedMemberMySelf].memberId forKey:@"employeeId"];
    [params setValue:@(self.pageNo) forKey:@"pageNo"];
    [params setValue:@(20) forKey:@"pageSize"];
    
    [HCTConnet getHomeHealthTomorrow:params success:^(id responseObject) {
        NSArray *array =  [ServeModel mj_objectArrayWithKeyValuesArray:[responseObject valueForKey:@"data"]];
        
        if (self.pageNo == 1)
        {
            self.dataArray = [NSMutableArray arrayWithArray:array];
        }
        else
        {
            [self.dataArray addObjectsFromArray:array];
        }
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        if (array.count < 20)
        {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
    } successBackfailError:^(id responseObject) {
        
        self.dataArray = [NSMutableArray array];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}

//刷新
- (void)headerRefersh
{
    self.pageNo = 1;
    [self requestData];
}

- (void)footerRefersh
{
    self.pageNo ++;
    [self requestData];
}

@end
