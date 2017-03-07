//
//  SelfDailySummaryVC.m
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/27.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "SelfDailySummaryVC.h"
#import "HuaCuiTangHelper.h"
#import "NextAndLastDateView.h"
#import "RechargeTableViewCell.h"
#import "DailySumWriteCell.h"
#import "DailyWorkTableViewCell.h"
#import "HCTConnet.h"
#import "DailyDetailModel.h"
#import "HuaCuiTangHelper.h"

@interface SelfDailySummaryVC ()<UITableViewDataSource, UITableViewDelegate, NextAndLastDateViewDelegate>
{
    int dayNum;
    NSString *mBookTime;
    UILabel *addressLabel;
    UILabel *nameLabel;
    UILabel *carreLabel;
    NSArray *titleArray1;
    NSArray *titleArray2;
    NSArray *headerImgArray;
    NSArray *headerTitleArray;
    UIButton *commitButton;
    NSString *flag;
    
}
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NextAndLastDateView *topView;
@property (nonatomic, strong)NSMutableArray *dataArray;//数据
@property (nonatomic, strong)NSMutableArray<NSNumber *> *isExpland;//是否展开
@property (nonatomic, strong)DailyDetailModel *model;
@property (nonatomic, strong)NSMutableArray *doneArray;
@property (nonatomic, strong)NSMutableArray *undoneArray;
@property (nonatomic, strong)NSString *writeStr;
@end

@implementation SelfDailySummaryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"今日总结";
    self.view.backgroundColor = COLOR_BackgroundColor;
    
    if (!self.doneArray){
        self.doneArray = [NSMutableArray arrayWithObjects:@"0",@"0",@"0", nil];
    }
    
    if (!self.undoneArray){
        self.undoneArray = [NSMutableArray arrayWithObjects:@"0",@"0",@"0", nil];
    }
    
    headerImgArray = @[@"h_sum_work_20x20",@"h_sum_done_20x20",@"h_sum_undone_20x20",@"h_sum_write_20x20"];
    headerTitleArray = @[@"工作业绩",@"已完成工作",@"未完成工作",@"今日总结"];
    titleArray1 = @[@"服务人次",@"充值业绩",@"铺垫目标",@"消费业绩"];
    titleArray2 = @[@"调理备忘",@"回访顾客",@"预约提醒"];
    
    if (!self.dataArray) {
        self.dataArray = [NSMutableArray array];
    }
    if (!self.isExpland) {
        self.isExpland = [NSMutableArray array];
    }
    
    //这里用一个二维数组来模拟数据。
    self.dataArray = [NSArray arrayWithObjects:titleArray1,titleArray2,titleArray2,@[@""],nil].mutableCopy;
    
    //用0代表收起，非0（不一定是1）代表展开，默认都是收起的
    for (int i = 0; i < self.dataArray.count; i++) {
        [self.isExpland addObject:@1];
    }
    
    [self drawView];
    
    [self requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (void)initTopView
{
    _topView = [[NextAndLastDateView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 35)];
    _topView.delegate = self;
    [_topView.nextBtn setTitle:@"下一天" forState:UIControlStateNormal];
    [_topView.lastBtn setTitle:@"上一天" forState:UIControlStateNormal];
    [self.view addSubview:self.topView];

    UIView *holdView = [[UIView alloc] initWithFrame:CGRectMake(0, 35, ScreenWidth, 30)];
    holdView.backgroundColor = COLOR_BackgroundColor;
    [self.view addSubview:holdView];
    
    addressLabel = [[UILabel alloc] init];
    addressLabel.text = [ModelMember sharedMemberMySelf].shopName;
    addressLabel.font = SYSTEM_FONT_(15);
    addressLabel.textColor = COLOR_Black;
    [holdView addSubview:addressLabel];
    
    nameLabel = [[UILabel alloc] init];
    nameLabel.text = self.userName;
    nameLabel.font = SYSTEM_FONT_(15);
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.textColor = COLOR_Black;
    [holdView addSubview:nameLabel];
    
    carreLabel = [[UILabel alloc] init];
    carreLabel.text = @"调理师";
    carreLabel.font = SYSTEM_FONT_(15);
    carreLabel.textAlignment = NSTextAlignmentRight;
    carreLabel.textColor = COLOR_Black;
    [holdView addSubview:carreLabel];
    
    addressLabel.sd_layout
    .leftSpaceToView(holdView,15)
    .topEqualToView(holdView)
    .widthRatioToView(holdView,0.3)
    .heightRatioToView(holdView,1);
    
    nameLabel.sd_layout
    .centerXEqualToView(holdView)
    .topEqualToView(holdView)
    .widthRatioToView(addressLabel,1)
    .heightRatioToView(holdView,1);
    
    carreLabel.sd_layout
    .rightEqualToView(holdView).offset(-15)
    .topEqualToView(holdView)
    .widthRatioToView(addressLabel,1)
    .heightRatioToView(holdView,1);
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = COLOR_BackgroundColor;
    [self.view addSubview:bottomView];
    
    commitButton = [[UIButton alloc] init];
    [commitButton setTitle:@"提交" forState:UIControlStateNormal];
    [commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    commitButton.titleLabel.font = SYSTEM_FONT_(15);
    commitButton.backgroundColor = COLOR_Text_Blue;
    commitButton.layer.cornerRadius = 4.0;
    [commitButton addTarget:self action:@selector(markButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:commitButton];
    
    bottomView.sd_layout
    .leftEqualToView(self.view)
    .bottomEqualToView(self.view)
    .widthRatioToView(self.view,1)
    .heightIs(60);
    
    commitButton.sd_layout
    .leftSpaceToView(bottomView,15)
    .rightSpaceToView(bottomView,15)
    .bottomSpaceToView(bottomView,10)
    .topSpaceToView(bottomView,10);
    
    [self checkButtonStatus];
}

//检测按钮
- (void)checkButtonStatus{
    
    if (self.isCheck){
        commitButton.backgroundColor = COLOR_Gray;
        [commitButton setUserInteractionEnabled:NO];
    }else{
        commitButton.backgroundColor = COLOR_Text_Blue;
        [commitButton setUserInteractionEnabled:YES];
    }
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
    [self initTopView];
    [self nowDateDay];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
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
    .topSpaceToView(self.view,65)
    .bottomSpaceToView(self.view,60);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSArray *array = self.dataArray[section];
    if ([self.isExpland[section] boolValue]) {
        return array.count;
    }
    else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0){
        DailyWorkTableViewCell *cell = [DailyWorkTableViewCell cellWithTableView:self.tableView];
        cell.leftLabel.text = titleArray1[indexPath.row];
        cell.centerLabel.text = @"今日：10次";
        cell.rightLabel.text = @"截止：0次";
        switch (indexPath.row) {
            case 0:
            {
                NSString *str1 = [NSString stringWithFormat:@"今日：%@次",self.model.service_sum?self.model.service_sum:@"0"];
                NSString *str2 = [NSString stringWithFormat:@"截止：%@次",self.model.service_sum_end?self.model.service_sum_end:@"0"];
                cell.centerLabel.attributedText = [HuaCuiTangHelper changeTextColorWithRestltStr:str1 changeText:self.model.service_sum andColor:COLOR_LightGray];
                
                cell.rightLabel.attributedText =[HuaCuiTangHelper changeTextColorWithRestltStr:str2 changeText:self.model.service_sum_end andColor:COLOR_LightGray];;
            }
                break;
            case 1:
            {
                NSString *str1 = [NSString stringWithFormat:@"今日：%@元",self.model.money_in_sum?self.model.money_in_sum:@"0"];
                NSString *str2 = [NSString stringWithFormat:@"截止：%@元",self.model.money_in_sum_end?self.model.money_in_sum_end:@"0"];
                cell.centerLabel.attributedText = [HuaCuiTangHelper changeTextColorWithRestltStr:str1 changeText:self.model.money_in_sum andColor:COLOR_LightGray];
                
                cell.rightLabel.attributedText =[HuaCuiTangHelper changeTextColorWithRestltStr:str2 changeText:self.model.money_in_sum_end andColor:COLOR_LightGray];;
            }
                break;
            case 2:
            {
                NSString *str1 = [NSString stringWithFormat:@"今日：%@次",self.model.basetarget_sum?self.model.basetarget_sum:@"0"];
                NSString *str2 = [NSString stringWithFormat:@"截止：%@次",self.model.basetarget_sum_end?self.model.basetarget_sum_end:@"0"];
                cell.centerLabel.attributedText = [HuaCuiTangHelper changeTextColorWithRestltStr:str1 changeText:self.model.basetarget_sum andColor:COLOR_LightGray];
                
                cell.rightLabel.attributedText =[HuaCuiTangHelper changeTextColorWithRestltStr:str2 changeText:self.model.basetarget_sum_end andColor:COLOR_LightGray];;
            }

                break;
            case 3:
            {
                NSString *str1 = [NSString stringWithFormat:@"今日：%@元",self.model.money_out_sum?self.model.money_out_sum:@"0"];
                NSString *str2 = [NSString stringWithFormat:@"截止：%@元",self.model.money_out_sum_end?self.model.money_out_sum_end:@"0"];
                cell.centerLabel.attributedText = [HuaCuiTangHelper changeTextColorWithRestltStr:str1 changeText:self.model.money_out_sum andColor:COLOR_LightGray];
                
                cell.rightLabel.attributedText =[HuaCuiTangHelper changeTextColorWithRestltStr:str2 changeText:self.model.money_out_sum_end andColor:COLOR_LightGray];;
            }

                break;
            default:
                break;
        }

        return cell;
        
    }else if (indexPath.section == 1 || indexPath.section == 2){
        RechargeTableViewCell *cell = [RechargeTableViewCell cellWithTableView:self.tableView];
        cell.leftLabel.text = titleArray2[indexPath.row];
        
        if (indexPath.section == 1){
            NSString *str1 = [NSString stringWithFormat:@"累计%@次",self.doneArray[indexPath.row]];
           cell.rightLabel.attributedText =[HuaCuiTangHelper changeTextColorWithRestltStr:str1 changeText:self.doneArray[indexPath.row] andColor:COLOR_TEXT_ORANGE_RED];
        }else {
            NSString *str1 = [NSString stringWithFormat:@"累计%@次",self.undoneArray[indexPath.row]];
            cell.rightLabel.attributedText =[HuaCuiTangHelper changeTextColorWithRestltStr:str1 changeText:self.undoneArray[indexPath.row] andColor:COLOR_TEXT_ORANGE_RED];
        }
        
        return cell;
    }else if (indexPath.section == 3){
        DailySumWriteCell *writeCell = [DailySumWriteCell cellWithTableView:self.tableView];
        
        writeCell.topTextView.text = self.conent;
        //是否可以编辑
        if (self.type == 1){ //自己可编辑
            writeCell.topTextView.editable = YES;
        }else {
            writeCell.topTextView.editable = NO;
        }
        
        __weak typeof(self) weakSelf = self;
        writeCell.block = ^(NSString *text){
            weakSelf.conent = text;
        };
        return writeCell;
    }
    return [[UITableViewCell alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 3){
        return 75;
    }else {
        return 40;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
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
    
    UIImageView *leftImageView = [[UIImageView alloc] init];
    leftImageView.image = [UIImage imageNamed:headerImgArray[section]];
    [headerView addSubview:leftImageView];
    
    UILabel *textlabel = [[UILabel alloc] init];
    textlabel.font = SYSTEM_FONT_BOLD_(15);
    textlabel.textColor = COLOR_Text_Blue;
    textlabel.text = headerTitleArray[section];
    [headerView addSubview:textlabel];
    
    UIImageView *arrowImageView = [[UIImageView alloc] init];
    arrowImageView.tag = 600+section;
    UIImage *img = [UIImage imageNamed:@"h_sum_arrow_blue_15x9"];
    [headerView addSubview:arrowImageView];
    
    if (![self.isExpland[section] boolValue]){
        img = [UIImage imageWithCGImage:img.CGImage scale:1 orientation:UIImageOrientationDown];
    }
    arrowImageView.image = img;
    
    UIButton *headerBtn = [[UIButton alloc] init];
    headerBtn.tag = 666+section;
    [headerBtn addTarget:self action:@selector(headerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:headerBtn];
    
    dividerLine1.sd_layout
    .leftEqualToView(headerView)
    .bottomEqualToView(headerView)
    .widthRatioToView(headerView,1)
    .heightIs(1);
    
    leftImageView.sd_layout
    .leftSpaceToView(headerView,15)
    .centerYEqualToView(headerView)
    .widthIs(20)
    .heightIs(20);
    
    textlabel.sd_layout
    .leftSpaceToView(leftImageView,5)
    .topEqualToView(headerView)
    .widthRatioToView(headerView,0.5)
    .heightRatioToView(headerView,1);
    
    arrowImageView.sd_layout
    .rightEqualToView(headerView).offset(-15)
    .centerYEqualToView(headerView)
    .widthIs(15)
    .heightIs(9);
    
    headerBtn.sd_layout
    .leftEqualToView(headerView)
    .topSpaceToView(headerView,0)
    .widthRatioToView(headerView,1)
    .heightRatioToView(headerView,1);
    
    return headerView;
}

#pragma mark - =======网络=========
- (void)requestData{
    
    [LCProgressHUD showLoading:@"正在加载..."];
    
    NSMutableDictionary *requestParams = [[NSMutableDictionary alloc] init];
    [requestParams setValue:self.employeeId forKey:@"employeeId"];
    [requestParams setValue:mBookTime forKey:@"datetime"];
    [requestParams setValue:@(self.type) forKey:@"type"]; //0 - 别人  1 － 自己
    
    [HCTConnet getHomeAddMyWorkSum:requestParams success:^(id responseObject) {
        
        self.model = [DailyDetailModel mj_objectWithKeyValues:responseObject];
        
        //flag 为1 ，已填写，是查看   0 - 填写
        self.isCheck = [self.model.flag isEqualToString:@"1"];
        
        self.conent = self.model.contenet?self.model.contenet:@"";
    
        
        flag = self.model.flag;
        self.workSummaryId = self.model.sid;
        
        [self.undoneArray removeAllObjects];
        [self.doneArray removeAllObjects];
        
        NSArray *array = [[NSArray alloc] initWithObjects:self.model.track_sum,self.model.visit_sum,self.model.booking_sum, nil];
       
        
        NSArray *unArray = [[NSArray alloc] initWithObjects:self.model.track_sum_unfinish,self.model.visit_sum_unfinish,self.model.booking_sum_unfinish, nil];
        
        [self.doneArray addObjectsFromArray:array];
        [self.undoneArray addObjectsFromArray:unArray];
        
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
- (void)headerButtonAction:(UIButton *)button
{
    UIImageView *imageView = (UIImageView *)[self.view viewWithTag:600+button.tag - 666];
    imageView.transform = CGAffineTransformMakeRotation(M_PI);
    
    NSInteger section = button.tag - 666;
    self.isExpland[section] = [self.isExpland[section] isEqual:@0]?@1:@0;
    NSIndexSet *set = [NSIndexSet indexSetWithIndex:section];
    [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
}

//提交按钮
- (void)markButtonAction{
    
    [LCProgressHUD showLoading:@"正在提交..."];
    
    NSString *currentData = [HuaCuiTangHelper getCurrentDateWithStyleStr:@"yyyy-MM-dd"];
    //是当天时间
    if (![currentData isEqualToString:mBookTime]){
        [LCProgressHUD showInfoMsg:@"只能提交今日总结"];
        return;
    }
    
    NSMutableDictionary *requestParams = [[NSMutableDictionary alloc] init];
    [requestParams setValue:self.conent forKey:@"contenet"];
    [requestParams setValue:mBookTime forKey:@"datetime"];
    [requestParams setValue:self.employeeId forKey:@"employeeId"];
    
    [requestParams setValue:self.workSummaryId forKey:@"workSummaryId"];
    [requestParams setValue:flag forKey:@"flag"];
    
    [HCTConnet getHomeAddWorkSum:requestParams success:^(id responseObject) {
        
        [LCProgressHUD showSuccess:@"提交成功"];
        [self.navigationController popViewControllerAnimated:YES];
        
    } successBackfailError:^(id responseObject) {
        
        [LCProgressHUD showFailure:@"提交失败"];
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}
@end
