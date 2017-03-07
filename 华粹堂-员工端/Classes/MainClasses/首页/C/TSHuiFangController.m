//
//  TSHuiFangController.m
//  华粹堂-员工端
//
//  Created by 唐硕 on 16/11/24.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import "TSHuiFangController.h"
#import "HuiFangCell.h"
#import "EditorHuiFangViewController.h"
#import "HuiFangModel.h"
#import "HuiFangBaoGaoController.h"
#import "EditorHuiFangController.h"

@interface TSHuiFangController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) UIButton *weiButton;
@property (nonatomic, weak) UIButton *shenButton;
@property (nonatomic, weak) UIButton *yiButton;
@property (nonatomic, weak) UIButton *quanButton;
@property (nonatomic, weak) UIView *lineView;
@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *ListArray;
@property (nonatomic, strong) NSString *state;

@end

@implementation TSHuiFangController

-(NSMutableArray *)dataArray {
    if(_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

-(NSMutableArray *)ListArray {
    if(_ListArray == nil) {
        _ListArray = [[NSMutableArray alloc]init];
    }
    return _ListArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"回访列表";
    
    [self initViews];
    [self drawViews];
    [self clcikWeiButton];
}

//-(void)initData {
//    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
//    [params setValue:[ModelMember sharedMemberMySelf].memberId forKey:@"employeeId"];
//    [params setValue:@(0) forKey:@"lastModified"];
//    
//    [[LQHTTPSessionManager sharedManager] LQPost:@"telephonevisit/listTelephonevisits" parameters:params showTips:@"加载中" success:^(id responseObject) {
//        NSArray *array = [HuiFangModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
//        [self.dataArray addObjectsFromArray:array];
//        
//    } successBackfailError:^(id responseObject) {
//        
//    } failure:^(NSError *error) {
//
//    }];
//}

-(void)headerRefersh {
    [self initDataArray];
}

-(void)footerRefersh {
    
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf.tableView.mj_footer endRefreshing];
        [weakSelf.tableView reloadData];
    });

}

-(void)initDataArray {
    
    [self.ListArray removeAllObjects];
    
    NSArray *array = [[DataManage sharedMemberMySelf] getHuiFangModelArray];
    if([self.state isEqualToString:@"4"]) {
        [self.ListArray addObjectsFromArray:array];
    }else {
        for(HuiFangModel *model in array) {
            if([model.state isEqualToString:self.state]) {
                [self.ListArray addObject:model];
            }
        }
    }
    
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    if (self.dataArray.count < 20){
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
    [self.tableView reloadData];

}


-(void)clcikWeiButton {
    self.weiButton.selected = YES;
    self.shenButton.selected = NO;
    self.yiButton.selected = NO;
    self.quanButton.selected = NO;
    
    self.lineView.x = CGRectGetMinX(self.weiButton.frame);
    
    self.state = @"1";
    [self headerRefersh];
}
-(void)clcikshenButton {
    self.weiButton.selected = NO;
    self.shenButton.selected = YES;
    self.yiButton.selected = NO;
    self.quanButton.selected = NO;
    
    self.lineView.x = CGRectGetMinX(self.shenButton.frame);
    
    self.state = @"2";
    [self headerRefersh];
}
-(void)clcikyiButton {
    self.weiButton.selected = NO;
    self.shenButton.selected = NO;
    self.yiButton.selected = YES;
    self.quanButton.selected = NO;
    
    self.lineView.x = CGRectGetMinX(self.yiButton.frame);
    
    self.state = @"3";
    [self headerRefersh];
}
-(void)clcikquanButton {
    self.weiButton.selected = NO;
    self.shenButton.selected = NO;
    self.yiButton.selected = NO;
    self.quanButton.selected = YES;
    
    self.lineView.x = CGRectGetMinX(self.quanButton.frame);
    
    self.state = @"4";
    [self headerRefersh];
}

#pragma mark - tableView 代理和数据源
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.ListArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HuiFangModel *model = self.ListArray[indexPath.section];
    HuiFangCell *cell = [HuiFangCell cellWithTableview:tableView];
    cell.model = model;
    cell.block = ^() {
        NSLog(@"点了电话 %@",model.customerTel);
        NSString *num = [[NSString alloc]initWithFormat:@"telprompt://%@",model.customerTel];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]];
    };
    cell.removeBlock = ^() {
        [[DataManage sharedMemberMySelf] deletHuiFangModelWithSid:model.sid];
        [self initDataArray];
        [self.tableView reloadData];
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"huifangreloadData" object:nil];
        
    };
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HuiFangModel *model = self.ListArray[indexPath.section];
    if([model.state isEqualToString:@"1"]) {
        EditorHuiFangViewController *edVC = [[EditorHuiFangViewController alloc]init];
        edVC.model = model;
        [self.navigationController pushViewController:edVC animated:YES];
    }
    if([model.state isEqualToString:@"2"]) {
        EditorHuiFangController *efVC = [[EditorHuiFangController alloc]init];
        efVC.model = model;
        [self.navigationController pushViewController:efVC animated:YES];
    }

    if([model.state isEqualToString:@"3"]) {
        HuiFangBaoGaoController *hfVC = [[HuiFangBaoGaoController alloc]init];
        hfVC.model = model;
        [self.navigationController pushViewController:hfVC animated:YES];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 6;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

-(void)drawViews {
    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableview.backgroundColor = backviewColor;
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableview];
    self.tableView = tableview;
    
    tableview.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,45).bottomSpaceToView(self.view,0);
    
    
    tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefersh)];
    tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefersh)];
    
}

-(void)initViews {
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 1, ScreenWidth, 45)];
    headerView.backgroundColor = backviewColor;
    [self.view addSubview:headerView];
    
    UIButton *weibutton = [self createButtonWithTitle:@"未填写" target:self action:@selector(clcikWeiButton)];
    weibutton.selected = YES;
    self.weiButton = weibutton;
    UIButton *shenButton = [self createButtonWithTitle:@"审核中" target:self action:@selector(clcikshenButton)];
    self.shenButton = shenButton;
    UIButton *yiButton = [self createButtonWithTitle:@"已审核" target:self action:@selector(clcikyiButton)];
    self.yiButton = yiButton;
    UIButton *quanButton = [self createButtonWithTitle:@"全部" target:self action:@selector(clcikquanButton)];
    self.quanButton = quanButton;
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor redColor];
    self.lineView = lineView;
    
    [headerView sd_addSubviews:@[weibutton, shenButton, yiButton, quanButton,lineView]];
    
    weibutton.sd_layout
    .leftSpaceToView(headerView,0)
    .topSpaceToView(headerView,0)
    .widthIs(ScreenWidth/4).heightIs(44);
    
    shenButton.sd_layout
    .leftSpaceToView(weibutton,0)
    .topSpaceToView(headerView,0)
    .widthIs(ScreenWidth/4).heightIs(44);
    
    yiButton.sd_layout
    .leftSpaceToView(shenButton,0)
    .topSpaceToView(headerView,0)
    .widthIs(ScreenWidth/4).heightIs(44);
    
    quanButton.sd_layout
    .leftSpaceToView(yiButton,0)
    .topSpaceToView(headerView,0)
    .widthIs(ScreenWidth/4).heightIs(44);
    
    lineView.sd_layout
    .leftSpaceToView(headerView,0)
    .bottomSpaceToView(headerView,0)
    .widthIs(ScreenWidth/4).heightIs(2);
    
}


-(UIButton *)createButtonWithTitle:(NSString *)title target:(id)targe action:(SEL)action {
    
    UIButton *button = [[UIButton alloc]init];
    button.titleLabel.font = TFont(13.0);
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
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
