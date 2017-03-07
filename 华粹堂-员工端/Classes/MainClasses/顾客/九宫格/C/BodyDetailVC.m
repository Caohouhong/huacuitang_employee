//
//  BodyDetailVC.m
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/28.
//  Copyright © 2017年 LiQiang. All rights reserved.
//  体质辩证

#import "BodyDetailVC.h"
#import "ChhYuYueTableViewCell.h"
#import "HuaCuiTangHelper.h"
#import "CheckDetailTableViewCell.h"
#import "HCTConnet.h"
#import "BodyDetailModel.h"
@interface BodyDetailVC ()<UITableViewDelegate, UITableViewDataSource>
{
    NSArray *titleArray;
    NSArray *totalArray;
    NSArray *dataArr;
    
}
@property (nonatomic, weak) UITableView *tableView;
@property(nonatomic, strong) BodyDetailModel *model;
@end

@implementation BodyDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"体质辩证";
    titleArray = @[@[@"基本体质",@"相关证型",@"所属脏腑",@"其他"],@[@"客户主诉"],@[@"咨询辩证"],@[@"调理方案"],@[@"家居养生要求"],@[@"专家"]];
    [self drawView];
    [self requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)drawView{
    
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
    .topSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,0);
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
    if (indexPath.section == 0 || indexPath.section == titleArray.count - 1){
        ChhYuYueTableViewCell *cell = [ChhYuYueTableViewCell cellWithTableView:self.tableView];
        
        cell.leftLabel.attributedText = [HuaCuiTangHelper changeTextColorWithRestltStr:[NSString stringWithFormat:@"%@:  %@",titleArray[indexPath.section][indexPath.row],totalArray[indexPath.section][indexPath.row]] changeText:totalArray[indexPath.section][indexPath.row] andColor:COLOR_Gray];
        
        return cell;
    }else  {
        CheckDetailTableViewCell *cell = [CheckDetailTableViewCell cellWithTableView:self.tableView];
        
        cell.leftLabel.text = titleArray[indexPath.section][indexPath.row];
//        cell.bottomLabel.text = dataArr[indexPath.row];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 || indexPath.section == titleArray.count - 1){
        return 40;
    }else {
        return 90;
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
#pragma mark - ====网络====
- (void)requestData
{
    [LCProgressHUD showLoading:@"正在加载..."];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:self.YongHuId forKey:@"customerId"];

    [HCTConnet getBodyDetailVC:params success:^(id responseObject) {
        self.model = [BodyDetailModel mj_objectWithKeyValues:responseObject];
titleArray = @[@[@"基本体质",@"相关证型",@"所属脏腑",@"其他"],@[@"客户主诉"],@[@"咨询辩证"],@[@"调理方案"],@[@"家居养生要求"],@[@"专家"]];
        totalArray = @[@[[self judgeString:self.model.dic_bp_values],[self judgeString:self.model.dic_rs_values],[self judgeString:self.model.dic_organs_values],@""]];
        dataArr = @[@[self.model.customers_complained],@[self.model.consulting_dialectical],@[self.model.conditioning_program],@[self.model.home_health_req]];
//        dataArr = @[@[self.model.customers_complained,self.model.consulting_dialectical,self.model.conditioning_program,self.model.home_health_req]];
        NSLog(@"*******%@******",totalArray);
        [self.tableView reloadData];
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
    
    
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    
    
    
}
- (NSString *)judgeString:(id)str{
    NSString *result = str?str:@"";
    return result;
}
@end
