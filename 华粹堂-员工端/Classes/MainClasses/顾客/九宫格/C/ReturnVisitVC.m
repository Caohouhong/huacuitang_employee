//
//  ReturnVisitVC.m
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/28.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "ReturnVisitVC.h"
#import "NextAndLastDateView.h"
#import "HuaCuiTangHelper.h"
#import "ChhYuYueTableViewCell.h"
#import "AdviceTableViewCell.h"
#import "HCTConnet.h"

@interface ReturnVisitVC ()<NextAndLastDateViewDelegate,UITableViewDelegate, UITableViewDataSource>
{
    int dayNum;
    NSString *mBookTime;
    NSArray *titleArray;
    NSArray *adviceArray;
    NSString *flag;
    UITextView *textlabel;
    NSArray *dataArray;
    NSArray *fankuiarr;
    NSArray *beizhuarr;
    NSArray *yijianarr;

}
@property (nonatomic, strong) NextAndLastDateView *topView;
@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, copy) NSString *fankui;
@property (nonatomic, copy) NSString *beizhu;
@property (nonatomic, copy) NSString *yijian;
@property (nonatomic, copy) NSString *zhuanjia;

@end

@implementation ReturnVisitVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"回访记录";
    self.yijian = @"无";
    self.zhuanjia = @"无";
    self.beizhu = @"无";
    self.fankui = @"无";

    titleArray = @[@[@"回访人",@"回访时间",@"客户姓名"]];
    flag = @"0";
    self.view.backgroundColor = COLOR_BackgroundColor;
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
    .topSpaceToView(self.view,35)
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
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0){
         ChhYuYueTableViewCell *cell = [ChhYuYueTableViewCell cellWithTableView:self.tableView];
         cell.leftLabel.attributedText = [HuaCuiTangHelper changeTextColorWithRestltStr:[NSString stringWithFormat:@"%@:  %@",titleArray[indexPath.section][indexPath.row],dataArray[indexPath.section][indexPath.row]] changeText:dataArray[indexPath.section][indexPath.row] andColor:COLOR_Gray];
        return cell;
    }else if (indexPath.section == 3){
        
        AdviceTableViewCell *cell = [AdviceTableViewCell cellWithTableView:self.tableView];
        
        cell.titleLabel.text = @"院长审核意见";
        cell.topTextView.text = self.yijian;
        cell.nameLabel.text = self.model.dean_name;
        cell.timeLabel.text = self.model.dean_check_date;
        return cell;

        
    }else if (indexPath.section == 4){
        
        AdviceTableViewCell *cell = [AdviceTableViewCell cellWithTableView:self.tableView];
        
        cell.titleLabel.text = @"专家审核意见";
        cell.topTextView.text = self.zhuanjia;
        cell.nameLabel.text = self.model.expert_name;
        cell.timeLabel.text = self.model.expert_check_date;

        return cell;
    }else if (indexPath.section == 1){
        
        
        AdviceTableViewCell *cell = [AdviceTableViewCell cellWithTableView:self.tableView];
         cell.titleLabel.text = @"客户反馈";
        cell.timeLabel.text = @"";
        cell.nameLabel.text = @"";
        cell.topTextView.text = self.fankui;

        
        cell.topTextView.sd_layout
        .heightIs(50);
        
        return cell;
    }
    
    AdviceTableViewCell *cell = [AdviceTableViewCell cellWithTableView:self.tableView];
    cell.titleLabel.text = @"备注";
    cell.timeLabel.text = @"";
    cell.nameLabel.text = @"";
    cell.topTextView.text = self.beizhu;
    cell.topTextView.sd_layout
    .heightIs(50);
    
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 40;
    }else if (indexPath.section == 1){
        return 110;
    }else if (indexPath.section == 2){
        return 90;
    }
    return 120;
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
//获取本月年月日
- (void)nowDateDay{
    dayNum = 0;
    NSString *dateString = [HuaCuiTangHelper getPriousorLaterDateFromNowWithDay:dayNum];
    self.topView.dataLabel.text = dateString;
    
    mBookTime = [self changeDateStringStyleWith:dateString];
}

//改变时间格式
- (NSString *)changeDateStringStyleWith:(NSString *)dateString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    NSDate *date = [formatter dateFromString:dateString];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *newDateStr = [formatter stringFromDate:date];
    
    return newDateStr;
}

#pragma mark NextAndLastDateViewDelegate 上一天下一天
- (void)nextAndLastDateBtnClickWithTag:(NextAndLastDateViewButtonType)tag
{
    switch (tag) {
        case NextAndLastDateViewButtonTypeLast:
        {
            dayNum--;
            flag = @"0";
        }
            break;
        case NextAndLastDateViewButtonTypeNext:
        {
            flag = @"1";
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
- (void)requestData
{
    [LCProgressHUD showLoading:@"正在加载..."];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];

    [params setValue:self.YongHuId forKey:@"customerId"];
    [params setValue:mBookTime forKey:@"dateTime"];
    [params setValue:flag forKey:@"flag"];
    DLog(@"#########%@",mBookTime);
    DLog(@"#########%@",params);

    [HCTConnet getReturnVisitVC:params success:^(id responseObject) {
        self.model = [ReturnVisitModel mj_objectWithKeyValues:responseObject];

        dataArray = @[@[[self judgeString:self.model.employeeName],[self judgeString:self.model.visit_time],[self judgeString:self.model.customerName]]];
        
        self.fankui = self.model.feedback;
        self.zhuanjia = self.model.expert_check_view;
        self.yijian = self.model.dean_check_view;
        self.beizhu = self.model.remark;
        [self judgeString:self.fankui];
        [self judgeString:self.zhuanjia];
        [self judgeString:self.yijian];
        [self judgeString:self.beizhu];

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
