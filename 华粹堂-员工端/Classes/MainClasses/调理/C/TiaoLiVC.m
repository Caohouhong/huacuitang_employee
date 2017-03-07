//
//  TiaoLiVC.m
//  华粹堂-员工端
//
//  Created by liqiang on 2016/11/14.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import "TiaoLiVC.h"
#import "TiaoLiCell.h"
#import "BianJiTiaoLiVC.h"
#import "TopSelectView.h"
#import "WaitServeTableViewCell.h"
#import "TiaoliDetailVC.h"
#import "HCTConnet.h"

@interface TiaoLiVC ()<UITableViewDelegate,UITableViewDataSource,TopSelectViewDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) TopSelectView *topSelectView;

@property (nonatomic, assign) int pageNo;
@property (nonatomic, assign) int type;

@end

@implementation TiaoLiVC

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"调理备忘列表";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = COLOR_BackgroundColor;
    self.type = 1;
    self.pageNo = 1;
    
    [self drawView];
    [self requestData];
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
    cell.trackModel = self.dataArray[indexPath.row];
    
    if (self.type == 1){
        cell.rightBottomLabel.text = @"状态：未填写";
        cell.rightBottomLabel.textColor = COLOR_Gray;
    }else if (self.type == 2){
        cell.rightBottomLabel.text = @"状态：审核中";
        cell.rightBottomLabel.textColor = COLOR_TEXT_ORANGE_RED;
    }else {
        cell.rightBottomLabel.text = @"状态：已审核";
        cell.rightBottomLabel.textColor = COLOR_TEXT_GREEN_RED;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 125;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TiaoliDetailVC *vc = [[TiaoliDetailVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark － =========== 网络 =================
- (void)requestData
{
    [LCProgressHUD showLoading:@"正在加载..."];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:[ModelMember sharedMemberMySelf].memberId forKey:@"e_id"];
    [params setValue:@(self.pageNo) forKey:@"pageNo"];
    [params setValue:@(20) forKey:@"pageSize"];
    [params setValue:@(self.type) forKey:@"state"]; //1-未 2-中 3－已
    
   [HCTConnet getHomeTrack_Forget_List:params success:^(id responseObject)  {
        
        if (self.pageNo == 1)
        {
            [self.dataArray removeAllObjects];
        }
        
        NSArray *arry = [NSMutableArray arrayWithArray:[ModelTrackManage mj_objectArrayWithKeyValuesArray:[responseObject valueForKey:@"data"]]];
        [self.dataArray addObjectsFromArray:arry];
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
        
        if (self.dataArray.count < 20)
        {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
    } successBackfailError:^(ModelFieldError *responseObject) {
        self.dataArray = [NSMutableArray array];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

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

#pragma mark - TopSelectViewDelegate 顶部按钮代理
- (void)topButtonClickWithTag:(TopSelectViewType)tag
{
       [self.topSelectView.leftButton setTitleColor:COLOR_darkGray forState:UIControlStateNormal];
       [self.topSelectView.rightButton setTitleColor:COLOR_darkGray forState:UIControlStateNormal];
       [self.topSelectView.centerButton setTitleColor:COLOR_darkGray forState:UIControlStateNormal];
    
    switch (tag) {
        case TopSelectViewTypeLeft:
            [self.topSelectView.leftButton setTitleColor:COLOR_Text_Blue forState:UIControlStateNormal];
            self.type = 1;
            break;
        case TopSelectViewTypeCenter:
            [self.topSelectView.centerButton setTitleColor:COLOR_Text_Blue forState:UIControlStateNormal];
            self.type = 2;
            break;
        case TopSelectViewTypeRight:
            [self.topSelectView.rightButton setTitleColor:COLOR_Text_Blue forState:UIControlStateNormal];
            self.type = 3;
            break;
        default:
            break;
    }
    
    [self requestData];
}

@end
