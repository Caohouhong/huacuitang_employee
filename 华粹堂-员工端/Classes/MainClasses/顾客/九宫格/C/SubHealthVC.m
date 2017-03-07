//
//  SubHealthVC.m
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/28.
//  Copyright © 2017年 LiQiang. All rights reserved.
//  气医亚健康

#import "SubHealthVC.h"
#import "TopSelectView.h"
#import "ChhYuYueTableViewCell.h"
#import "HuaCuiTangHelper.h"
#import "HCTConnet.h"
@interface SubHealthVC ()<UITableViewDelegate, UITableViewDataSource,TopSelectViewDelegate>
{
    NSArray *baseArray;
    NSArray *mainArray;
    NSArray *targetArray;
    
    NSArray *basicInformationArr;
    NSArray *mianInformation;
    NSArray *indexInformation;
    
    UIView *footerView;
    UILabel *noticeLabel;
}
@property (nonatomic, strong) TopSelectView *topSelectView;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *totalArray;

@end

@implementation SubHealthVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"气医亚健康";
    
    baseArray = @[@[@"精神",@"精神其他"],@[@"面色",@"面色其他"],@[@"体感",@"体感其他"],@[@"妇科",@"妇科其他"],@[@"肾气",@"肾气其他"]];
    mainArray = @[@[@"首要需求",@"症状备注"],@[@"火",@"火其他"],@[@"木",@"木其他"],@[@"土",@"土其他"],@[@"金",@"金其他"],@[@"水",@"水其他"]];
    targetArray = @[@[@"舌质",@"舌质其他"],@[@"舌苔",@"舌苔其他"]];
    
    if (!self.dataArray){
        _dataArray = [NSMutableArray array];
    }
    
    if (!self.totalArray){
        _totalArray = [NSMutableArray array];
    }

    
    [self drawView];
    [self requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)drawView{
    
    [self initHeaderView];
    
    footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    footerView.backgroundColor = COLOR_BG_DARK_BLUE;
    
    noticeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, ScreenWidth - 30, 40)];
    noticeLabel.textColor = COLOR_TEXT_DARK_BLUE;
    noticeLabel.font = SYSTEM_FONT_(14);
    noticeLabel.numberOfLines = 0;
    noticeLabel.text = @"以上所列症状若出现3种以上者即可诊为气虚，体寒怕冷甚者为阳气虚";
    [footerView addSubview:noticeLabel];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = COLOR_BackgroundColor;
    tableView.tableFooterView = footerView;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    tableView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,35)
    .bottomSpaceToView(self.view,0);
}

- (void)initHeaderView{
    _topSelectView = [[TopSelectView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 35)];
    [_topSelectView.leftButton setTitle:@"症状" forState:UIControlStateNormal];
    [self.topSelectView.leftButton setTitleColor:COLOR_Text_Blue forState:UIControlStateNormal];
    [_topSelectView.centerButton setTitle:@"脏腑" forState:UIControlStateNormal];
    [_topSelectView.rightButton setTitle:@"舌象" forState:UIControlStateNormal];
    _topSelectView.markView.hidden = YES;
    _topSelectView.delegate = self;
    [self.view addSubview:self.topSelectView];
}

#pragma mark - UITableView代理
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
    ChhYuYueTableViewCell *cell = [ChhYuYueTableViewCell cellWithTableView:self.tableView];
    
    cell.leftLabel.attributedText = [HuaCuiTangHelper changeTextColorWithRestltStr:[NSString stringWithFormat:@"%@:  %@",self.dataArray[indexPath.section][indexPath.row],self.totalArray[indexPath.section][indexPath.row]] changeText:self.totalArray[indexPath.section][indexPath.row] andColor:COLOR_Gray];
    NSLog(@"%@",self.totalArray);
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    headerView.backgroundColor = COLOR_BackgroundColor;
    
    return headerView;
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
            [self.dataArray addObjectsFromArray:baseArray];
            [self.totalArray addObjectsFromArray:basicInformationArr];
            noticeLabel.text = @"以上所列症状若出现3种以上即可诊为气虚，体寒怕冷甚者为阳气虚";
            footerView.hidden = NO;
            break;
        case TopSelectViewTypeCenter:
            [self.topSelectView.centerButton setTitleColor:COLOR_Text_Blue forState:UIControlStateNormal];
            [self.dataArray addObjectsFromArray:mainArray];
            [self.totalArray addObjectsFromArray:mianInformation];
            noticeLabel.text = @"注：基本症状需与各脏常见症以及舌象相结合进行辩证管理";
            footerView.hidden = NO;
            break;
        case TopSelectViewTypeRight:
            [self.topSelectView.rightButton setTitleColor:COLOR_Text_Blue forState:UIControlStateNormal];
            [self.dataArray addObjectsFromArray:targetArray];
            [self.totalArray addObjectsFromArray:indexInformation];
            noticeLabel.text = @"";
            footerView.hidden = YES;
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
    [params setValue:self.YongHuId forKey:@"customerId"];
   [HCTConnet getSubHealthVC:params success:^(id responseObject) {
       self.model = [SubHealthModel mj_objectWithKeyValues:responseObject];
 
    
       basicInformationArr = @[@[[self judgeString:self.model.dic_mind_values],[self judgeString:self.model.dic_mind_others]],@[[self judgeString:self.model.dic_cp_values],[self judgeString:self.model.dic_cp_others]],@[[self judgeString:self.model.dic_ss_values],[self judgeString:self.model.dic_ss_others]],@[[self judgeString:self.model.dic_gnl_values],[self judgeString:self.model.dic_gnl_others]],@[[self judgeString:self.model.dic_kidneyQi_values],[self judgeString:self.model.dic_kidneyQi_others]]];

       DLog(@"basicInformationArr:%@",basicInformationArr);

       
       mianInformation = @[@[[self judgeString:self.model.solve_problem],[self judgeString:self.model.symptom_remark]],@[[self judgeString:self.model.dic_heart_values],[self judgeString:self.model.dic_heart_others]],@[[self judgeString:self.model.dic_liver_values],[self judgeString:self.model.dic_liver_others]],@[[self judgeString:self.model.dic_spleen_values],[self judgeString:self.model.dic_spleen_others]],@[[self judgeString:self.model.dic_lung_values],[self judgeString:self.model.dic_lung_others]],@[[self judgeString:self.model.dic_kidney_values],[self judgeString:self.model.dic_kidney_others]]];

       indexInformation = @[@[[self judgeString:self.model.dic_tongueZ_values],[self judgeString:self.model.dic_tongueZ_others]],@[[self judgeString:self.model.dic_tongueT_values],[self judgeString:self.model.dic_tongueT_others]]];
       
       
       
       
       [_totalArray addObjectsFromArray:basicInformationArr];
       [_dataArray addObjectsFromArray:baseArray];
       
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
