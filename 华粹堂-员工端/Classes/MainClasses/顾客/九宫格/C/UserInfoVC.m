//
//  UserInfoVC.m
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/28.
//  Copyright © 2017年 LiQiang. All rights reserved.
//  客户信息

#import "UserInfoVC.h"
#import "ChhYuYueTableViewCell.h"
#import "TopSelectView.h"
#import "HuaCuiTangHelper.h"
#import "HCTConnet.h"
@interface UserInfoVC ()<UITableViewDelegate, UITableViewDataSource,TopSelectViewDelegate>
{
    
    
    NSArray *baseArray;
    NSArray *mainArray;
    NSArray *targetArray;
    
    NSArray *basicInformationArr;
    NSArray *mianInformation;
    NSArray *indexInformation;
    
}
@property (nonatomic, strong) TopSelectView *topSelectView;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *totalArray;


//用于判断性别
@property (nonatomic, copy) NSString *Sex;
@property (nonatomic, copy) NSString *marriage;

@end

@implementation UserInfoVC



- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"客户资料";
    
    baseArray = @[@[@"姓名",@"性别",@"生日"],@[@"电话",@"手机",@"QQ",@"地址"],@[@"宗教信仰",@"婚姻状况",@"生育情况",@"家庭关联会员"],@[@"交通工具",@"经济条件",@"职业类别",@"工作单位",@"美容消费习惯"]];
    mainArray = @[@[@"所在门店",@"绑定调理师",@"是否高科技"],@[@"过敏史",@"既往史",@"进店时间",@"最后消费时间",@"最后联系时间"]];
    targetArray = @[@[@"客户类型",@"问题客户",@"顾客状态",@"活跃度",@"满意度"],@[@"客户来源",@"来源说明",@"备注"]];
    
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
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    headerView.backgroundColor = COLOR_BackgroundColor;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
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

- (void)initHeaderView{
    _topSelectView = [[TopSelectView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 35)];
    [_topSelectView.leftButton setTitle:@"基础信息" forState:UIControlStateNormal];
    [self.topSelectView.leftButton setTitleColor:COLOR_Text_Blue forState:UIControlStateNormal];
    [_topSelectView.centerButton setTitle:@"主要信息" forState:UIControlStateNormal];
    [_topSelectView.rightButton setTitle:@"指标信息" forState:UIControlStateNormal];
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
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
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
            break;
        case TopSelectViewTypeCenter:
            [self.topSelectView.centerButton setTitleColor:COLOR_Text_Blue forState:UIControlStateNormal];
            
             [self.dataArray addObjectsFromArray:mainArray];
            [self.totalArray addObjectsFromArray:mianInformation];
            DLog(@"%@",mianInformation);

            break;
        case TopSelectViewTypeRight:
            [self.topSelectView.rightButton setTitleColor:COLOR_Text_Blue forState:UIControlStateNormal];
            
             [self.dataArray addObjectsFromArray:targetArray];
            [self.totalArray addObjectsFromArray:indexInformation];
            DLog(@"%@",indexInformation);

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

    [HCTConnet getCustomerInfo:params success:^(id responseObject) {
        
        self.model = [UserInfoModel mj_objectWithKeyValues:responseObject];
//        [self judgeString:self.model];
      
        if ([self.model.sex isEqualToString:@"1"]) {
            _Sex = @"女";
        }else{
            _Sex = @"男";
        }
        if ([self.model.marriage isEqualToString:@"0"]) {
            _marriage = @"已婚";
        }else{
            _marriage = @"未婚";
        }
     basicInformationArr = @[@[self.model.name,self.model.birthday,_Sex],@[self.model.telephone,self.model.mobile_phone,self.model.QQ,self.model.address],@[@"无",self.marriage,@"无",self.model.family_associate],@[self.model.traffic,self.model.family_salary,self.model.profession,self.model.work_unit,self.model.mr_consume_habits]];
    mianInformation = @[@[@"无",self.model.ename,@"无"],@[self.model.allergy_history,self.model.past_history,self.model.into_store_time,self.model.last_consume_time,self.model.last_contact_time]];
    indexInformation = @[@[@"无",@"无",@"无",@"无",@"无"],@[self.model.dic_source_id,self.model.dic_source,self.model.remark]];
        
        
        [_totalArray addObjectsFromArray:basicInformationArr];
        [_dataArray addObjectsFromArray:baseArray];
        
        DLog(@"%@--%@--%@",basicInformationArr,mianInformation,indexInformation);
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
