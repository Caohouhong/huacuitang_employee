//
//  TomorrowPlanVC.m
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/27.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "TomorrowPlanVC.h"
#import "NextAndLastDateView.h"
#import "HuaCuiTangHelper.h"
#import "TomorrowPlanTableViewCell.h"
#import "ChangePlanVC.h"
#import "HCTConnet.h"
#import "TomPlanListModel.h"
#import "AddPlanVC.h"


@interface TomorrowPlanVC ()<UITableViewDataSource, UITableViewDelegate, NextAndLastDateViewDelegate>
{
    int dayNum;
    NSString *mBookTime;
    
    
}
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NextAndLastDateView *topView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIView *textHoldView;
@end

@implementation TomorrowPlanVC

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    
    return _dataArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"明日计划";
    self.view.backgroundColor = COLOR_BackgroundColor;
    
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


- (void)drawView
{
    _topView = [[NextAndLastDateView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 35)];
    _topView.delegate = self;
    [_topView.nextBtn setTitle:@"下一天" forState:UIControlStateNormal];
    [_topView.lastBtn setTitle:@"上一天" forState:UIControlStateNormal];
    [self.view addSubview:self.topView];
    
    [self nowDateDay];
    
//    UIView *bottomView = [[UIView alloc] init];
//    bottomView.backgroundColor = COLOR_BackgroundColor;
//    [self.view addSubview:bottomView];
//    
//    UIButton *markButton = [[UIButton alloc] init];
//    [markButton setTitle:@"提交" forState:UIControlStateNormal];
//    [markButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    markButton.titleLabel.font = SYSTEM_FONT_(15);
//    markButton.backgroundColor = COLOR_Text_Blue;
//    markButton.layer.cornerRadius = 4.0;
//    [markButton addTarget:self action:@selector(markButtonAction) forControlEvents:UIControlEventTouchUpInside];
//    [bottomView addSubview:markButton];
//    
//    bottomView.sd_layout
//    .leftEqualToView(self.view)
//    .bottomEqualToView(self.view)
//    .widthRatioToView(self.view,1)
//    .heightIs(60);
    
//    markButton.sd_layout
//    .leftSpaceToView(bottomView,15)
//    .rightSpaceToView(bottomView,15)
//    .bottomSpaceToView(bottomView,10)
//    .topSpaceToView(bottomView,10);
    
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    headerView.backgroundColor = COLOR_BackgroundColor;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = COLOR_BackgroundColor;
    tableView.tableHeaderView = headerView;
    tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    tableView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,35)
    .bottomSpaceToView(self.view,0);
}

//获取本月年月日
- (void)nowDateDay{
    dayNum = 1;
    NSString *dateString = [HuaCuiTangHelper getPriousorLaterDateFromNowWithDay:dayNum];
    self.topView.dataLabel.text = dateString;
    
    mBookTime = [self changeDateStringStyleWith:dateString];
}

#pragma mark - =====UITableViewDataSource, UITableViewDelegate====
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
    TomorrowPlanTableViewCell *cell = [TomorrowPlanTableViewCell cellWithTableView:self.tableView];
    
    cell.model = self.dataArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TomPlanListModel *model = self.dataArray[indexPath.row];
    
    ChangePlanVC *changeVC = [[ChangePlanVC alloc] init];
    changeVC.model = model;
    changeVC.timeStr = self.topView.dataLabel.text;
    changeVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:changeVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    return 40;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
     //大于3条不显示建议
    if (self.dataArray.count > 3){
        self.textHoldView.hidden = YES;
        return 40;
    }else {
        self.textHoldView.hidden = NO;
        return 70;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 70)];
    footerView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *addImageView = [[UIImageView alloc] init];
    addImageView.image = [UIImage imageNamed:@"h_add_20x20"];
    [footerView addSubview:addImageView];
    
    UIButton *nextMonthBtn = [[UIButton alloc] init];
    [nextMonthBtn addTarget:self action:@selector(footerBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:nextMonthBtn];
    
    self.textHoldView = [[UIView alloc] init];
    self.textHoldView.backgroundColor = COLOR_BG_DARK_BLUE;
    [footerView addSubview:self.textHoldView];
    
    UILabel *textlabel = [[UILabel alloc] init];
    textlabel.font = SYSTEM_FONT_BOLD_(15);
    textlabel.textColor = COLOR_TEXT_DARK_BLUE;
    textlabel.text = @"提醒：预约人数较少，建议积极回访多预约";
    [self.textHoldView addSubview:textlabel];
    
    UIView *dividerLine2 = [[UIView alloc] init];
    dividerLine2.backgroundColor = backviewColor;
    [footerView addSubview:dividerLine2];
    
    addImageView.sd_layout
    .rightSpaceToView(footerView,20)
    .topSpaceToView(footerView,10)
    .widthIs(20)
    .heightIs(20);
    
    nextMonthBtn.sd_layout
    .leftEqualToView(footerView)
    .topSpaceToView(footerView,0)
    .widthIs(ScreenWidth)
    .heightIs(40);
    
    self.textHoldView.sd_layout
    .leftEqualToView(footerView)
    .topSpaceToView(footerView,40)
    .widthIs(ScreenWidth)
    .heightIs(30);
    
    textlabel.sd_layout
    .leftEqualToView(self.textHoldView).offset(15)
    .topEqualToView(self.textHoldView)
    .widthIs(ScreenWidth - 30)
    .heightIs(30);
    
    dividerLine2.sd_layout
    .leftEqualToView(footerView)
    .bottomEqualToView(footerView)
    .widthIs(ScreenWidth)
    .heightIs(1);
    
    
    return footerView;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UIView *dividerLine1 = [[UIView alloc] init];
    dividerLine1.backgroundColor = backviewColor;
    [headerView addSubview:dividerLine1];
    
    UILabel *textlabel1 = [self labelWithStr:@"目标"];
    UILabel *textlabel2 = [self labelWithStr:@"姓名"];
    UILabel *textlabel3 = [self labelWithStr:@"金额"];
    UILabel *textlabel4 = [self labelWithStr:@"项目/切入点"];
    [headerView addSubview:textlabel1];
    [headerView sd_addSubviews:@[textlabel1,textlabel2,textlabel3,textlabel4]];
    
    dividerLine1.sd_layout
    .leftEqualToView(headerView)
    .bottomEqualToView(headerView)
    .widthRatioToView(headerView,1)
    .heightIs(1);
    
    textlabel1.sd_layout
    .leftSpaceToView(headerView,0)
    .topEqualToView(headerView)
    .widthIs(ScreenWidth/4)
    .heightRatioToView(headerView,1);
    
    textlabel2.sd_layout
    .leftSpaceToView(textlabel1,0)
    .topEqualToView(headerView)
    .widthIs(ScreenWidth/4)
    .heightRatioToView(headerView,1);
    
    textlabel3.sd_layout
    .leftSpaceToView(textlabel2,0)
    .topEqualToView(headerView)
    .widthIs(ScreenWidth/4)
    .heightRatioToView(headerView,1);
    
    textlabel4.sd_layout
    .leftSpaceToView(textlabel3,0)
    .topEqualToView(headerView)
    .widthIs(ScreenWidth/4)
    .heightRatioToView(headerView,1);
    
    return headerView;
}

- (UILabel *)labelWithStr:(NSString *)str{
    
    UILabel *textlabel = [[UILabel alloc] init];
    textlabel.font = SYSTEM_FONT_BOLD_(15);
    textlabel.textColor = COLOR_Text_Blue;
    textlabel.textAlignment = NSTextAlignmentCenter;
    textlabel.text = str;
    return textlabel;
}

#pragma mark ============= 网络 =================
- (void)requestData
{
    [LCProgressHUD showLoading:@"正在加载..."];

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:[ModelMember sharedMemberMySelf].memberId forKey:@"employeeId"];
    [params setValue:mBookTime forKey:@"datetime"];
    
    [HCTConnet getHomeListDailyWorkByTime:params success:^(id responseObject) {
        NSArray *array =  [TomPlanListModel mj_objectArrayWithKeyValuesArray:responseObject];
        
        [self.dataArray removeAllObjects];
        [self.dataArray addObjectsFromArray:array];
        
        [self.tableView reloadData];
        
    } successBackfailError:^(id responseObject) {

        
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
       
    }];
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

#pragma mark - Action

////标记按钮
//- (void)markButtonAction{
//    
//}

//添加
- (void)footerBtnAction
{
    AddPlanVC *addVC = [[AddPlanVC alloc] init];
    addVC.timeStr = self.topView.dataLabel.text;
    addVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:addVC animated:YES];
}


@end
