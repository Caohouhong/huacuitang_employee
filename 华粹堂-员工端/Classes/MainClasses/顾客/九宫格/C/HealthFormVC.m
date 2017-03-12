//
//  HealthFormVC.m
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/28.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "HealthFormVC.h"
#import "NextAndLastDateView.h"
#import "HuaCuiTangHelper.h"
#import "AdviceTableViewCell.h"
#import "ChhYuYueTableViewCell.h"
#import "HCTConnet.h"
#import "HealthFormModel.h"
@interface HealthFormVC ()<UITableViewDelegate, UITableViewDataSource,NextAndLastDateViewDelegate>
{
    int dayNum;
    NSString *mBookTime;
    NSArray *titleArray;
    NSArray *dataArray;
    NSString *type;
}
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NextAndLastDateView *topView;
@property (nonatomic, strong) HealthFormModel *model;
@property (nonatomic, copy) NSString *time;

@end

@implementation HealthFormVC

- (void)viewDidLoad {
    [super viewDidLoad];
    type = @"1";
    self.navigationItem.title = @"体检报告";
    titleArray = @[@[@"顾客姓名",@"体检项目"],@[@"报告内容"]];
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
    if (indexPath.section == 1 ){
        
        AdviceTableViewCell *cell = [AdviceTableViewCell cellWithTableView:self.tableView];
        
        cell.titleLabel.text = titleArray[indexPath.section][indexPath.row];
        cell.topTextView.text = dataArray[1][indexPath.row];
        cell.timeLabel.text = @"";
        cell.nameLabel.text = @"";
        cell.topTextView.sd_layout
        .heightIs(150);
        
        return cell;

    }else  {
        ChhYuYueTableViewCell *cell = [ChhYuYueTableViewCell cellWithTableView:self.tableView];
        
        cell.leftLabel.attributedText = [HuaCuiTangHelper changeTextColorWithRestltStr:[NSString stringWithFormat:@"%@:  %@",titleArray[indexPath.section][indexPath.row],dataArray[indexPath.section][indexPath.row]] changeText:dataArray[indexPath.section][indexPath.row] andColor:COLOR_Gray];
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1){
        return 200;
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
  
//    NSDictionary *dic = @{@"dateTime":mBookTime,@"flag":flag,@"customerId":self.YongHuId};

    [params setValue:mBookTime forKey:@"creatTime"];
    [params setValue:type forKey:@"type"];
    [params setValue:self.YongHuId forKey:@"customerId"];

    DLog(@"#########%@",params);
    [HCTConnet getHealthFormVC:params success:^(id responseObject) {
        self.model = [HealthFormModel mj_objectWithKeyValues:responseObject];
        dataArray = @[@[[self judgeString:self.name],[self judgeString:self.model.items]],@[[self judgeString:self.model.situation]]];
       
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
