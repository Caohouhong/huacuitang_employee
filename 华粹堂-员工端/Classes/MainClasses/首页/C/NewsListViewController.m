//
//  NewsListViewController.m
//  lingdaozhe
//
//  Created by aliviya on 16/6/30.
//  Copyright © 2016年 bckj. All rights reserved.
//

#import "NewsListViewController.h"
#import "ModelMessage.h"
#import "NewsDetailCell.h"
#import "ShowPlanViewController.h"
#import "BaseWebViewController.h"
//#import "VideoPlayVC.h"
//#import "TopicsVC.h"
//#import "TeacherIntroductVC.h"
@interface NewsListViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,assign) int pageIndex;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) UITableView *tableview;

@end

@implementation NewsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"消息列表";
    self.dataArray = [[NSMutableArray alloc] init];
    self.pageIndex = 1;
    [self drawView];
    
    if (self.groupType ==0) {
        self.title =  @"系统消息";
    }else if (self.groupType ==1) {
        self.title = @"满意度调查";
    }else if (self.groupType ==2) {
        self.title = @"公司公告";
    }
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self requestData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)drawView
{
    self.tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.view addSubview:self.tableview];
    
    self.tableview.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,0);
    
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefersh)];
    self.tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefersh)];
    
//    self.tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        self.pageIndex ++;
//        [self requestData];
//    }];
}

- (void)headerRefersh
{
    self.pageIndex = 1;
    [self requestData];
}

- (void)footerRefersh
{
    self.pageIndex ++;
    [self requestData];
}

-(void)requestData{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:[UtilString getNoNilString:[UserDefaults valueForKey:@"deviceToken"]] forKey:@"deviceId"];
    [params setObject:[NSString stringWithFormat:@"%d",self.groupType] forKey:@"groupType"];
    [params setObject:@(self.pageIndex) forKey:@"pageNo"];
    [params setObject:@"20" forKey:@"pageSize"];
    
    [[LQHTTPSessionManager sharedManager] LQPost:@"message/listGroupMessages" parameters:params showTips:@"正在加载..." success:^(id responseObject) {
        
        if (self.pageIndex == 1)
        {
            [self.dataArray removeAllObjects];
        }
        
        NSArray *arry = [NSMutableArray arrayWithArray:[ModelMessage mj_objectArrayWithKeyValuesArray:[responseObject valueForKey:@"data"]]];
        [self.dataArray addObjectsFromArray:arry];
        
        [self.tableview.mj_header endRefreshing];
        [self.tableview.mj_footer endRefreshing];
        [self.tableview reloadData];
        
        if (self.dataArray.count < 20)
        {
            [self.tableview.mj_footer endRefreshingWithNoMoreData];
        }
    } successBackfailError:^(id responseObject) {
        [self.tableview.mj_header endRefreshing];
        [self.tableview.mj_footer endRefreshing];
        if (self.pageIndex == 1)
        {
            [self.dataArray removeAllObjects];
        }else{
            self.pageIndex --;
        }
        
        [self.tableview reloadData];
    } failure:^(NSError *error) {
        [self.tableview.mj_header endRefreshing];
        [self.tableview.mj_footer endRefreshing];
        if (self.pageIndex == 1)
        {
            [self.dataArray removeAllObjects];
        }else{
            self.pageIndex --;
        }
        
        [self.tableview reloadData];
    }];
}

#pragma mark -
#pragma mark ================= <UITableViewDelegate,UITableViewDataSource> =================
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return self.dataArray.count;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsDetailCell *cell = [NewsDetailCell cellWithIdentify:@"NewsDetailCell" tableview:tableView];
    
    ModelMessage *model = self.dataArray[indexPath.row];

    [cell loadData:model];
    return cell;
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableviewCell"];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableviewCell"];
//        
//    }
//    ModelMessage *model = self.dataArray[indexPath.row];
//    cell.textLabel.text =model.messageContent;
//      return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 80;
//}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *title;
    
    ModelMessage *model = self.dataArray[indexPath.row];
    
    if (model.groupType == 0){
        title = @"系统消息";
    }else if (model.groupType == 1){
        title = @"满意度调查";
    }else if (model.groupType == 2){
        title = @"公司公告";
    }else {
        title = model.messageTitle;
    }
    
    if (model.linkType == 0){ //linkType 0 不带链接
        ShowPlanViewController *vc = [[ShowPlanViewController alloc] init];
        vc.viewTitle = title;
        vc.viewContent = model.messageContent;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        BaseWebViewController *webView = [[BaseWebViewController alloc] initWithTitle:title andUrl:model.linkParams];
        webView.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:webView animated:YES];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [NewsDetailCell cellHeight];
}
@end
