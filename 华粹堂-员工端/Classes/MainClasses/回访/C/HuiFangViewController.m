//
//  HuiFangViewController.m
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/27.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "HuiFangViewController.h"
#import "TopSelectView.h"
#import "WaitServeTableViewCell.h"
#import "HuiFangDetailVC.h"
#import "HCTConnet.h"
#import "HuiFangModel.h"

@interface HuiFangViewController ()<UITableViewDelegate, UITableViewDataSource,TopSelectViewDelegate>
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) TopSelectView *topSelectView;
@property (nonatomic, strong) NSMutableArray *cacheArray;

@property (nonatomic, assign) int pageNo;
@property (nonatomic, assign) int mType;
@end

@implementation HuiFangViewController

- (NSMutableArray *)cacheArray
{
    if (!_cacheArray){
        _cacheArray = [NSMutableArray array];
    }
    return _cacheArray;
}


- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"服务回访";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = COLOR_BackgroundColor;
    self.mType = 0;
    self.pageNo = 1;
    
    [self drawView];
    
    [self reloadCacheData];
}

- (void)drawView
{
    [self initHeaderView];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = HEXCOLOR(0xeeeeee);
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 8)];
    headerView.backgroundColor = HEXCOLOR(0xeeeeee);
    tableView.tableHeaderView = headerView;
    
    tableView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,35)
    .bottomSpaceToView(self.view,0);
    
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefersh)];
    tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefersh)];
}

- (void)initHeaderView{
    _topSelectView = [[TopSelectView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 35)];
    [_topSelectView.leftButton setTitle:@"未填写" forState:UIControlStateNormal];
    [self.topSelectView.leftButton setTitleColor:COLOR_Text_Blue forState:UIControlStateNormal];
    [_topSelectView.centerButton setTitle:@"审核中" forState:UIControlStateNormal];
    [_topSelectView.rightButton setTitle:@"已审核" forState:UIControlStateNormal];
    _topSelectView.delegate = self;
    [self.view addSubview:self.topSelectView];
}


#pragma mark - ==== UITableViewDelegate,UITableViewDataSource ====
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
    
    cell.huiFangModel = self.dataArray[indexPath.row];
    
    if (self.mType == 1){
        cell.rightBottomLabel.text = @"状态：审核中";
        cell.rightBottomLabel.textColor = COLOR_TEXT_ORANGE_RED;
    }else if (self.mType == 2){
        cell.rightBottomLabel.text = @"状态：已审核";
        cell.rightBottomLabel.textColor = COLOR_TEXT_GREEN_RED;
    }else {
        cell.rightBottomLabel.text = @"状态：未填写";
        cell.rightBottomLabel.textColor = COLOR_darkGray;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 125;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HuiFangModel *model = self.dataArray[indexPath.row];
    HuiFangDetailVC *vc = [[HuiFangDetailVC alloc] init];
    vc.model = model;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark － =========== 网络 =================
- (void)requestData
{
    [LCProgressHUD showLoading:@"正在加载..."];
    
    NSMutableDictionary *requestParams = [[NSMutableDictionary alloc] init];
    
    [requestParams setValue:[ModelMember sharedMemberMySelf].memberId forKey:@"employeeId"];
    [requestParams setValue:@(self.mType) forKey:@"state"]; // 1-审核中 2-已审核
    [requestParams setValue:@(self.pageNo) forKey:@"pageNo"];
    [requestParams setValue:@(20) forKey:@"pageSize"];
    
   [HCTConnet getHomeTelVisitListV2:requestParams success:^(id responseObject){
        
        if (self.pageNo == 1)
        {
            [self.dataArray removeAllObjects];
        }
        
        NSArray *arry = [NSMutableArray arrayWithArray:[HuiFangModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]]];
       
        [self.dataArray addObjectsFromArray:arry];
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
       
        [self.tableView reloadData];
        if (self.dataArray.count < 20)
        {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
       
    } successBackfailError:^(ModelFieldError *responseObject) {
        
        [self.dataArray removeAllObjects];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
       
    }  failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}

- (void)headerRefersh
{
    if (self.mType == 0){
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        return;
    }

    self.pageNo = 1;
    [self requestData];
}

- (void)footerRefersh
{
    
    if (self.mType == 0){
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        return;
    }
    self.pageNo ++;
    [self requestData];
}


//加载未填写的数据
- (void)reloadCacheData{
    NSArray *Tarray = [[DataManage sharedMemberMySelf] getHuiFangModelArray];
    for(ModelTrackManage * model in Tarray) {
        if([model.state isEqualToString:@"1"]){ //1为未填写
            [self.cacheArray addObject:model];
        }
    }
    [self.dataArray addObjectsFromArray:self.cacheArray];
    [self.tableView reloadData];
}


#pragma mark - TopSelectViewDelegate 顶部按钮代理
- (void)topButtonClickWithTag:(TopSelectViewType)tag
{
    [self.topSelectView.leftButton setTitleColor:COLOR_darkGray forState:UIControlStateNormal];
    [self.topSelectView.rightButton setTitleColor:COLOR_darkGray forState:UIControlStateNormal];
    [self.topSelectView.centerButton setTitleColor:COLOR_darkGray forState:UIControlStateNormal];
    
    [self.dataArray removeAllObjects];
    self.pageNo = 1;
    
    switch (tag) {
        case TopSelectViewTypeLeft:
            [self.topSelectView.leftButton setTitleColor:COLOR_Text_Blue forState:UIControlStateNormal];
            self.mType = 0;
            [self.dataArray addObjectsFromArray:self.cacheArray];
            [self.tableView reloadData];
            break;
        case TopSelectViewTypeCenter:
            [self.topSelectView.centerButton setTitleColor:COLOR_Text_Blue forState:UIControlStateNormal];
            self.mType = 1;
             [self requestData];
            break;
        case TopSelectViewTypeRight:
            [self.topSelectView.rightButton setTitleColor:COLOR_Text_Blue forState:UIControlStateNormal];
            self.mType = 2;
             [self requestData];
            break;
        default:
            break;
    }
    
   
}

@end
