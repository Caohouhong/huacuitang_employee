//
//  AccountInfoDetailVC.m
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/28.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "AccountInfoDetailVC.h"
#import "ChhYuYueTableViewCell.h"
#import "HuaCuiTangHelper.h"
#import "HCTConnet.h"
@interface AccountInfoDetailVC ()<UITableViewDelegate, UITableViewDataSource>
{
    NSArray *titleArray;
    NSArray *dataArray;

}
@property (nonatomic, weak) UITableView *tableView;

@end

@implementation AccountInfoDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"账户信息";
    titleArray = @[@"卡号：",@"项目：",@"余额：",@"剩余次数：",@"办卡时间：",@"最近一次销卡："];
    dataArray = @[@[[self judgeString:self.model.card_number],[self judgeString:self.model.goods_name],[self judgeString:self.model.balance],[self judgeString:self.model.goods_num],[self judgeString:self.model.create_datetime],[self judgeString:self.model.lastXiaokaTime]]];
    DLog(@"%@",dataArray);
    [self drawView];
    //[self requestData];
}
- (NSString *)judgeString:(id)str{
    NSString *result = str?str:@"";
    return result;
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
    
    //    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefersh)];
    //    tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefersh)];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChhYuYueTableViewCell *cell = [ChhYuYueTableViewCell cellWithTableView:self.tableView];
    DLog(@"))))))))%@",dataArray);
//    cell.leftLabel.attributedText = [HuaCuiTangHelper changeTextColorWithRestltStr:[NSString stringWithFormat:@"%@    %@",titleArray[indexPath.row],dataArray[indexPath.row]] changeText:@"" andColor:COLOR_Gray];
    
    
    switch (indexPath.row) {
        case 0: //卡号
            cell.leftLabel.attributedText = [HuaCuiTangHelper changeTextColorWithRestltStr:[NSString stringWithFormat:@"%@:    %@",titleArray[indexPath.row],self.model.card_number.description] changeText:self.model.card_number.description andColor:COLOR_Gray];
            break;
        case 1: //项目
           cell.leftLabel.attributedText = [HuaCuiTangHelper changeTextColorWithRestltStr:[NSString stringWithFormat:@"%@:    %@",titleArray[indexPath.row],self.model.goods_name.description] changeText:self.model.goods_name.description andColor:COLOR_Gray];
            break;
        case 2: //余额
        {
            cell.leftLabel.attributedText = [HuaCuiTangHelper changeTextColorWithRestltStr:[NSString stringWithFormat:@"%@:    %@",titleArray[indexPath.row],self.model.balance.description] changeText:self.model.balance.description andColor:COLOR_Gray];
        }
            break;
        case 3: //剩余次数
        {
              cell.leftLabel.attributedText = [HuaCuiTangHelper changeTextColorWithRestltStr:[NSString stringWithFormat:@"%@:    %@",titleArray[indexPath.row],self.model.goods_num.description] changeText:self.model.goods_num.description andColor:COLOR_Gray];
        }
            break;
        case 4: //办卡时间
           cell.leftLabel.attributedText = [HuaCuiTangHelper changeTextColorWithRestltStr:[NSString stringWithFormat:@"%@:    %@",titleArray[indexPath.row],self.model.create_datetime.description] changeText:self.model.create_datetime.description andColor:COLOR_Gray];
            break;
        case 5: //销卡时间
           cell.leftLabel.attributedText = [HuaCuiTangHelper changeTextColorWithRestltStr:[NSString stringWithFormat:@"%@:    %@",titleArray[indexPath.row],self.model.lastXiaokaTime.description] changeText:self.model.lastXiaokaTime.description andColor:COLOR_Gray];
            break;
        default:
            break;
    }
    
    return cell;
}


#pragma mark - ====网络====
- (void)requestData
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    //    [params setValue:self.model.c_id forKey:@"customerId"];
    [params setValue:self.YongHuId forKey:@"customerId"];
    
    
    [HCTConnet getCustomerAccountInfo:params success:^(id responseObject) {
        
        self.model = [AccountModel mj_objectWithKeyValues:responseObject];
        
        [self.tableView reloadData];
        
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

@end
