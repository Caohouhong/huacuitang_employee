//
//  ReCureDetailVC.m
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/28.
//  Copyright © 2017年 LiQiang. All rights reserved.
//  复诊跟踪

#import "ReCureDetailVC.h"
#import "ChhYuYueTableViewCell.h"
#import "CheckDetailTableViewCell.h"
#import "HuaCuiTangHelper.h"
#import "NextAndLastDateView.h"
#import "HCTConnet.h"
#import "JumpVC.h"
@interface ReCureDetailVC ()<UITableViewDelegate, UITableViewDataSource,NextAndLastDateViewDelegate>
{
    int dayNum;
    NSString *mBookTime;
    NSArray *titleArray;
    NSArray *dataArray;
    NSArray *dataArray1;
 
    
    NSString *type;
}
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NextAndLastDateView *topView;

@end

@implementation ReCureDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    type = @"1";
    self.navigationItem.title = @"复诊跟踪";
    titleArray = @[@[@"门店名称",@"顾客姓名"],@[@"客户主诉"],@[@"咨询辩证"],@[@"调理方案"],@[@"家居养生要求"],@[@"其他说明"],@[@"专家综合满意度"],@[@"方案制定人"]];
    [self drawView];
    [self requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)drawView{
    
    _topView = [[NextAndLastDateView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 35)];
    _topView.delegate = self;
    [_topView.nextBtn setTitle:@"下一条" forState:UIControlStateNormal];
    [_topView.lastBtn setTitle:@"上一条" forState:UIControlStateNormal];
    [self.view addSubview:self.topView];
    
    [self nowDateDay];
    
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

//获取本月年月日
- (void)nowDateDay{
    dayNum = 0;
    NSString *dateString = [HuaCuiTangHelper getPriousorLaterDateFromNowWithDay:dayNum];
    self.topView.dataLabel.text = dateString;
    
    mBookTime = [self changeDateStringStyleWith:dateString];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return titleArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = titleArray[section];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 || indexPath.section == 2 || indexPath.section == 3 || indexPath.section == 4 ){
        
        CheckDetailTableViewCell *cell = [CheckDetailTableViewCell cellWithTableView:self.tableView];
        
        cell.leftLabel.text = titleArray[indexPath.section][indexPath.row];
        cell.bottomLabel.text = dataArray[indexPath.section][indexPath.row];
        return cell;
    }else  {
        ChhYuYueTableViewCell *cell = [ChhYuYueTableViewCell cellWithTableView:self.tableView];
        
//        cell.leftLabel.attributedText = [HuaCuiTangHelper changeTextColorWithRestltStr:[NSString stringWithFormat:@"%@:  %@",titleArray[indexPath.section][indexPath.row],dataArray[indexPath.section][indexPath.row]] changeText:@"未知" andColor:COLOR_Gray];
        DLog(@"^^^%ld,%ld",(long)indexPath.section,(long)indexPath.row);
        if (indexPath.section == 0 ) {
            if (indexPath.row == 0) {
                  cell.leftLabel.attributedText = [HuaCuiTangHelper changeTextColorWithRestltStr:[NSString stringWithFormat:@"%@:  %@",titleArray[indexPath.section][indexPath.row],[self judgeString:self.model.shopName]] changeText:self.model.shopName andColor:COLOR_Gray];
            }else{
                cell.leftLabel.attributedText = [HuaCuiTangHelper changeTextColorWithRestltStr:[NSString stringWithFormat:@"%@:  %@",titleArray[indexPath.section][indexPath.row],[self judgeString:self.model.customerName]] changeText:self.model.customerName andColor:COLOR_Gray];
            }
        }
        if (indexPath.section == 5) {
            
             cell.leftLabel.attributedText = [HuaCuiTangHelper changeTextColorWithRestltStr:[NSString stringWithFormat:@"%@:  %@",titleArray[indexPath.section][indexPath.row],[self judgeString:self.model.other_description]] changeText:self.model.other_description andColor:COLOR_Gray];
            
        }
        if (indexPath.section == 6) {
            cell.leftLabel.attributedText = [HuaCuiTangHelper changeTextColorWithRestltStr:[NSString stringWithFormat:@"%@:  %@",titleArray[indexPath.section][indexPath.row],[self judgeString:self.model.con_eva]] changeText:self.model.con_eva andColor:COLOR_Gray];
        }
        if (indexPath.section == 7) {
            cell.leftLabel.attributedText = [HuaCuiTangHelper changeTextColorWithRestltStr:[NSString stringWithFormat:@"%@:  %@",titleArray[indexPath.section][indexPath.row],[self judgeString:self.model.makers]] changeText:self.model.makers andColor:COLOR_Gray];
        }
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 || indexPath.section == 2 || indexPath.section == 3 || indexPath.section == 4 ){
        return 90;
    }else {
        return 40;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        JumpVC *vc = [[JumpVC alloc] init];
        vc.titlel =@"客户主诉";
        vc.content =[self judgeString:self.model.customers_complained];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section == 2) {
        JumpVC *vc = [[JumpVC alloc] init];
        vc.titlel =@"咨询辩证";
        vc.content =[self judgeString:self.model.dialectics_program];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section == 3) {
        JumpVC *vc = [[JumpVC alloc] init];
        vc.titlel =@"调理方案";
        vc.content =[self judgeString:self.model.d_program_detail];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section == 4) {
        JumpVC *vc = [[JumpVC alloc] init];
        vc.titlel =@"家居养生要求";
        vc.content =[self judgeString:self.model.home_health_req];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
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
#pragma mark - ====网络====
- (void)requestData
{
    [LCProgressHUD showLoading:@"正在加载..."];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:self.YongHuId forKey:@"c_id"];
    [params setValue:type forKey:@"type"];
    [params setValue:@"0" forKey:@"trackTyp"];
    [params setValue:mBookTime forKey:@"dataTime"];
    DLog(@"$$$$$$$$$$$$$$$$$$$%@",params);
    
    [HCTConnet getHighTechDetailVC:params success:^(id responseObject) {
        self.model = [HighTechDetailModel mj_objectWithKeyValues:responseObject];
 
        
        dataArray = @[@[[self judgeString:self.model.shopName],[self judgeString:self.model.customerName]],@[[self judgeString:self.model.customers_complained],[self judgeString:self.model.dialectics_program]],@[[self judgeString:self.model.d_program_detail]],@[[self judgeString:self.model.home_health_req]],@[[self judgeString:self.model.other_description]],@[@""],@[[self judgeString:self.model.makers]]];
        dataArray1 = @[@[@"",[self judgeString:self.model.customerName]],@[[self judgeString:self.model.other_description]],@[@""],@[[self judgeString:self.model.makers]]];
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
