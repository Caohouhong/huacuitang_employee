//
//  BianJiTiaoLiVC.m
//  华粹堂-员工端
//
//  Created by liqiang on 2016/11/16.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import "BianJiTiaoLiVC.h"
#import "BianJiTiaoLiCell_1.h"
#import "BianJiTiaoLiCell_2.h"
#import "BianJiTiaoLiCell_3.h"
#import "BianJiTiaoLiCell_4.h"
#import "BianJiTiaoLiCell_5.h"
#import "CommitTiaoLiSuccessVC.h"
#import "ToViewViewController.h"
#import "TheLabelViewController.h"
#import "ModelTrackOut.h"
#import "ModelGuKe.h"
#import "GuKeDetailVC.h"

@interface BianJiTiaoLiVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) ModelTrackOut *outModel;
@end

@implementation BianJiTiaoLiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"调理报告";
    
    [self initData];
    [self setNav];
    [self drawView];
}

-(void)initData {
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:self.model.sid forKey:@"trackManageId"];
    
    [[LQHTTPSessionManager sharedManager] LQPost:@"trackManage/getTrackManage" parameters:params showTips:@"" success:^(id responseObject) {
        self.outModel = [ModelTrackOut mj_objectWithKeyValues:responseObject];

    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
    
}


-(void)setNav {
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_messege"] style:UIBarButtonItemStylePlain target:self action:@selector(didClickRightBar)];
    self.navigationItem.rightBarButtonItem = rightBar;
}

- (void)drawView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    //    tableView.tableFooterView = [self drawFooterView];
    [self.view addSubview:tableView];
    
    tableView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,0);
}

-(void)didClickRightBar {
    __weak typeof(self) weakSelf = self;
    LCActionSheet *sheet = [[LCActionSheet alloc] initWithTitle:nil buttonTitles:@[@"拨打电话",@"发送消息",@"发送短信"] redButtonIndex:-1 delegate:nil];
    sheet.didClickedButtonAtIndex = ^(NSInteger btnIndex,NSString *title){
        if (btnIndex == 0) {
            if(weakSelf.outModel.customerMobilePhone.length) {
                NSString *num = [[NSString alloc]initWithFormat:@"telprompt://%@",weakSelf.outModel.customerMobilePhone];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]];
            }
            NSLog(@"======%@",weakSelf.outModel.customerMobilePhone);
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
            if(self.outModel.customerMobilePhone.length)
            {
                AppDelegate *del = APPDELEGATE;
                [del sendMessageWithPhone:self.outModel.customerMobilePhone];
            }
        }
    };
    [sheet show];
    
}

-(void)phone {
    NSString *num = [[NSString alloc]initWithFormat:@"telprompt://%@",@"18800540369"];
    //而这个方法则打电话前先弹框 是否打电话 然后打完电话之后回到程序中 网上说这个方法可能不合法 无法通过审核
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]];
}

#pragma mark -
#pragma mark ================= <UITableViewDelegate,UITableViewDataSource> =================
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        BianJiTiaoLiCell_1 *cell = [BianJiTiaoLiCell_1 cellWithTableView:tableView];
        cell.model = self.model;
        WEAK(weakSelf)
        cell.BQblock = ^() {
            TheLabelViewController *theVC = [[TheLabelViewController alloc]init];
            theVC.c_id = self.model.c_id;
            [weakSelf.navigationController pushViewController:theVC animated:YES];
        };
        return cell;
    }
    if (indexPath.section == 1) {
        BianJiTiaoLiCell_2 *cell = [BianJiTiaoLiCell_2 cellWithTableView:tableView];
        return cell;
    }
    if (indexPath.section == 2) {
        BianJiTiaoLiCell_3 *cell = [BianJiTiaoLiCell_3 cellWithTableView:tableView];
        cell.model = self.model;
        return cell;
    }
    if (indexPath.section == 3) {
        BianJiTiaoLiCell_4 *cell = [BianJiTiaoLiCell_4 cellWithTableView:tableView];
        cell.model = self.model;
        return cell;
    }
    if (indexPath.section == 4) {
        BianJiTiaoLiCell_5 *cell = [BianJiTiaoLiCell_5 cellWithTableView:tableView];
        cell.model = self.model;
        return cell;
    }
    
    return [UITableViewCell new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 90;
    }
    if (indexPath.section == 1) {
        return 40;
    }
    if (indexPath.section == 2) {
        return 440;
    }
    if (indexPath.section == 3) {
        return 195;
    }
    if (indexPath.section == 4) {
        return 195;
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 10;
    }
    if (section == 1) {
        return 5;
    }
    if (section == 3) {
        return 5;
    }
    if (section == 4) {
        return 5;
    }
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0) {
        [self GukeData];
    }
    
    if (indexPath.section == 1) {
        ToViewViewController *toVC = [[ToViewViewController alloc]init];
        toVC.M_id = self.model.c_id;
        [self.navigationController pushViewController:toVC animated:YES];
    }
    
    if (indexPath.section == 4) {
        CommitTiaoLiSuccessVC *vc = [[CommitTiaoLiSuccessVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
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
