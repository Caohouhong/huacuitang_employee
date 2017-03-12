//
//  YuYueVC.m
//  华粹堂-员工端
//
//  Created by liqiang on 2016/11/14.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import "YuYueVC.h"
#import "YuYueCell.h"
#import "ChhYuYueDetailVC.h"
#import "YuYueDateChooseVC.h"
#import "YuYueMenuView.h"
#import "NextAndLastDateView.h"
#import "HuaCuiTangHelper.h"
#import "HCTConnet.h"
#import "ServeModel.h"
#import "WaitServeTableViewCell.h"

@interface YuYueVC ()<UITableViewDelegate,UITableViewDataSource,YuYueMenuViewDelegate,NextAndLastDateViewDelegate>
{
    int dayNum;
    NSString *mBookTime;
}

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, weak) UIButton *todayBtn;
@property (nonatomic, weak) UIButton *tomorrowBtn;

@property (nonatomic, assign) long startTime;
@property (nonatomic, assign) long endTime;
@property (nonatomic, assign) int pageNo;

@property (nonatomic, copy) NSString *dateStr1;
@property (nonatomic, copy) NSString *dateStr2;

@property (nonatomic, strong) YuYueMenuView *menu;


/*******/
@property (nonatomic, strong) NextAndLastDateView *topView;

@end

@implementation YuYueVC

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"预约记录";
    self.pageNo = 1;
    self.view.backgroundColor = COLOR_BackgroundColor;
    
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"calendar"] style:UIBarButtonItemStylePlain target:self action:@selector(didClickRightBar)];
    self.navigationItem.rightBarButtonItem = rightBar;
    
    self.startTime = [NSDate getTodayZeroPointTimeInterval];
    self.endTime = [NSDate getTodayTwentyFourPointTimeInterval];
    
    [self drawView];
    //show hud
    [LCProgressHUD showLoading:@"正在加载..."];
    [self requestData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!self.menu.isRightViewHidden)
    {
        self.menu.hidden = NO;
    }
    [self headerRefersh];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (!self.menu.isRightViewHidden)
    {
        self.menu.hidden = YES;
    }
}

- (NextAndLastDateView *)topView
{
    if (_topView == nil){
        _topView = [[NextAndLastDateView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 35)];
        _topView.delegate = self;
        [_topView.nextBtn setTitle:@"下一天" forState:UIControlStateNormal];
        [_topView.lastBtn setTitle:@"上一天" forState:UIControlStateNormal];
    }
    return _topView;
}

//获取本月年月日
- (void)nowDateDay{
    dayNum = 0;
    NSString *dateString = [HuaCuiTangHelper getPriousorLaterDateFromNowWithDay:dayNum];
    self.topView.dataLabel.text = dateString;
    
    mBookTime = [self changeDateStringStyleWith:dateString];
}

- (void)drawView
{
    [self.view addSubview:self.topView];
    [self nowDateDay];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = COLOR_BackgroundColor;
    tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    tableView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,35)
    .bottomSpaceToView(self.view,0);
    
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefersh)];
    tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefersh)];
    
    YuYueMenuView *menu = [[YuYueMenuView alloc] initWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, ScreenHeight2)];
    menu.menuViewDelegate = self;
    [self.navigationController.view addSubview:menu];
    self.menu = menu;
    
    @weakify(self);
    self.menu.didClickDateBlick = ^(NSDate *startDate,NSDate*endDate){
        @strongify(self);
        if (startDate) {
            self.startTime = [NSDate getZeroPointTimeIntervalWithDate:startDate];
            self.dateStr1 = [NSDate dateStringWithTimeDate:startDate dateFormat:@"yyyy年MM日dd"];
        }
        
        self.topView.dataLabel.text = self.dateStr1;
        
        mBookTime = [self changeDateStringStyleWith:self.dateStr1];
        
        //show hud
        [LCProgressHUD showLoading:@"正在加载..."];
        [self requestData];
        
//        if (endDate) {
//            self.endTime = [NSDate getTwentyFourPointTimeIntervalWithDate:endDate];
//            self.dateStr2 = [NSDate dateStringWithTimeDate:endDate dateFormat:@"yyyy-MM-dd"];
//        }
//        
//
//        if([self.dateStr1 isEqualToString:self.dateStr2]) {
////            self.timeLabel.text = [NSString stringWithFormat:@"预约时间: %@",self.dateStr1];
//        }else {
////            self.timeLabel.text = [NSString stringWithFormat:@"预约时间: %@~%@",self.dateStr1,self.dateStr2];
//        }
//        NSDate *currentDate = [NSDate date];//获取当前时间，日期
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//        [dateFormatter setDateFormat:@"YYYY-MM-dd"];
//        NSString *dateString = [dateFormatter stringFromDate:currentDate];
//        if(!self.dateStr1.length) {
//            self.timeLabel.text = [NSString stringWithFormat:@"预约时间: %@",dateString];
//        }
       
//        [self requestDataWithStartTime:self.startTime endTime:self.endTime];
        
        
        
    };
}

- (void)didClickTodayBtn
{
    self.todayBtn.selected = YES;
    self.tomorrowBtn.selected = NO;
    
    self.startTime = [NSDate getTodayZeroPointTimeInterval];
    self.endTime = [NSDate getTodayTwentyFourPointTimeInterval];
    
    [self headerRefersh];
}

- (void)didClickTomorrowBtn
{
    self.todayBtn.selected = NO;
    self.tomorrowBtn.selected = YES;
    
    NSTimeInterval secondsPerDay = 24*60*60;
    NSDate *tomorrow = [NSDate dateWithTimeIntervalSinceNow:secondsPerDay];
    
    self.startTime = [NSDate getZeroPointTimeIntervalWithDate:tomorrow];
    self.endTime = [NSDate getTwentyFourPointTimeIntervalWithDate:tomorrow];
    [self headerRefersh];
}

- (void)didClickRightBar
{
//    YuYueDateChooseVC *vc = [[YuYueDateChooseVC alloc] init];
//    vc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:vc animated:YES];
//    
//    @weakify(self);
//    vc.didClickDateBlock = ^(NSDate *date){
//        @strongify(self);
//        [self requestDataWithStartTime:[NSDate getZeroPointTimeIntervalWithDate:date] endTime:[NSDate getTwentyFourPointTimeIntervalWithDate:date]];
//    };
    
    
    if (self.menu.isRightViewHidden) {
        [self.menu openLeftView];
    }
}



#pragma mark - ==== <UITableViewDelegate,UITableViewDataSource> ========
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
    WEAK(weakSelf);
    cell.block = ^{
        ServeModel *model = self.dataArray[indexPath.row];
        [weakSelf sendMessageToSomeone:model.mobile_phone];
    };
    
    cell.model = self.dataArray[indexPath.row];
    
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 125;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ModelHealthBooking *model  = self.dataArray[indexPath.section];
    ChhYuYueDetailVC *vc = [[ChhYuYueDetailVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.healthbookingId = model.sid;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark ============= 网络 =================
- (void)requestData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:[ModelMember sharedMemberMySelf].memberId forKey:@"employeeId"];
    [params setValue:@(self.pageNo) forKey:@"pageNo"];
    [params setValue:@(20) forKey:@"pageSize"];
    [params setValue:mBookTime forKey:@"bookTime"];
    
    [HCTConnet getHomeHealthBookingV2:params success:^(id responseObject) {
        
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

//到店提醒
- (void)sendMessageToSomeone:(NSString *)phoneNum{
    [LCProgressHUD showLoading:@"正在提醒..."];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
     [params setValue:[ModelMember sharedMemberMySelf].memberId forKey:@"memberId"];
    [params setValue:@"" forKey:@"mobilePhone"];
    [params setValue:@(11) forKey:@"operation"]; //11-到店提醒
    [params setValue:@(1) forKey:@"codeType"];
    
    [HCTConnet getOtherSendAuthCode:params success:^(id responseObject) {
        
        [LCProgressHUD showSuccess:@"提醒成功"];
        [self requestData];
        
    } successBackfailError:^(id responseObject) {
        
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

#pragma mark NextAndLastDateViewDelegate 上一天下一天
- (void)nextAndLastDateBtnClickWithTag:(NextAndLastDateViewButtonType)tag
{
    switch (tag) {
        case NextAndLastDateViewButtonTypeLast:
        {
            dayNum--;
        }
            break;
        case NextAndLastDateViewButtonTypeNext:
        {
            dayNum++;
        }
            break;
    }
    
    NSString *dateString = [HuaCuiTangHelper getPriousorLaterDateFromNowWithDay:dayNum];
    self.topView.dataLabel.text = dateString;
    
    mBookTime = [self changeDateStringStyleWith:dateString];
    //show hud
    [LCProgressHUD showLoading:@"正在加载..."];
    [self requestData];
}

//改变时间格式
- (NSString *)changeDateStringStyleWith:(NSString *)dateString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    NSDate *date = [formatter dateFromString:dateString];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *newDateStr = [formatter stringFromDate:date];
    
    return newDateStr;
}
@end
