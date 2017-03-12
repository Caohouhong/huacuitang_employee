//
//  MainVC.m
//  华粹堂-员工端
//
//  Created by liqiang on 2016/11/14.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import "MainVC.h"
#import "LrdOutputView.h"
#import "MainOneTypeCell.h"
#import "MainTwoTypeCell.h"
#import "MainThreeTypeCell.h"
#import "TSMainThreeTypeCell.h"

#import "MainTypeView.h"
#import "MenuView.h"

#import "PerfectInfoVC.h"
#import "TSyuyueController.h"
#import "YeJIViewController.h"
#import "ChangePasswordViewController.h"
#import "MessageViewController.h"
#import "YuYueNoticeViewController.h"
#import "CompanyGGViewController.h"
#import "YuYueVC.h"
#import "LoginVC.h"
#import "MessageVC.h"

#import "ModelTrackManage.h"
#import "HuiFangModel.h"

#import "RechargeViewController.h"
#import "TodayTargetVC.h"
#import "ServedViewController.h"
#import "WaitingServeVC.h"
#import "TiaoLiVC.h"
#import "HuiFangViewController.h"
#import "DailySummaryVC.h"
#import "TomorrowPlanVC.h"

#import "HCTConnet.h"
#import "HomeInfoModel.h"

@interface MainVC ()<LrdOutputViewDelegate,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate, MainTwoTypeCellDelegate>

@property (nonatomic, strong) LrdOutputView *outputView;
@property (nonatomic, weak) UITableView  *tableView;
@property (nonatomic ,strong) MenuView  *menu;

@property (nonatomic, strong) HomeInfoModel *homeModel;

@property (nonatomic, strong) NSMutableArray *cellsArray;

@property (nonatomic, strong) NSString *tiaoStr;
@property (nonatomic, strong) NSString *HuiStr;
@end

@implementation MainVC

- (NSMutableArray *)cellsArray
{
    if (!_cellsArray) {
        _cellsArray = [NSMutableArray array];
    }
    
    return _cellsArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(clickhuifangreloadData) name:@"huifangreloadData" object:nil];
    
    self.navigationItem.title = @"华粹堂";
    
    [self drawNav];
    [self drawView];
    [self updataCells];
    
    //请求版本更新
    [self requestUploadData];
    
}

-(void)clickhuifangreloadData {
     [self initTHData];
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self initTHData];
    [self requestHomePageInfo];
}

-(void)initTHData
{
    [LCProgressHUD showLoading:@"正在加载..."];
    
    NSArray *Harray = [[DataManage sharedMemberMySelf] getHuiFangModelArray];
    NSArray *Tarray = [[DataManage sharedMemberMySelf] getTiaoLiModelArray];
    
    NSMutableArray *Harr = [NSMutableArray array];
    NSMutableArray *Tarr = [NSMutableArray array];
    
//    [Harr removeAllObjects];
//    [Tarr removeAllObjects];
    
    for(HuiFangModel * model in Harray) {
        if([model.state isEqualToString:@"1"]){
            [Harr addObject:model];
        }
    }
    if(Harr.count > 0) {
        self.HuiStr = [NSString stringWithFormat:@"%lu个没有填写",(unsigned long)Harr.count];
    }else {
        self.HuiStr = @"";
    }

    for(ModelTrackManage * model in Tarray) {
        if([model.state isEqualToString:@"1"]){
            [Tarr addObject:model];
        }
    }
    
    if(Tarr.count > 0) {
        self.tiaoStr = [NSString stringWithFormat:@"%lu个没有填写",(unsigned long)Tarr.count];
    }else {
        self.tiaoStr = @"";
    }
    
    [self.tableView reloadData];

    [LCProgressHUD hide];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
     [self.menu hidenWithAnimation];
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.menu hidenWithAnimation];
}

- (void)drawNav
{
//    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithTitle:[ModelMember sharedMemberMySelf].shopName style:UIBarButtonItemStylePlain target:nil action:nil];
//    self.navigationItem.leftBarButtonItem = leftBar;
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"icon_set" target:self action:@selector(leftButton)];
    
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_messege"] style:UIBarButtonItemStylePlain target:self action:@selector(more)];
    self.navigationItem.rightBarButtonItem = rightBar;
    
//    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 35)];//allocate titleView
//    UIColor *color =  self.navigationController.navigationBar.barTintColor;
//    [titleView setBackgroundColor:color];
//    
//    UISearchBar *searchBar = [[UISearchBar alloc] init];
//    searchBar.delegate = self;
//    searchBar.frame = CGRectMake(0, 0, 200, 35);
//    searchBar.backgroundColor = color;
//    searchBar.layer.cornerRadius = 18;
//    searchBar.layer.masksToBounds = YES;
//    [searchBar.layer setBorderWidth:8];
//    [searchBar.layer setBorderColor:[UIColor whiteColor].CGColor];  //设置边框为白色
//    searchBar.placeholder = @"请输入你想要搜索的内容";
//    [titleView addSubview:searchBar];
//    
//    //Set to titleView
//    [self.navigationItem.titleView sizeToFit];
//    self.navigationItem.titleView = titleView;
    
    MainTypeView *mainV = [[MainTypeView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth*0.8, ScreenHeight+15)];
    WEAK(weakSelf)
    mainV.oneBlock = ^(NSInteger tag) {
        [weakSelf clcikoneBlockWithTag:tag];
    
    };
    MenuView *menu = [MenuView MenuViewWithDependencyView:self.view MenuView:mainV isShowCoverView:YES];
    self.menu = menu;
}

- (void)drawView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = HEXCOLOR(0xeeeeee);
    tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    tableView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,49);
    
//    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefersh)];
//    tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefersh)];
}

-(void)leftButton {
    [self.menu show];
}

- (void)more
{
    MessageVC *messVC = [[MessageVC alloc]init];
    messVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:messVC animated:YES];
    
//    LrdCellModel *one = [[LrdCellModel alloc] initWithTitle:@"消息" imageName:@""];
//    LrdCellModel *two = [[LrdCellModel alloc] initWithTitle:@"预约通知" imageName:@""];
//    LrdCellModel *three = [[LrdCellModel alloc] initWithTitle:@"公司公告" imageName:@""];
//    NSArray *array = @[one,two,three];
//    __weak typeof(self) weakSelf = self;
//    CGFloat x = ScreenWidth - 10;
//    CGFloat y = 70;
//    self.outputView = [[LrdOutputView alloc] initWithDataArray:array origin:CGPointMake(x, y) width:130 height:44 direction:kLrdOutputViewDirectionRight];
//    self.outputView.delegate = self;
//    self.outputView.dismissOperation = ^(){
//        //设置成nil，以防内存泄露
//        weakSelf.outputView = nil;
//    };
//    [self.outputView pop];
}
//pop 跳转控制器
-(void)didSelectedAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"---%ld", indexPath.row);
    if(indexPath.row == 0) {
        MessageViewController *messVc = [[MessageViewController alloc]init];
        messVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:messVc animated:YES];
    }else if (indexPath.row == 1) {
        YuYueNoticeViewController *notVC = [[YuYueNoticeViewController alloc]init];
        notVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:notVC animated:YES];
    }else {
        CompanyGGViewController *comVC = [[CompanyGGViewController alloc]init];
        comVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:comVC animated:YES];
    }
}

-(void)clcikoneBlockWithTag:(NSInteger )tag {
    [self.menu hidenWithAnimation];
    if(tag == 0) {
        PerfectInfoVC *perVC = [[PerfectInfoVC alloc]init];
        perVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:perVC animated:YES];
    }else if (tag == 1) {
        ChangePasswordViewController *cpVC = [[ChangePasswordViewController alloc]init];
        cpVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:cpVC animated:YES];
    }else if (tag == 2) {
        
    }else if (tag == 3) {
        YeJIViewController *yejiVC = [[YeJIViewController alloc]init];
        yejiVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:yejiVC animated:yejiVC];
    }else {
        [[ModelMember sharedMemberMySelf] logOut];
        WINDOW.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[LoginVC alloc] init]];
    }
}

- (void)updataCells
{
    self.cellsArray = [NSMutableArray array];
    NSDictionary *dic1 = @{kCell:@"MainOneTypeCell"};
    NSDictionary *dic2 = @{kCell:@"MainTwoTypeCell"};
    NSDictionary *dic3 = @{kCell:@"MainThreeTypeCell"};
    
    [self.cellsArray addObject:dic1];
    [self.cellsArray addObject:dic2];
    [self.cellsArray addObject:dic3];
    
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark ================= UISearchBarDelegate =================
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return NO;
}

#pragma mark -
#pragma mark ================= <UITableViewDelegate,UITableViewDataSource> =================
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //return 1;
    return self.cellsArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 2) {
        return 5;
    }
    return 1;
    //return self.cellsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = self.cellsArray[indexPath.section];
    
    if ([dic[kCell] isEqualToString:@"MainOneTypeCell"])
    {
        MainOneTypeCell *cell = [MainOneTypeCell cellWithTableView:tableView];
        cell.model = self.homeModel;
        return cell;
    }
    if ([dic[kCell] isEqualToString:@"MainTwoTypeCell"])
    {
        MainTwoTypeCell *cell = [MainTwoTypeCell cellWithTableView:tableView];
        cell.delegate = self;
        cell.model = self.homeModel;
        return cell;
    }
    if ([dic[kCell] isEqualToString:@"MainThreeTypeCell"])
    {
        TSMainThreeTypeCell *cell = [TSMainThreeTypeCell cellWithTableview:tableView];
        cell.nameLabel.text = titleArray[indexPath.row];
        cell.iconimageView.image = [UIImage imageNamed:imageviewArray[indexPath.row]];
        if(indexPath.row == 1) {
            cell.rightLabel.text = self.tiaoStr;
        }
        if(indexPath.row == 2) {
            cell.rightLabel.text = self.HuiStr;
        }
        return cell;
    }
    
    return [UITableViewCell new];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.section == 2) {
        switch (indexPath.row) {
            case 0: //预约
            {
                YuYueVC *yueVC = [[YuYueVC alloc]init];
                yueVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:yueVC animated:YES];
            }
                break;
            case 1: //调理备忘
            {
                TiaoLiVC *tonVC = [[TiaoLiVC alloc]init];
                tonVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:tonVC animated:YES];
            }
                break;
            case 2: //服务回访
            {
                HuiFangViewController *hfVC = [[HuiFangViewController alloc]init];
                hfVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:hfVC animated:YES];
            }
                break;
            case 3://今日总结
            {
                DailySummaryVC *yeVC = [[DailySummaryVC alloc]init];
                yeVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:yeVC animated:YES];
            }
                break;
            case 4://明日计划
            {
                TomorrowPlanVC *yeVC = [[TomorrowPlanVC alloc]init];
                yeVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:yeVC animated:YES];
            }
                break;
            default:
                break;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = self.cellsArray[indexPath.section];
    
    if ([dic[kCell] isEqualToString:@"MainOneTypeCell"])
    {
        return 100;
    }
    if ([dic[kCell] isEqualToString:@"MainTwoTypeCell"])
    {
        return 170;
    }
    if ([dic[kCell] isEqualToString:@"MainThreeTypeCell"])
    {
        return 50;
    }
    
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    NSDictionary *dic = self.cellsArray[section];
    
    if ([dic[kCell] isEqualToString:@"MainOneTypeCell"])
    {
        return 0.01;
    }else if ([dic[kCell] isEqualToString:@"MainThreeTypeCell"])
    {
        return 0.01;
    }
    
    return 5;
}

#pragma MainTwoTypeCellDelegate
- (void)mianTwoTypeCellButtonClickWithTag:(int)tag
{
    switch (tag) {
        case MainTwoTypeCellButton1: //本月已服务
        {
            ServedViewController *servedVC = [[ServedViewController alloc] init];
            servedVC.viewType = ServedVCTypeHaveServed;
             servedVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:servedVC animated:YES];
        }
            break;
        case MainTwoTypeCellButton2: //本月待服务
        {
            ServedViewController *servedVC = [[ServedViewController alloc] init];
            servedVC.viewType = ServedVCTypeWaitServe;
            servedVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:servedVC animated:YES];
        }
            break;
        case MainTwoTypeCellButton3: //今明日待服务
        {
            WaitingServeVC *waitVC = [[WaitingServeVC alloc] init];
            waitVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:waitVC animated:YES];
        }
            break;
        case MainTwoTypeCellButton4: //本月销售业绩
        {
            RechargeViewController *rechargeVC = [[RechargeViewController alloc] init];
             rechargeVC.viewType = RechargeVCTypeRecharge;
            rechargeVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:rechargeVC animated:YES];
        }
            break;
        case MainTwoTypeCellButton5: //本月消耗业绩
        {
            RechargeViewController *rechargeVC = [[RechargeViewController alloc] init];
            rechargeVC.viewType = RechargeVCTypeSpend;
            rechargeVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:rechargeVC animated:YES];
        }
            break;
        case MainTwoTypeCellButton6: //今日目标
        {
            TodayTargetVC *todayVC = [[TodayTargetVC alloc] init];
            todayVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:todayVC animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark ============= 网络 =================
//请求首页数据
- (void)requestHomePageInfo
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:[ModelMember sharedMemberMySelf].memberId forKey:@"employeeId"];
    
    [HCTConnet getHomeEmployeePageInfo:params success:^(id responseObject) {
        
        self.homeModel = [HomeInfoModel mj_objectWithKeyValues:responseObject];
        
        [self.tableView reloadData];
        
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}

//请求更新
- (void)requestUploadData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@(582) forKey:@"type"]; //581: android员工端  582: iOS员工端

    [params setValue:VERSION_BUILD forKey:@"ver"]; //当前版本
    
    [HCTConnet getOtherIsUpdate:params success:^(id responseObject) {
        
        //H 测试
        NSString *flag = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"flag"]]; //0－无更新  1-有更新 2-强制更新
        NSString *downloadUrl = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"downloadUrl"]];
        
//        if ([@"1" isEqualToString:flag]){
//            [self isEnForseUpdateWithNewVersion:NO andURL:downloadUrl];
//        }else if ([@"2" isEqualToString:flag]){
//            [self isEnForseUpdateWithNewVersion:YES andURL:downloadUrl];
//        }else {
//            
//        }

    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}

- (void)isEnForseUpdateWithNewVersion:(BOOL) isEnForse andURL:(NSString *)url{ //是否强制
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"版本更新" message:@"检测到有新的版本，请尽快更新吧" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *done = [UIAlertAction actionWithTitle:@"前往更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
        
    }];
    [alertController addAction:done];
    
    if (!isEnForse){
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"下次再说" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertController addAction:cancel];
    }
    
    [self presentViewController:alertController animated:YES completion:nil];
}


@end
