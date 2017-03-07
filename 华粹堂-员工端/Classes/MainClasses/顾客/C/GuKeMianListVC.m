//
//  GuKeMianListVC.m
//  华粹堂-员工端
//
//  Created by liqiang on 2016/11/24.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import "GuKeMianListVC.h"
#import "GuKeMainListCell.h"
#import "GuKeShaiXuanMenuView.h"
#import "ModelGuKe.h"
#import "GuKeDetailVC.h"
#import "SPullDownMenuView.h"
#import "GuKeDetailVCV2.h"
#import "HCTConnet.h"

@interface GuKeMianListVC ()<UITableViewDelegate,UITableViewDataSource,GuKeShaiXuanMenuViewDelegate,UISearchBarDelegate,SPullDownMenuViewDelegate>
{
    int gukeCate; //本店顾客(区分)
    int timeCate; //时间类型
    int ABCCate; //ABC类  A-264 B-265 C-266
}
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, weak) UISearchBar *searchBar;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) UIView *tabView;
@property (nonatomic, strong) GuKeShaiXuanMenuView *menu;
@property (nonatomic, assign) int pageNo;
@property (nonatomic, strong) SPullDownMenuView *menu2;
@property (nonatomic, strong) NSArray *titleA;

@end

@implementation GuKeMianListVC

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self drawNav];
    [self drawTabChooseView];
    [self drawView];
    [self headerRefersh];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.menu closeLeftView];
    [self.menu2 tapClick];
}

-  (void)drawView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    //    tableView.tableFooterView = [self drawFooterView];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    tableView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.menu2,0)
    .bottomSpaceToView(self.view,0);
    
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefersh)];
    tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefersh)];
    
    GuKeShaiXuanMenuView *menu = [[GuKeShaiXuanMenuView alloc] initWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, ScreenHeight2)];
    menu.menuViewDelegate = self;
    [self.navigationController.view addSubview:menu];
    self.menu = menu;
    
    @weakify(self);
    menu.didClickSureBlick = ^(){
        @strongify(self);
        [self headerRefersh];
    };
}

- (void)drawNav
{
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_search"] style:UIBarButtonItemStylePlain target:self action:@selector(search)];
    self.navigationItem.rightBarButtonItem = rightBarBtn;
    
//    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 35)];//allocate titleView
//    UIColor *color =  self.navigationController.navigationBar.barTintColor;
//    [titleView setBackgroundColor:color];
//    
//    UISearchBar *searchBar = [[UISearchBar alloc] init];
//        searchBar.delegate = self;
//    searchBar.frame = CGRectMake(0, 0, 200, 35);
//    searchBar.backgroundColor = color;
//    searchBar.layer.cornerRadius = 18;
//    searchBar.layer.masksToBounds = YES;
//    [searchBar.layer setBorderWidth:8];
//    [searchBar.layer setBorderColor:[UIColor whiteColor].CGColor];  //设置边框为白色
//    searchBar.placeholder = @"请输入你想要搜索的内容";
//    [titleView addSubview:searchBar];
//    
//    [self.navigationItem.titleView sizeToFit];
//    self.navigationItem.titleView = titleView;
//    self.searchBar = searchBar;
}

- (void)drawTabChooseView
{
    //264，265，266
    self.titleA = @[@[@"所有顾客",@"本店顾客",@"我服务过的顾客"], @[@"A类",@"B类",@"C类"],@[@"最后一次到店时间",@"最后一次消费时间",@"最后一次回访时间"],@[@"筛选"]];
    self.menu2 = [[SPullDownMenuView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40) withTitle:self.titleA withSelectColor:HEXCOLOR(0x4fbbf6)];
    self.menu2.delegate = self;
    [self.view addSubview:self.menu2];
}

- (void)search
{
    
}

- (void)headerRefersh
{
    self.pageNo = 1;
    [self requestData];
}

- (void)footerRefersh
{
    self.pageNo ++;
    [self requestData];
}

- (void)shaiXuan
{
    [self.searchBar endEditing:YES];
    
    if (self.menu.isRightViewHidden) {
        [self.menu openLeftView];
    }

}

- (void)pullDownMenuView:(SPullDownMenuView *)menu didSelectedIndex:(NSIndexPath *)indexPath
{
    NSString *str = [[self.titleA objectAtIndex:indexPath.row] objectAtIndex:indexPath.section];
    
    if (indexPath.row == 0){
        switch (indexPath.section) {
            case 1://本店
                gukeCate = 1;
            case 2://我服务过的
                gukeCate = 2;
            default:
                gukeCate = 0;
                break;
        }
    }else if (indexPath.row == 1){ //abc类
        ABCCate = 264 + (int)indexPath.section;
    }else if (indexPath.row == 2){
        timeCate = 1 + (int)indexPath.section;
    }
    
    DLog(@"1:%i,2:%i,3:%i",gukeCate,ABCCate,timeCate);
    
    DLog(@"section:%ld,row:%ld",(long)indexPath.section,(long)indexPath.row);
    DLog(@"选中的Str:%@",str);
    
    
    if ([str isEqualToString:@"筛选"])
    {
        [self shaiXuan];
    }else {
         [self requestData];
    }
    
}

#pragma mark - =============== 网络 =================
- (void)requestData
{
    //    storeId  - 门店(本店顾客)
    //    employeeId - 我服务过的顾客
    
    //show hud
    [LCProgressHUD showLoading:@"正在加载..."];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@(self.pageNo) forKey:@"pageNo"];
    [params setValue:@(20) forKey:@"pageSize"];
    
    if (self.menu.nameSearchTextfield.text.length)
    {
        [params setValue:self.menu.nameSearchTextfield.text forKey:@"customerNameLike"];
    }
    if (self.menu.libieId.length)
    {
        [params setValue:self.menu.libieId forKey:@"libieId"];
    }

    if (self.menu.shopId.length)
    {
        [params setValue:self.menu.shopId forKey:@"shopId"];
    }
    
    if (self.menu.employeeId.length)
    {
        [params setValue:self.menu.employeeId forKey:@"employeeId"];
    }
    
    //排序1 2 3
    [params setValue:@(timeCate) forKey:@"orderBy"];
    //顾客类型A B C
    [params setValue:@(ABCCate) forKey:@"customerCategory"];
    
    if (gukeCate == 1) { //本店顾客
        [params setValue:[ModelMember sharedMemberMySelf].s_id forKey:@"storeId"];
    }else if (gukeCate == 2) { //我服务过的顾客
        [params setValue:[ModelMember sharedMemberMySelf].memberId forKey:@"employeeId"];
    }
    
    [HCTConnet getCustomerListCustomerV2:params success:^(id responseObject) {
        
        NSArray *array =  [ModelGuKe mj_objectArrayWithKeyValuesArray:[responseObject valueForKey:@"data"]];
        
        if (self.pageNo == 1)
        {
            self.dataArray = [NSMutableArray arrayWithArray:array];
        }
        else
        {
            [self.dataArray addObjectsFromArray:array];
        }
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        if (array.count < 20)
        {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
    } successBackfailError:^(id responseObject) {
        self.dataArray = [NSMutableArray array];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        self.dataArray = [NSMutableArray array];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - ======== <UITableViewDelegate,UITableViewDataSource> =========
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GuKeMainListCell *cell = [GuKeMainListCell cellWithTableView:tableView];
    cell.model = self.dataArray[indexPath.section];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.searchBar endEditing:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ModelGuKe *model = self.dataArray[indexPath.section];
    
    GuKeDetailVCV2 *vc = [[GuKeDetailVCV2 alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.model = model;
    [DCURLRouter pushViewController:vc animated:YES];
}

#pragma mark -
#pragma mark ================= UISearchBarDelegate =================
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    self.menu.nameSearchTextfield.text = searchBar.text;
    [self headerRefersh];
    [self.searchBar endEditing:YES];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *) searchBar
{
    UITextField *searchBarTextField = nil;
    NSArray *views = ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) ? searchBar.subviews : [[searchBar.subviews objectAtIndex:0] subviews];
    for (UIView *subview in views)
    {
        if ([subview isKindOfClass:[UITextField class]])
        {
            searchBarTextField = (UITextField *)subview;
            break;
        }
    }
    searchBarTextField.enablesReturnKeyAutomatically = NO;
}

@end
