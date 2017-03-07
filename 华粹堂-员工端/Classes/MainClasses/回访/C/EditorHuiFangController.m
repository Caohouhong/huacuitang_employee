//
//  EditorHuiFangController.m
//  华粹堂-员工端
//
//  Created by 唐硕 on 16/11/29.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import "EditorHuiFangController.h"
#import "EditorHuiFangCell.h"
#import "EditorHuiFangCell2.h"
#import "TheLabelViewController.h"
#import "MHDatePicker.h"
#import "UserDefalutModel.h"
#import "CommitTiaoLiSuccessVC.h"
#import "GuKeDetailVC.h"
#import "ModelGuKe.h"


@interface EditorHuiFangController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) UITableView *tableView;
@property (strong, nonatomic) MHDatePicker *selectDatePicker;
@property (nonatomic, strong) UserDefalutModel *Usermodel;
@end

@implementation EditorHuiFangController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"编辑回访报告";
    
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_messege"] style:UIBarButtonItemStylePlain target:self action:@selector(didClickRightBar)];
    self.navigationItem.rightBarButtonItem = rightBar;

    [self initData];
    [self initViews];
    [self footerViews];
}

-(void)initData {
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:self.model.sid forKey:@"telephonevisitId"];
    
    [[LQHTTPSessionManager sharedManager] LQPost:@"telephonevisit/getTelephonevisit" parameters:params showTips:@"" success:^(id responseObject) {
        //self.outModel = [ModelTrackOut mj_objectWithKeyValues:responseObject];
        
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
    
}



-(void)didClickRightBar {
    __weak typeof(self) weakSelf = self;
    LCActionSheet *sheet = [[LCActionSheet alloc] initWithTitle:nil buttonTitles:@[@"拨打电话",@"发送消息",@"发送短信"] redButtonIndex:-1 delegate:nil];
    sheet.didClickedButtonAtIndex = ^(NSInteger btnIndex,NSString *title){
        if (btnIndex == 0) {
        if(weakSelf.model.customerTel.length) {
            NSString *num = [[NSString alloc]initWithFormat:@"telprompt://%@",weakSelf.model.customerTel];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]];
        }
        NSLog(@"======%@",weakSelf.model.customerTel);
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
            if(self.model.customerTel.length)
            {
                AppDelegate *del = APPDELEGATE;
                [del sendMessageWithPhone:self.model.customerTel];
            }
        }
    };
    [sheet show];
    
}


-(void)initViews {
    
    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableview.backgroundColor = backviewColor;
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableview];
    self.tableView = tableview;
    
    tableview.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,0).bottomSpaceToView(self.view,50);
    
}

-(void)footerViews {
    UIView *footView = [[UIView alloc]init];
    [self.view addSubview:footView];
    
    footView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,0)
    .heightIs(50);
    
    UIButton *rightBtn = [self createButtonWithTitle:@"确认提交" target:self action:@selector(clickright)];
    [footView addSubview:rightBtn];

    
    rightBtn.sd_layout
    .rightSpaceToView(footView,20)
    .leftSpaceToView(footView,20)
    .centerYEqualToView(footView)
    .heightIs(35);
    
}

-(void)clickright {
    
    if(!self.model.feedback.length) {
        [LCProgressHUD showFailure:@"请输入回访目的"];
        return;
    }
    
    if(!self.model.remark.length) {
        [LCProgressHUD showFailure:@"请输入反馈"];
        return;
    }
    
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:self.model.sid forKey:@"telephonevisitId"];
    [params setValue:self.model.feedback forKey:@"feedback"];
    [params setValue:self.model.remark forKey:@"remark"];
    
    
    [[LQHTTPSessionManager sharedManager] LQPost:@"telephonevisit/modifyTelephonevisit" parameters:params showTips:@"" success:^(id responseObject) {
        
        HuiFangModel *huiModel = self.model;
        NSMutableArray *tiaoliArr = [[NSMutableArray array]init];
        [tiaoliArr addObject:huiModel];
        [[DataManage sharedMemberMySelf]saveHuiFangDataWithModelArray:tiaoliArr];
        
        CommitTiaoLiSuccessVC *comVC = [[CommitTiaoLiSuccessVC alloc]init];
        [self.navigationController pushViewController:comVC animated:YES];
        //[LCProgressHUD showSuccess:@"提交成功"];
        
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];

    
    
    
}

#pragma mark - tableView 代理和数据源
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WEAK(weakSelf)
    if(indexPath.section == 0) {
        EditorHuiFangCell *cell = [EditorHuiFangCell cellWithTableview:tableView];
        cell.model = self.model;
        cell.block = ^() {
            TheLabelViewController *theVC = [[TheLabelViewController alloc]init];
            theVC.c_id = self.model.c_id;
            [weakSelf.navigationController pushViewController:theVC animated:YES];
        };
        return cell;
    }
    EditorHuiFangCell2 *cell = [EditorHuiFangCell2 cellWithTableview:tableView];
    cell.model = self.model;
    cell.block = ^() {
        NSLog(@"......");
        _selectDatePicker = [[MHDatePicker alloc] init];
        _selectDatePicker.isBeforeTime = YES;
        _selectDatePicker.datePickerMode = UIDatePickerModeDate;
        
        __weak typeof(self) weakSelf = self;
        [_selectDatePicker didFinishSelectedDate:^(NSDate *selectedDate) {
            self.model.visit_time = [weakSelf dateStringWithDate:selectedDate DateFormat:@"yyyy年MM月dd日"];
            NSLog(@"---%@",[weakSelf dateStringWithDate:selectedDate DateFormat:@"yyyy年MM月dd日"]);
            [weakSelf.tableView reloadData];
        }];
    };
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
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

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0) {
        return 90;
    }
    return 350;
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

- (NSString *)dateStringWithDate:(NSDate *)date DateFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    NSString *str = [dateFormatter stringFromDate:date];
    return str ? str : @"";
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
