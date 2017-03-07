//
//  DailySummaryVC.m
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/27.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "DailySummaryVC.h"
#import "RechargeTableViewCell.h"
#import "HCTConnet.h"
#import "HuaCuiTangHelper.h"
#import "SelfDailySummaryVC.h"

@interface DailySummaryVC ()<UITableViewDelegate, UITableViewDataSource>
{
     UILabel *topTextlabel;
}
@property (nonatomic, strong) NSMutableArray *doneDataArray; //已完成
@property (nonatomic, strong) NSMutableArray *doingDataArray;//未完成
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSDictionary *responseDic; //返回结果
@end

@implementation DailySummaryVC

- (NSMutableArray *)doneDataArray
{
    if (!_doneDataArray) {
        _doneDataArray = [NSMutableArray array];
    }
    
    return _doneDataArray;
}

- (NSMutableArray *)doingDataArray
{
    if (!_doingDataArray) {
        _doingDataArray = [NSMutableArray array];
    }
    
    return _doingDataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"今日总结";
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_write_22x22"] style:UIBarButtonItemStylePlain target:self action:@selector(didClickRightBar)];
    self.navigationItem.rightBarButtonItem = rightBar;
    
    [self drawView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self requestData];
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
    topTextlabel.text = [NSString stringWithFormat:@"门店：%@    时间：%@",[ModelMember sharedMemberMySelf].shopName,[HuaCuiTangHelper getCurrentDateWithStyleYYYYMMDD]];
    [holdView addSubview:topTextlabel];
    
    topTextlabel.sd_layout
    .leftEqualToView(holdView).offset(15)
    .topEqualToView(holdView)
    .widthIs(ScreenWidth)
    .heightRatioToView(holdView,1);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0){
        return self.doneDataArray.count;
    }else{
        return self.doingDataArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RechargeTableViewCell *cell = [RechargeTableViewCell cellWithTableView:self.tableView];
    if (indexPath.section == 0){
        cell.dailySumModel = self.doneDataArray[indexPath.row];
        cell.rightLabel.textColor = COLOR_TEXT_GREEN_RED;
    }else {
        cell.dailySumModel = self.doingDataArray[indexPath.row];
        cell.rightLabel.textColor = COLOR_TEXT_ORANGE_RED;
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
        return (self.doneDataArray.count > 0) ? 40 : 0;
    }else {
        return (self.doingDataArray.count > 0) ? 40 : 0;
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
        NSString *bedSum = [NSString stringWithFormat:@"%i",[[self.responseDic objectForKey:@"finishSum"] intValue]];
        NSString *result = [NSString stringWithFormat:@"已完成员工(%@)",bedSum];
        if (bedSum.length > 0){
            textlabel.attributedText = [HuaCuiTangHelper changeTextColorWithRestltStr:result changeText:bedSum andColor:COLOR_Red];
        }
        
    }else {
        NSString *salesSum = [NSString stringWithFormat:@"%i",[[self.responseDic objectForKey:@"unFinishSum"] intValue]];
        NSString *result = [NSString stringWithFormat:@"未完成员工(%@)",salesSum];
        if (salesSum.length > 0){
            textlabel.attributedText = [HuaCuiTangHelper changeTextColorWithRestltStr:result changeText:salesSum andColor:COLOR_Red];
        }
    }
    
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     SelfDailySummaryVC *dailyVC = [[SelfDailySummaryVC alloc] init];
     dailyVC.isCheck = YES;
     dailyVC.type = 0;
     dailyVC.hidesBottomBarWhenPushed = YES;
    
    if (indexPath.section == 0){ //已完成
        DailySummaryModel *model = self.doneDataArray[indexPath.row];
        dailyVC.employeeId = model.e_id;
        dailyVC.userName = model.e_name;
        dailyVC.conent = model.contenet;
        dailyVC.workSummaryId = model.workSummaryId;
        [self.navigationController pushViewController:dailyVC animated:YES];
    }else {
        DailySummaryModel *model = self.doingDataArray[indexPath.row];
        dailyVC.employeeId = model.e_id;
        dailyVC.userName = model.e_name;
        dailyVC.conent = model.contenet;
        dailyVC.workSummaryId = model.workSummaryId;
        [self.navigationController pushViewController:dailyVC animated:YES];
    }
}

#pragma mark - ======网络==========
- (void)requestData{
    
    [LCProgressHUD showLoading:@"正在加载..."];
    
    NSMutableDictionary *requestParams = [[NSMutableDictionary alloc] init];
    
    [requestParams setValue:[HuaCuiTangHelper getCurrentDateWithStyleStr:@"YYYY-MM-dd"] forKey:@"datetime"];
    [requestParams setValue:[ModelMember sharedMemberMySelf].s_id forKey:@"shopId"];
    
    [HCTConnet getHomeGetWorkSumToday:requestParams success:^(id responseObject) {
        
        self.responseDic = responseObject;
        
        NSArray *bedArray =  [DailySummaryModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"finishList"]];
        NSArray *salesArray =  [DailySummaryModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"unFinishList"]];
        
        [self.doneDataArray removeAllObjects];
        [self.doingDataArray removeAllObjects];
        
        [self.doneDataArray addObjectsFromArray:bedArray];
        [self.doingDataArray addObjectsFromArray:salesArray];
        
        [self.tableView reloadData];
        
        
    } successBackfailError:^(id responseObject) {
        
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}

//自己总结
- (void)didClickRightBar
{
    SelfDailySummaryVC *dailyVC = [[SelfDailySummaryVC alloc] init];
    dailyVC.employeeId = [ModelMember sharedMemberMySelf].memberId;
    dailyVC.userName = [ModelMember sharedMemberMySelf].name;
    dailyVC.isCheck = NO;
    dailyVC.type = 1;
    dailyVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:dailyVC animated:YES];
}

@end
