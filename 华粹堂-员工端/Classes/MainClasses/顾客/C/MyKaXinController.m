//
//  MyKaXinController.m
//  华粹堂-客户端
//
//  Created by 唐硕 on 16/12/1.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import "MyKaXinController.h"
#import "MyKaXinCell.h"
#import "MyKaXinModel.h"
#import "YuYueDateChooseVC.h"
#import "MyKaYuYueViewController.h"

@interface MyKaXinController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong ) NSMutableArray *dataArray;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) UIButton *chongBtn;
@property (nonatomic, weak) UIButton *xiaoBtn;
@property (nonatomic, assign) int pageNo;
@property (nonatomic ,copy) NSString *type;

@property (nonatomic ,assign) long startStr;
@property (nonatomic ,assign) long endStr;
@end

@implementation MyKaXinController

-(NSMutableArray *)dataArray {
    if(_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.title = [NSString stringWithFormat:@"%@%@",[self.model.type isEqualToString:@"0"]?@"现金卡":@"商品卡",self.model.card_number];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
//    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"calendar"] style:UIBarButtonItemStylePlain target:self action:@selector(didClickRightBar)];
//    self.navigationItem.rightBarButtonItem = rightBar;

    self.pageNo = 1;
    [self initView];
    [self drawView];
    [self clcikchongBtn];
}



-(void)initView {
    
    UIImageView *iconimageView = [[UIImageView alloc]init];
    iconimageView.image = [UIImage imageNamed:@"ka"];
    iconimageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:iconimageView];
    
    UILabel *goodName = [[UILabel alloc]init];
    goodName.font = [UIFont systemFontOfSize:14.0];
    goodName.text = [NSString stringWithFormat:@"相关产品: %@",self.model.goods_name];
    goodName.textColor = HEXCOLOR(0x333333);
    [self.view addSubview:goodName];
    
    UIView *topLineV = [self lineView];
    [self.view addSubview:topLineV];

    iconimageView.sd_layout
    .leftSpaceToView(self.view,20)
    .topSpaceToView(self.view,15)
    .widthIs(50).heightIs(30);
    
    goodName.sd_layout
    .leftSpaceToView(iconimageView,30)
    .centerYEqualToView(iconimageView)
    .rightSpaceToView(self.view,10).heightIs(20);
    
    topLineV.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(iconimageView,15).heightIs(0.7);
    
   
    UILabel *jinLabel = [self LabelWithTitle:@"金额" Color:HEXCOLOR(0x333333)];
    UILabel *chongLabel = [self LabelWithTitle:@"充值" Color:HEXCOLOR(0x333333)];
    UILabel *ciLabel = [self LabelWithTitle:@"剩余次数" Color:HEXCOLOR(0x333333)];
    
    NSString *balance = [NSString stringWithFormat:@"%.2f", [self.model.balance floatValue]];
    NSString *totalAmount = [NSString stringWithFormat:@"%.2f", [self.model.totalAmount floatValue]];
    NSString *goods_num = [NSString stringWithFormat:@"%.f", [self.model.goods_num floatValue]];
    
    UILabel *jinNumLabel = [self LabelWithTitle:TSTRING_NOT_EMPTY(balance)?balance:@"0.00" Color:[UIColor redColor]];
    UILabel *chongNumLabel = [self LabelWithTitle:TSTRING_NOT_EMPTY(totalAmount)?totalAmount:@"0.00" Color:[UIColor redColor]];
    UILabel *ciNumLabel = [self LabelWithTitle:TSTRING_NOT_EMPTY(goods_num)?goods_num:@"0.00" Color:[UIColor redColor]];
    
    UIView *BomLineV1 = [self createBottonView];
    UIView *BomLineV2 = [self createBottonView];
    [self.view sd_addSubviews:@[jinLabel,chongLabel,ciLabel,jinNumLabel,chongNumLabel,ciNumLabel,BomLineV1,BomLineV2]];
    
    jinLabel.sd_layout
    .leftSpaceToView(self.view,0)
    .topSpaceToView(topLineV,10)
    .widthIs((ScreenWidth - 1)/3)
    .heightIs(20);
    
    jinNumLabel.sd_layout
    .topSpaceToView(jinLabel,10)
    .leftEqualToView(jinLabel)
    .widthRatioToView(jinLabel,1)
    .heightRatioToView(jinLabel,1);
    
    BomLineV1.sd_layout
    .leftSpaceToView(jinLabel,0)
    .topSpaceToView(topLineV,20)
    .widthIs(0.5).heightIs(30);
    
    chongLabel.sd_layout
    .leftSpaceToView(BomLineV1,0)
    .topEqualToView(jinLabel)
    .widthRatioToView(jinLabel,1)
    .heightRatioToView(jinLabel,1);
    
    chongNumLabel.sd_layout
    .topSpaceToView(chongLabel,10)
    .leftEqualToView(chongLabel)
    .widthRatioToView(chongLabel,1)
    .heightRatioToView(chongLabel,1);
    
    BomLineV2.sd_layout
    .leftSpaceToView(chongLabel,0)
    .topSpaceToView(topLineV,20)
    .widthIs(0.5).heightIs(30);
    
    ciLabel.sd_layout
    .leftSpaceToView(BomLineV2,0)
    .topEqualToView(jinLabel)
    .widthRatioToView(jinLabel,1)
    .heightRatioToView(jinLabel,1);
    
    ciNumLabel.sd_layout
    .topSpaceToView(ciLabel,10)
    .leftEqualToView(ciLabel)
    .widthRatioToView(ciLabel,1)
    .heightRatioToView(ciLabel,1);
    
    UIButton *chongButton = [self ButtonWithTitle:@"充值记录" target:self action:@selector(clcikchongBtn)];
    [self.view addSubview:chongButton];
    self.chongBtn = chongButton;
    
    UIButton *xiaoButton = [self ButtonWithTitle:@"消费记录" target:self action:@selector(clcikxiaoBtn)];
    [self.view addSubview:xiaoButton];
    self.xiaoBtn = xiaoButton;
    
    chongButton.sd_layout
    .leftSpaceToView(self.view,0)
    .topSpaceToView(ciNumLabel,10)
    .widthIs((ScreenWidth - 10)/2)
    .heightIs(45);
    
    xiaoButton.sd_layout
    .leftSpaceToView(chongButton,10)
    .topSpaceToView(ciNumLabel,10)
    .widthIs((ScreenWidth - 10)/2)
    .heightIs(45);

}


- (void)drawView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    tableView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.chongBtn,1)
    .bottomSpaceToView(self.view,0);
    
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefersh)];
    tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefersh)];
}

-(void)headerRefersh {
    self.pageNo = 1;
     [self initDataWithStartTime:self.startStr endTime:self.endStr];
}

-(void)footerRefersh {
    self.pageNo ++;
     [self initDataWithStartTime:self.startStr endTime:self.endStr];
}

-(void)clcikchongBtn {
    self.chongBtn.selected = YES;
    self.xiaoBtn.selected = NO;
    self.chongBtn.backgroundColor = backviewColor1;
    self.xiaoBtn.backgroundColor = backviewColor;
    
    self.type = @"1";
    [self headerRefersh];
}

-(void)clcikxiaoBtn {
    self.chongBtn.selected = NO;
    self.xiaoBtn.selected = YES;
    self.chongBtn.backgroundColor = backviewColor;
    self.xiaoBtn.backgroundColor = backviewColor1;
    
    self.type = @"0";
    [self headerRefersh];
}

-(void)didClickRightBar {
    MyKaYuYueViewController *yuyueVC = [[MyKaYuYueViewController alloc]init];
    [self.navigationController pushViewController:yuyueVC animated:YES];
    
    @weakify(self);
    yuyueVC.didClickDateBlock = ^(NSDate *startDate,NSDate * endDate) {
       @strongify(self);
        
        self.startStr = [NSDate getZeroPointTimeIntervalWithDate:startDate];
        self.endStr = [NSDate getTwentyFourPointTimeIntervalWithDate:endDate];
        NSLog(@"----%ld---%ld",self.startStr, self.endStr);
        [self initDataWithStartTime:self.startStr endTime:self.endStr];
        [self.tableView reloadData];
    };
}


-(void)initDataWithStartTime:(long)startTime endTime:(long)endTime {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    if(startTime) {
        [params setValue:@(startTime) forKey:@"startCreateTime"];
    }
    if(endTime) {
        [params setValue:@(endTime) forKey:@"endCreateTime"];
    }
    [params setValue:[ModelMember sharedMemberMySelf].memberId forKey:@"card_id"];
    [params setValue:self.type forKey:@"in_or_out"];
    [params setValue:@(self.pageNo) forKey:@"pageNo"];
    [params setValue:@(20) forKey:@"pageSize"];
    
    [[LQHTTPSessionManager sharedManager] LQPost:@"customer/listCardHistorysByVipCardId" parameters:params showTips:@"" success:^(id responseObject) {
        
        [self.dataArray removeAllObjects];
        
        self.dataArray = [NSMutableArray arrayWithArray:[MyKaXinModel mj_objectArrayWithKeyValuesArray:[responseObject valueForKey:@"data"]]];
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
        
        if (self.dataArray.count < 20)
        {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
        
    } successBackfailError:^(id responseObject) {
        self.dataArray = [NSMutableArray array];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];

    } failure:^(NSError *error) {
         self.dataArray = [NSMutableArray array];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];

    }];

}


#pragma mark -
#pragma mark ================= <UITableViewDelegate,UITableViewDataSource> =================
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyKaXinCell *cell = [MyKaXinCell cellWithTableview:tableView];
    cell.model = self.dataArray[indexPath.row];
    return  cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}






-(UIView *)lineView {
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = HEXCOLOR(0x333333);
    return view;
}
-(UIView *)createBottonView {
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = HEXCOLOR(0x666666);
    return view;
}
-(UILabel *)LabelWithTitle:(NSString *)title Color:(UIColor *)color{
    UILabel *Label = [[UILabel alloc] init];
    Label.font = [UIFont systemFontOfSize:14];
    Label.textColor = color;
    Label.text = title;
    Label.textAlignment = NSTextAlignmentCenter;
    return Label;
}

-(UIButton *)ButtonWithTitle:(NSString *)title target:(id)targe action:(SEL)action {
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:HEXCOLOR(0x333333) forState:UIControlStateNormal];
    //[button setTitleColor:HEXCOLOR(0x0b56c2) forState:UIControlStateSelected];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    button.backgroundColor = backviewColor;
    [button addTarget:targe action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
