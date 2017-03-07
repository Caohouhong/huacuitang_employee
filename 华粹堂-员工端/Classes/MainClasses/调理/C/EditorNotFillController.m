//
//  EditorNotFillController.m
//  华粹堂-员工端
//
//  Created by 唐硕 on 16/11/29.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import "EditorNotFillController.h"
#import "BianJiTiaoLiCell_1.h"
#import "TheLabelViewController.h"
#import "EditorTiaoLiCell.h"
#import "ToViewViewController.h"
#import "CommitTiaoLiSuccessVC.h"
#import "ModelTrackOut.h"
#import "ModelGuKe.h"
#import "GuKeDetailVC.h"

@interface EditorNotFillController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) ModelTrackOut *outModel;
@end

@implementation EditorNotFillController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"编辑调理报告";
    
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_messege"] style:UIBarButtonItemStylePlain target:self action:@selector(didClickRightBar)];
    self.navigationItem.rightBarButtonItem = rightBar;
    
    //[self initData];
    [self initViews];
    [self initFooterView];
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

-(void)didClickRightBar {
    __weak typeof(self) weakSelf = self;
    LCActionSheet *sheet = [[LCActionSheet alloc] initWithTitle:nil buttonTitles:@[@"拨打电话",@"发送消息",@"发送短信"] redButtonIndex:-1 delegate:nil];
    sheet.didClickedButtonAtIndex = ^(NSInteger btnIndex,NSString *title){
        if (btnIndex == 0) {
            if(weakSelf.model.customerMobilePhone.length) {
                NSString *num = [[NSString alloc]initWithFormat:@"telprompt://%@",weakSelf.model.customerMobilePhone];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]];
            }
            NSLog(@"======%@",weakSelf.model.customerMobilePhone);
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
            if(self.model.customerMobilePhone.length)
            {
                AppDelegate *del = APPDELEGATE;
                [del sendMessageWithPhone:self.model.customerMobilePhone];
            }
        }
    };
    [sheet show];
    
}

-(void)initViews {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    tableView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,50);
    
}

-(void)initFooterView {
    UIView *footerView = [[UIView alloc]init];
    footerView.backgroundColor = backviewColor;
    [self.view addSubview:footerView];
    
    footerView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,0)
    .heightIs(50);
    
    UIButton *leftBtn = [self createButtonWithTitle:@"保存草稿" target:self action:@selector(clickLeft)];
    [footerView addSubview:leftBtn];
    UIButton *rightBtn = [self createButtonWithTitle:@"确认提交" target:self action:@selector(clickright)];
    [footerView addSubview:rightBtn];
    
    leftBtn.sd_layout
    .leftSpaceToView(footerView,20)
    .centerYEqualToView(footerView)
    .widthIs(100).heightIs(35);
    
    rightBtn.sd_layout
    .rightSpaceToView(footerView,20)
    .centerYEqualToView(footerView)
    .widthIs(100).heightIs(35);
}

-(void)clickLeft {
    
    ModelTrackManage *ManageModel = self.model;
    NSMutableArray *tiaoliArr = [[NSMutableArray array]init];
    [tiaoliArr addObject:ManageModel];
    [[DataManage sharedMemberMySelf] saveTiaoLiDataWithModelArray:tiaoliArr];
    
    [LCProgressHUD showSuccess:@"保存成功"];
}

-(void)clickright {
   
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuidStrRef= CFUUIDCreateString(NULL, uuidRef);
    CFRelease(uuidRef);
    NSString *retStr = [NSString stringWithString:(__bridge NSString *)uuidStrRef];
    CFRelease(uuidStrRef);
    
    self.model.uuid = retStr;
    
    if(!self.model.con_eva.length) {
        [LCProgressHUD showFailure:@"请选择客户综合反馈"];
        return;
    }
    if(!self.model.con_home_heal.length) {
         [LCProgressHUD showFailure:@"家居养生落实反馈"];
        return;
    }
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:@"0" forKey:@"type"];
    [params setValue:self.model.c_id forKey:@"c_id"]; //1
    [params setValue:self.model.e_id forKey:@"e_id"];
    [params setValue:self.model.s_id forKey:@"s_id"]; //1  调理标识
    [params setValue:@((int)self.model.track_date) forKey:@"track_date"]; //1 调理日期
    [params setValue:self.model.uuid forKey:@"uuid"];
    [params setValue:self.model.con_home_heal forKey:@"con_home_heal"]; 
    [params setValue:self.model.con_eva forKey:@"con_eva"];
    if(self.model.dialectics_program.length) { //调理项目
        [params setValue:self.model.dialectics_program forKey:@"dialectics_program"];
    }
    if(self.model.other_description.length) { //调理说明
        [params setValue:self.model.other_description forKey:@"other_description"];
    }
    if(self.model.home_health_req.length) {  //家居养生落实情况
        [params setValue:self.model.home_health_req forKey:@"home_health_req"];
    }
    [[LQHTTPSessionManager sharedManager] LQPost:@"trackManage/submitTrackManage" parameters:params showTips:@"提交中" success:^(id responseObject) {
        
        ModelTrackManage *ManageModel = [ModelTrackManage mj_objectWithKeyValues:responseObject];
        NSMutableArray *tiaoliArr = [[NSMutableArray array]init];
        [tiaoliArr addObject:ManageModel];
        [[DataManage sharedMemberMySelf] saveTiaoLiDataWithModelArray:tiaoliArr];
        
        
        [[DataManage sharedMemberMySelf]deleteModelTrackManageWithSid:self.model.sid];
        
        
        CommitTiaoLiSuccessVC *comVC = [[CommitTiaoLiSuccessVC alloc]init];
        [self.navigationController pushViewController:comVC animated:YES];
        
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
}


#pragma mark -
#pragma mark ================= <UITableViewDelegate,UITableViewDataSource> =================
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
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
        EditorTiaoLiCell *cell = [EditorTiaoLiCell cellWithTableview:tableView];
        cell.model = self.model;
        WEAK(weakSelf)
        cell.block = ^() {
            ToViewViewController *toVC = [[ToViewViewController alloc]init];
            toVC.M_id = self.model.c_id;
            [weakSelf.navigationController pushViewController:toVC animated:YES];
        };
        return cell;
    }
    return [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0) {
        [self GukeData];
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


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 90;
    }
    if (indexPath.section == 1) {
        return 470;
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
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(UIButton *)createButtonWithTitle:(NSString *)title target:(id)targe action:(SEL)action {
    
    UIButton *button = [[UIButton alloc]init];
    button.titleLabel.font = TFont(15);
    button.backgroundColor = [UIColor redColor];
    button.layer.cornerRadius = 5.0;
    [button setTitle:title forState:UIControlStateNormal];
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
