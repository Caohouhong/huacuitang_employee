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

@interface MainVC ()<LrdOutputViewDelegate,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate, MainTwoTypeCellDelegate>

@property (nonatomic, strong) LrdOutputView *outputView;
@property (nonatomic, weak) UITableView  *tableView;
@property (nonatomic ,strong) MenuView  *menu;
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
    [self initData];
    [self.tableView reloadData];
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
        self.HuiStr = [NSString stringWithFormat:@"%ld个没有填写",Harr.count];
    }else {
        self.HuiStr = @"";
    }

    for(ModelTrackManage * model in Tarray) {
        if([model.state isEqualToString:@"1"]){
            [Tarr addObject:model];
        }
    }
    
    if(Tarr.count > 0) {
        self.tiaoStr = [NSString stringWithFormat:@"%ld个没有填写",Tarr.count];
    }else {
        self.tiaoStr = @"";
    }
    
    [self.tableView reloadData];

    [LCProgressHUD hide];
}

-(void)initData {
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:[ModelMember sharedMemberMySelf].memberId forKey:@"employeeId"];
    
    [[LQHTTPSessionManager sharedManager] LQPost:@"employee/getEmployeePerformanceByemployee" parameters:params showTips:@"正在加载..." success:^(id responseObject) {
        
        NSString *serve_count = [NSString stringWithFormat:@"%.f", [responseObject[@"serve_count"]floatValue]];
        NSString *money_in_sum = [NSString stringWithFormat:@"%.2f", [responseObject[@"money_in_sum"]floatValue]];
        NSString *money_out_sum = [NSString stringWithFormat:@"%.2f", [responseObject[@"money_out_sum"]floatValue]];
        NSLog(@"---%@---%@---%@",serve_count,money_in_sum,money_out_sum);
    
        
        [UserDefaults setValue:serve_count forKey:@"serve_count"];
        [UserDefaults synchronize];
        
        [UserDefaults setValue:money_in_sum forKey:@"money_in_sum"];
        [UserDefaults synchronize];
        
        [UserDefaults setValue:money_out_sum forKey:@"money_out_sum"];
        [UserDefaults synchronize];
        
        [self.tableView reloadData];
        
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
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
        cell.model = [ModelMember sharedMemberMySelf];
        return cell;
    }
    if ([dic[kCell] isEqualToString:@"MainTwoTypeCell"])
    {
        MainTwoTypeCell *cell = [MainTwoTypeCell cellWithTableView:tableView];
        cell.delegate = self;
        cell.label1.text = [UserDefaults valueForKey:@"serve_count"];
        cell.label2.text = [UserDefaults valueForKey:@"money_in_sum"];
        cell.label3.text = [UserDefaults valueForKey:@"money_out_sum"];
        
        
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

@end
