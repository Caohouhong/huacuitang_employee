//
//  MonthDetailVC.m
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/28.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "MonthDetailVC.h"
#import "ChhYuYueTableViewCell.h"
#import "CheckDetailTableViewCell.h"
#import "HuaCuiTangHelper.h"
#import "NextAndLastDateView.h"
#import "TopSelectViewTwoBtnView.h"
#import "BackFourTableViewCell.h"
#import "AdviceTableViewCell.h"
#import "TopSelectView.h"
#import "HCTConnet.h"

@interface MonthDetailVC ()<UITableViewDelegate, UITableViewDataSource,NextAndLastDateViewDelegate,TopSelectViewDelegate>
{
    int dayNum;
    NSString *mBookTime;
    NSArray *BeginArray;
    NSArray *auditArray;
    NSArray *endArray;
    NSString *type;
    
    NSArray *basicInformationArr;
    NSArray *mianInformation;
    NSArray *indexInformation;
    
}
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NextAndLastDateView *topView;
@property (nonatomic, strong) TopSelectView *topSelectView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *totalArray;

@end

@implementation MonthDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    type = @"1";
    self.navigationItem.title = @"月度规划";
    self.view.backgroundColor = COLOR_BackgroundColor;
    BeginArray = @[@[@"客户姓名",@"总结时间",@"客户类别",@"客户状态"],@[@"本月总体计划",@"本月需解决病症",@"本月计划项目",@"本月计划金额"]];
    auditArray = @[@[@"业务经理意见"],@[@"营运经理意见"]];
    endArray = @[@[@"本月总体计划",@"本月需解决病症"],@[@"本月计划项目",@"本月完成项目"],@[@"本月计划金额",@"本月完成金额"],@[@"月底总结"],@[@"总结结果"]];
    
    self.dataArray = [[NSMutableArray alloc] initWithArray:BeginArray];
    self.viewType = MonthDetailViewTypeBegin;
    [self drawView];
    [self requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)drawView{
    
    [self initHeaderView];
    
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
    .topSpaceToView(self.view,80)
    .bottomSpaceToView(self.view,0);
}

- (void)initHeaderView
{
    _topView = [[NextAndLastDateView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 35)];
    _topView.delegate = self;
    [_topView.nextBtn setTitle:@"下一条" forState:UIControlStateNormal];
    [_topView.lastBtn setTitle:@"上一条" forState:UIControlStateNormal];
    [self.view addSubview:self.topView];
    
    [self nowDateDay];
    
    UIView *dividerLine1 = [[UIView alloc] init];
    dividerLine1.backgroundColor = COLOR_LineViewColor;
    [self.view addSubview:dividerLine1];
    
    _topSelectView = [[TopSelectView alloc] initWithFrame:CGRectMake(0, 45, ScreenWidth, 35)];
    [_topSelectView.leftButton setTitle:@"基础信息" forState:UIControlStateNormal];
    [self.topSelectView.leftButton setTitleColor:COLOR_Text_Blue forState:UIControlStateNormal];
    [_topSelectView.centerButton setTitle:@"主要信息" forState:UIControlStateNormal];
    [_topSelectView.rightButton setTitle:@"指标信息" forState:UIControlStateNormal];
    _topSelectView.markView.hidden = YES;
    _topSelectView.delegate = self;
    [self.view addSubview:self.topSelectView];
    
    dividerLine1.sd_layout
    .leftSpaceToView(self.view,0)
    .topEqualToView(_topSelectView)
    .widthIs(ScreenWidth)
    .heightIs(1);
}

//获取本月年月日
- (void)nowDateDay{
    dayNum = 0;
    NSString *dateString = [HuaCuiTangHelper getPriousorLaterDateFromNowWithDay:dayNum];
    self.topView.dataLabel.text = dateString;
    
    mBookTime = [self changeDateStringStyleWith:dateString];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = self.dataArray[section];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.viewType == MonthDetailViewTypeBegin){

        ChhYuYueTableViewCell *cell = [ChhYuYueTableViewCell cellWithTableView:self.tableView];
        
        cell.leftLabel.attributedText = [HuaCuiTangHelper changeTextColorWithRestltStr:[NSString stringWithFormat:@"%@:  %@",self.dataArray[indexPath.section][indexPath.row],self.totalArray[indexPath.section][indexPath.row]] changeText:self.totalArray[indexPath.section][indexPath.row] andColor:COLOR_Gray];
        
        return cell;
        
    }else if (self.viewType == MonthDetailViewTypeAudit){
        AdviceTableViewCell *cell = [AdviceTableViewCell cellWithTableView:self.tableView];
        
        cell.titleLabel.text = self.dataArray[indexPath.section][indexPath.row];
        cell.topTextView.text = self.totalArray[indexPath.section][indexPath.row];
//        if (indexPath.section == 0) {
//
//            cell.topTextView.text = [self judgeString:self.model.service_manage_view];
//            cell.nameLabel.text = @"";
//            cell.titleLabel.text = @"";
//        }
//        if (indexPath.section == 1) {
//            cell.titleLabel.text = @"运营经理意见";
//            cell.topTextView.text = [self judgeString:self.model.administrative_view];
//            cell.nameLabel.text = [self judgeString:self.model.administrative_id];
//            cell.titleLabel.text = [self judgeString:self.model.administrative_date];
//        }
        
        
        
        return cell;
    }else {
        
        if (indexPath.section == 3)
        {
            AdviceTableViewCell *cell = [AdviceTableViewCell cellWithTableView:self.tableView];
            
            cell.titleLabel.text = self.dataArray[indexPath.section][indexPath.row];
            cell.nameLabel.text = @"";
            cell.timeLabel.text = @"";
            
            cell.topTextView.sd_layout
            .heightIs(90);

            return cell;
            
        }else {
            ChhYuYueTableViewCell *cell = [ChhYuYueTableViewCell cellWithTableView:self.tableView];
            
            cell.leftLabel.attributedText = [HuaCuiTangHelper changeTextColorWithRestltStr:[NSString stringWithFormat:@"%@:  %@",self.dataArray[indexPath.section][indexPath.row],self.totalArray[indexPath.section][indexPath.row]] changeText:self.totalArray[indexPath.section][indexPath.row] andColor:COLOR_Gray];
            
            return cell;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.viewType == MonthDetailViewTypeBegin)
    {
        return 40;
    }else if ((self.viewType == MonthDetailViewTypeAudit)){
        return 130;
    }else {
        if (indexPath.section == 3) {
            return 130;
        }else {
            return 40;
        }
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

#pragma mark NextAndLastDateViewDelegate 上一天下一天
- (void)nextAndLastDateBtnClickWithTag:(NextAndLastDateViewButtonType)tag
{
    switch (tag) {
        case NextAndLastDateViewButtonTypeLast:
        {
            dayNum--;
            type = @"1";
        }
            break;
        case NextAndLastDateViewButtonTypeNext:
        {
            dayNum++;
            type = @"0";
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

#pragma mark - TopSelectViewDelegate 顶部按钮代理
- (void)topButtonClickWithTag:(TopSelectViewType)tag
{
    [self.dataArray removeAllObjects];
    [self.totalArray removeAllObjects];
    [self.topSelectView.leftButton setTitleColor:COLOR_darkGray forState:UIControlStateNormal];
    [self.topSelectView.rightButton setTitleColor:COLOR_darkGray forState:UIControlStateNormal];
    [self.topSelectView.centerButton setTitleColor:COLOR_darkGray forState:UIControlStateNormal];
    
    switch (tag) {
        case TopSelectViewTypeLeft:
            [self.topSelectView.leftButton setTitleColor:COLOR_Text_Blue forState:UIControlStateNormal];
            [self.dataArray addObjectsFromArray:BeginArray];
            [self.totalArray addObjectsFromArray:basicInformationArr];
            self.viewType = MonthDetailViewTypeBegin;
            break;
        case TopSelectViewTypeCenter:
            [self.topSelectView.centerButton setTitleColor:COLOR_Text_Blue forState:UIControlStateNormal];
            [self.dataArray addObjectsFromArray:auditArray];
            [self.totalArray addObjectsFromArray:mianInformation];
            self.viewType = MonthDetailViewTypeAudit;
            break;
        case TopSelectViewTypeRight:
            [self.topSelectView.rightButton setTitleColor:COLOR_Text_Blue forState:UIControlStateNormal];
            [self.dataArray addObjectsFromArray:endArray];
            [self.totalArray addObjectsFromArray:indexInformation];
            self.viewType = MonthDetailViewTypeEnd;
            break;
        default:
            break;
    }
    
    [self.tableView reloadData];
}
#pragma mark - ====网络====
- (void)requestData
{
    [LCProgressHUD showLoading:@"正在加载..."];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:self.YongHuId forKey:@"c_id"];
    [params setValue:type forKey:@"type"];
    [params setValue:mBookTime forKey:@"dataTime"];
    [HCTConnet getMonthDetailVC:params success:^(id responseObject) {
      
        self.model  = [MonthDetailModel mj_objectWithKeyValues:responseObject];
        basicInformationArr = @[@[[self judgeString:self.model.customerName],[self judgeString:self.model.summary_date],[self judgeString:self.model.customer_dic_libie_id],[self judgeString:self.model.customer_dic_status_id]],@[[self judgeString:self.model.nmpp],[self judgeString:self.model.nmss],[self judgeString:self.model.nmpp],[self judgeString:self.model.nmpm]]];
        
        
        DLog(@"()()()()()()%@",basicInformationArr);
        
        mianInformation = @[@[[self judgeString:self.model.service_manage_view]],@[[self judgeString:self.model.administrative_date]]];
        if ([self.model.result isEqualToString:@"0"]) {
            self.model.result = @"已总结";
        }else{
             self.model.result = @"未总结";
        }
        indexInformation = @[@[@"",[self judgeString:self.model.nmss]],@[[self judgeString:self.model.nmpp],[self judgeString:self.model.cmpp]],@[[self judgeString:self.model.nmpm],[self judgeString:self.model.cmpm]],@[@""],@[[self judgeString:self.model.result]]];
        self.totalArray = [[NSMutableArray alloc] initWithArray:basicInformationArr];

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
