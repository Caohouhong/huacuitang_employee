//
//  RechargeViewController.m
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/22.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "RechargeViewController.h"
#import "RechargeTableViewCell.h"
#import "HCTConnet.h"
#import "HuaCuiTangHelper.h"
#import "RechargeModel.h"
#import "NextAndLastDateView.h"

@interface RechargeViewController ()<UITableViewDelegate,UITableViewDataSource,NextAndLastDateViewDelegate>
{
    NSArray *nameArray;
    NSArray *imageArray;
    UILabel *moneyTextlabel;
    int monthNum;
    NSString *mYear;
    NSString *mMonth;
}

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) NSDictionary *responseDic;
@property (nonatomic, strong) RechargeModel *model;
@property (nonatomic, strong) NextAndLastDateView *topView;
@end

@implementation RechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = (self.viewType == RechargeVCTypeRecharge) ? @"本月销售业绩" : @"本月消耗业绩";
    self.automaticallyAdjustsScrollViewInsets = NO;
    imageArray = @[@"recharge_jiu_37x37",@"recharge_jingluo_37x37",@"recharge_tizhi_37x37",@"recharge_fuwu_37x37",@"recharge_qita_37x37"];
    nameArray = @[@"灸",@"经络",@"体质",@"服务",@"其它"];
    self.responseDic = [[NSDictionary alloc] init];
    [self drawView];
    [self nowYearAndMonth];
    [self requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)drawView{
    
    [self.view addSubview:self.topView];
    
    [self initHeaderView];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = COLOR_BackgroundColor;
    tableView.tableHeaderView = self.headerView;
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
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 85)];
    headerView.backgroundColor = COLOR_BackgroundColor;
    self.headerView = headerView;
    
    UIView *holdView = [[UIView alloc] init];
    holdView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:holdView];
    
    UILabel *textlabel = [[UILabel alloc] init];
    textlabel.text = (self.viewType == RechargeVCTypeRecharge) ? @"本月总充值" : @"本月总消费";
    textlabel.font = SYSTEM_FONT_(14);
    textlabel.textAlignment = NSTextAlignmentCenter;
    textlabel.textColor = COLOR_Black;
    [headerView addSubview:textlabel];
    
    moneyTextlabel = [[UILabel alloc] init];
    moneyTextlabel.text = @"0.00";
    moneyTextlabel.font = SYSTEM_FONT_BOLD_(20);
    moneyTextlabel.textAlignment = NSTextAlignmentCenter;
    moneyTextlabel.textColor = COLOR_Text_Blue;
    [headerView addSubview:moneyTextlabel];
    
    holdView.sd_layout
    .leftEqualToView(headerView)
    .topSpaceToView(headerView,10)
    .widthRatioToView(headerView,1)
    .heightIs(70);
    
    textlabel.sd_layout
    .leftEqualToView(headerView)
    .bottomEqualToView(holdView).offset(-8)
    .widthIs(ScreenWidth)
    .heightIs(20);
    
    moneyTextlabel.sd_layout
    .leftEqualToView(holdView)
    .topEqualToView(holdView).offset(15)
    .widthRatioToView(holdView,1)
    .heightIs(20);
}

- (NextAndLastDateView *)topView
{
    if (_topView == nil){
        _topView = [[NextAndLastDateView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 35)];
        _topView.delegate = self;
        [_topView.nextBtn setTitle:@"下一月" forState:UIControlStateNormal];
        [_topView.lastBtn setTitle:@"上一月" forState:UIControlStateNormal];
    }
    return _topView;
}

//获取本月年月
- (void)nowYearAndMonth{
    monthNum = 0;
    NSString *dateString = [HuaCuiTangHelper getPriousorLaterDateFromNowWithMonth:monthNum];
    self.topView.dataLabel.text = dateString;
    
    mYear = [dateString substringToIndex:4];
    mMonth = [dateString substringWithRange:NSMakeRange(5, 2)];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RechargeTableViewCell *cell = [RechargeTableViewCell cellWithTableView:self.tableView];
    
    cell.iconImageView.image = [UIImage imageNamed:imageArray[indexPath.row]];
    cell.nameLabel.text = nameArray[indexPath.row];
    
    if (self.viewType == RechargeVCTypeRecharge){
       cell.rightLabel.text = [NSString stringWithFormat:@"%@",[self.responseDic objectForKey:[NSString stringWithFormat:@"goods%i_in_sum",(int)indexPath.row]]];
    }else {
        cell.rightLabel.text = [NSString stringWithFormat:@"%@",[self.responseDic objectForKey:[NSString stringWithFormat:@"goods%i_out_sum",(int)indexPath.row]]];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (void)requestData{
    
    [LCProgressHUD showLoading:@"正在加载..."];
    
    NSMutableDictionary *requestParams = [[NSMutableDictionary alloc] init];
    [requestParams setValue:[ModelMember sharedMemberMySelf].memberId forKey:@"employeeId"];
    [requestParams setValue:(self.viewType == RechargeVCTypeRecharge) ? @(1) :@(2) forKey:@"modelType"]; //1-充值业绩 2-消费业绩
    
    [requestParams setValue:mYear forKey:@"perf_year"]; //年
    [requestParams setValue:mMonth forKey:@"perf_month"];//月
    
    [HCTConnet getHomeEmployPerformance:requestParams success:^(id responseObject) {
        
        self.responseDic = responseObject;
        
        if (self.viewType == RechargeVCTypeRecharge){
            moneyTextlabel.text = [NSString stringWithFormat:@"%.2f",[[self.responseDic objectForKey:@"money_in_sum"] doubleValue]];
        }else {
            moneyTextlabel.text = [NSString stringWithFormat:@"%.2f",[[self.responseDic objectForKey:@"money_out_sum"] doubleValue]];
        }
        
        [self.tableView reloadData];
        
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}

#pragma mark - Action

- (void)lastMonthBtnAction{
    
}
- (void)nextMonthBtnAction{
   
}
#pragma mark NextAndLastDateViewDelegate 上一月下一月
- (void)nextAndLastDateBtnClickWithTag:(NextAndLastDateViewButtonType)tag
{
 
    switch (tag) {
        case NextAndLastDateViewButtonTypeLast:
        {
            monthNum--;
        }
            break;
        case NextAndLastDateViewButtonTypeNext:
        {
            monthNum++;
        }
            break;
    }

    NSString *dateString = [HuaCuiTangHelper getPriousorLaterDateFromNowWithMonth:monthNum];
    self.topView.dataLabel.text = dateString;
    
    mYear = [dateString substringToIndex:4];
    mMonth = [dateString substringWithRange:NSMakeRange(5, 2)];
    
    [self requestData];
}

@end
