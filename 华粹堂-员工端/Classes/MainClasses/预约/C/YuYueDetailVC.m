//
//  YuYueDetailVC.m
//  华粹堂-员工端
//
//  Created by liqiang on 2016/11/14.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import "YuYueDetailVC.h"
#import "YuYueDetailCell.h"
#import "YuYueDetailCell_2.h"
#import "YuYueDetailCell_3.h"
#import "ModelHealthBooking.h"
#import "GuKeDetailVC.h"
#import "ModelGuKe.h"

@interface YuYueDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *cellsArray;

@property (nonatomic, strong) ModelHealthBooking *model;

@end

@implementation YuYueDetailVC

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
    
    self.navigationItem.title = @"预约详情";
    
    
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_messege"] style:UIBarButtonItemStylePlain target:self action:@selector(didClickRightBar)];
    self.navigationItem.rightBarButtonItem = rightBar;

    [self drawView];
    [self requestData];
    [self updataCells];
}

-(void)didClickRightBar {
    __weak typeof(self) weakSelf = self;
    LCActionSheet *sheet = [[LCActionSheet alloc] initWithTitle:nil buttonTitles:@[@"拨打电话",@"发送消息",@"发送短信"] redButtonIndex:-1 delegate:nil];
    sheet.didClickedButtonAtIndex = ^(NSInteger btnIndex,NSString *title){
        if (btnIndex == 0) {
            if(weakSelf.model.employeeTel.length) {
                NSString *num = [[NSString alloc]initWithFormat:@"telprompt://%@",weakSelf.model.employeeTel];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]];
            }
            NSLog(@"======%@",weakSelf.model.employeeTel);
        }else if (btnIndex == 1){
             NSLog(@"发消息");
            
            
            NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
            [params setValue:self.model.c_id forKey:@"customerId"];
            
            [[LQHTTPSessionManager sharedManager] LQPost:@"customer/getCustomer" parameters:params showTips:@"" success:^(id responseObject) {
                ModelGuKe *GukeModel = [ModelGuKe mj_objectWithKeyValues:responseObject];
                
                if (!GukeModel.imUserName.length) {
                    
                    [LCProgressHUD showFailure:@"当前客户不可聊天"];
                    return;
                }
                
                EaseMessageViewController *vc = [[EaseMessageViewController alloc] initWithConversationChatter:GukeModel.imUserName conversationType:EMConversationTypeChat];
                vc.navigationItem.title = GukeModel.name;
                vc.receiverMemberId = GukeModel.sid;
                vc.receiverPortrait = GukeModel.portrait;
                vc.receiverName = GukeModel.name;
                vc.receiverPhone = GukeModel.telephone;
                [self.navigationController pushViewController:vc animated:YES];
                
            } successBackfailError:^(id responseObject) {
                
            } failure:^(NSError *error) {
                
            }];
            
        }else if (btnIndex == 2){
            NSLog(@"发短信");
            if(self.model.employeeTel.length)
            {
                AppDelegate *del = APPDELEGATE;
                [del sendMessageWithPhone:self.model.employeeTel];
            }
        }
    };
    [sheet show];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)drawView
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
    .topSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,0);
    
//    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefersh)];
//    tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefersh)];
}

- (void)updataCells
{
    self.cellsArray = [NSMutableArray array];
    
    NSMutableArray *array1 = [NSMutableArray array];
    NSDictionary *dic = @{kCell:@"YuYueDetailCell"};
    [array1 addObject:dic];
    
    NSMutableArray *array2 = [NSMutableArray array];
//    NSDictionary *dic2_1 = @{kCell:@"YuYueDetailCell_2",kTitle:@"订单号：",kValue:@"201611110001"};
    NSDictionary *dic2_2 = @{kCell:@"YuYueDetailCell_2",kTitle:@"门店：",kValue:[ModelMember sharedMemberMySelf].shopName?[ModelMember sharedMemberMySelf].shopName:@""};
    NSDictionary *dic2_3 = @{kCell:@"YuYueDetailCell_2",kTitle:@"时间：",kValue:self.model.book_start_time?self.model.book_start_time:@""};
    NSDictionary *dic2_4 = @{kCell:@"YuYueDetailCell_2",kTitle:@"调理师：",kValue:[ModelMember sharedMemberMySelf].name?[ModelMember sharedMemberMySelf].name:@""};
    NSDictionary *dic2_5 = @{kCell:@"YuYueDetailCell_2",kTitle:@"备注：",kValue:self.model.remark?self.model.remark:@""};
    
//    [array2 addObject:dic2_1];
    [array2 addObject:dic2_2];
    [array2 addObject:dic2_3];
    [array2 addObject:dic2_4];
    [array2 addObject:dic2_5];
    
    NSMutableArray *array3 = [NSMutableArray array];
    NSDictionary *dic3_1 = @{kCell:@"YuYueDetailCell_3"};
    [array3 addObject:dic3_1];
    
    [self.cellsArray addObject:array1];
    [self.cellsArray addObject:array2];
    [self.cellsArray addObject:array3];
    
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark ================= 网络 =================
- (void)requestData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:self.healthbookingId forKey:@"healthbookingId"];
    
    [[LQHTTPSessionManager sharedManager] LQPost:@"healthBooking/getHealthBookingV2" parameters:params showTips:@"正在加载..." success:^(id responseObject) {
        
        self.model = [ModelHealthBooking mj_objectWithKeyValues:responseObject];
        [self updataCells];
        
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
}

/**
标记完成
 */
- (void)requestBookingToFinish
{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:self.healthbookingId forKey:@"healthBookingId"];
    
    [[LQHTTPSessionManager sharedManager] LQPost:@"healthBooking/bookingToFinish" parameters:params showTips:@"正在加载..." success:^(id responseObject) {
        
        ModelHealthBooking *bookModel = self.model;
        bookModel.state = @"1";
        bookModel.customerName = bookModel.name;
        bookModel.track_date = bookModel.book_start_time;
        bookModel.visit_time = bookModel.book_start_time;
        bookModel.e_id = bookModel.sid;
        
        bookModel.customerTel = bookModel.employeeTel;
        bookModel.customerMobilePhone = bookModel.employeeTel;
        
        NSMutableArray *tiaoliArr = [[NSMutableArray array]init];
        [tiaoliArr addObject:bookModel];
        [[DataManage sharedMemberMySelf] saveTiaoLiDataWithModelArray:tiaoliArr];
        [[DataManage sharedMemberMySelf] saveHuiFangDataWithModelArray:tiaoliArr];
        
        [self.navigationController popViewControllerAnimated:YES];
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark -
#pragma mark ================= <UITableViewDelegate,UITableViewDataSource> =================
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.cellsArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSMutableArray *array = self.cellsArray[section];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *array = self.cellsArray[indexPath.section];
    NSDictionary *dic = array[indexPath.row];
    
    if ([dic[kCell] isEqualToString:@"YuYueDetailCell"])
    {
        YuYueDetailCell *cell = [YuYueDetailCell cellWithTableView:tableView];
        cell.model = self.model;
        cell.block = ^() {
            NSString *num = [[NSString alloc]initWithFormat:@"telprompt://%@",self.model.mobile_phone];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]];
        };
        return cell;
    }
    if ([dic[kCell] isEqualToString:@"YuYueDetailCell_2"])
    {
        YuYueDetailCell_2 *cell = [YuYueDetailCell_2 cellWithTableView:tableView];
        cell.titleLabel.text = dic[kTitle];
        cell.contentLabel.text = dic[kValue];
        return cell;
    }
    if ([dic[kCell] isEqualToString:@"YuYueDetailCell_3"])
    {
        YuYueDetailCell_3 *cell = [YuYueDetailCell_3 cellWithTableView:tableView];
        return cell;
    }
    
    return [UITableViewCell new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *array = self.cellsArray[indexPath.section];
    NSDictionary *dic = array[indexPath.row];
    
    if ([dic[kCell] isEqualToString:@"YuYueDetailCell"])
    {
        return 90;
    }
    if ([dic[kCell] isEqualToString:@"YuYueDetailCell_2"])
    {
        return 45;
    }
    if ([dic[kCell] isEqualToString:@"YuYueDetailCell_3"])
    {
        return 65;
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *array = self.cellsArray[indexPath.section];
    NSDictionary *dic = array[indexPath.row];
    
    if ([dic[kCell] isEqualToString:@"YuYueDetailCell"]) {
        
        [self GukeData];
    
    }
    
    if ([dic[kCell] isEqualToString:@"YuYueDetailCell_3"])
    {
        [self requestBookingToFinish];
    }
}

-(void)GukeData {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:self.model.c_id forKey:@"customerId"];
    
    [[LQHTTPSessionManager sharedManager] LQPost:@"customer/getCustomer" parameters:params showTips:@"" success:^(id responseObject) {
        
        ModelGuKe *model = [ModelGuKe mj_objectWithKeyValues:responseObject];
        
        GuKeDetailVC *vc = [[GuKeDetailVC alloc]init];
        vc.model = model;
        [self.navigationController pushViewController:vc animated:YES];
        
        
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSError *error) {

    }];
}



@end
