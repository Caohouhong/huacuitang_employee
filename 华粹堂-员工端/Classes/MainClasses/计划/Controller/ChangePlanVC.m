//
//  ChangePlanVC.m
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/27.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "ChangePlanVC.h"
#import "ChangePlaneTableViewCell.h"
#import "HuaCuiTangHelper.h"
#import "TiaoLiDetailView1.h"
#import "HCTConnet.h"

@interface ChangePlanVC ()<UITableViewDataSource, UITableViewDelegate>
{
    NSArray *nameArray;
    NSString *moneyStr;
}
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong)TiaoLiDetailView1 *footerView;
@property (nonatomic, strong) NSString *targetTitle;
@property (nonatomic, strong) NSString *nameStr; //修改时传入
@property (nonatomic, assign) int targetFlag; //1234

@end

@implementation ChangePlanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"明日计划";
    self.view.backgroundColor = COLOR_BackgroundColor;
    nameArray = @[@"时间:",@"目标:",@"姓名:",@"金额:"];
    [self viewWithData];
    [self drawView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWithData{
    NSString *taskType = self.model.task_type;
    self.targetFlag = (int)taskType;
    if ([taskType isEqualToString:@"1"]){
        self.targetTitle = @"销售";
    }else if ([taskType isEqualToString:@"2"]){
        self.targetTitle = @"铺垫";
    }else if ([taskType isEqualToString:@"3"]){
        self.targetTitle = @"学习";
    }else if ([taskType isEqualToString:@"0"]){
        self.targetTitle = @"服务";
    }else {
        self.targetTitle = @"";
    }
    
    moneyStr = self.model.target_money;
}


- (void)drawView
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    headerView.backgroundColor = COLOR_BackgroundColor;
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = COLOR_BackgroundColor;
    [self.view addSubview:bottomView];
    
    UIButton *markButton = [[UIButton alloc] init];
    [markButton setTitle:@"提交" forState:UIControlStateNormal];
    [markButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    markButton.titleLabel.font = SYSTEM_FONT_(15);
    markButton.backgroundColor = COLOR_Text_Blue;
    markButton.layer.cornerRadius = 4.0;
    [markButton addTarget:self action:@selector(markButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:markButton];
    
    bottomView.sd_layout
    .leftEqualToView(self.view)
    .bottomEqualToView(self.view)
    .widthRatioToView(self.view,1)
    .heightIs(60);
    
    markButton.sd_layout
    .leftSpaceToView(bottomView,15)
    .rightSpaceToView(bottomView,15)
    .bottomSpaceToView(bottomView,10)
    .topSpaceToView(bottomView,10);
    
    _footerView = [[TiaoLiDetailView1 alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
    _footerView.titleLabel.text = @"项目/切入点/学习内容";
    _footerView.titleLabel.font = SYSTEM_FONT_(15);
    _footerView.titleLabel.textColor = COLOR_Black;
    _footerView.topTextView.placeholder = @"请填写总体评价";
    _footerView.topTextView.text = self.model.target_content;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = COLOR_BackgroundColor;
    tableView.tableHeaderView = headerView;
    tableView.tableFooterView = _footerView;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    tableView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,60);
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return nameArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChangePlaneTableViewCell *cell = [ChangePlaneTableViewCell cellWithTableView:self.tableView];
    cell.leftLabel.text = nameArray[indexPath.row];
    
    switch (indexPath.row) {
        case 0: //时间
            cell.rightTextField.text = self.timeStr;
            cell.rightTextField.enabled = NO;
            break;
        case 1://目标
            cell.rightTextField.placeholder = @"请选择目标类型";
            cell.rightTextField.text = self.targetTitle;
            cell.rightTextField.enabled = NO;
            break;
        case 2: //姓名
            cell.rightTextField.text = self.model.target_customer;
            cell.rightTextField.enabled = NO;
            break;
        case 3: //金额
            cell.rightTextField.placeholder = @"请输入金额";
            cell.rightTextField.tag = 10000;
            cell.rightTextField.text = self.model.target_money;
            cell.rightTextField.keyboardType = UIKeyboardTypeNumberPad;
             [cell.rightTextField addTarget:self action:@selector(textFieldAction:) forControlEvents:UIControlEventAllEditingEvents];
            cell.rightTextField.enabled = YES;
            break;
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1){
        [self showSheet];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (void)showSheet{
     LCActionSheet *sheet = [[LCActionSheet alloc] initWithTitle:nil buttonTitles:@[@"服务",@"销售",@"铺垫",@"学习"] redButtonIndex:-1 delegate:nil];
    WEAK(weakSelf)
    sheet.didClickedButtonAtIndex = ^(NSInteger btnIndex,NSString *title){
        weakSelf.targetFlag = (int)btnIndex;
        weakSelf.targetTitle = title;
        [weakSelf.tableView reloadData];
    };
    [sheet show];
}

//改变时间格式
- (NSString *)changeDateStringStyleWith:(NSString *)dateString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    NSDate *date = [formatter dateFromString:dateString];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *newDateStr = [formatter stringFromDate:date];
    
    return newDateStr;
}


#pragma mark ============= 网络 =================
//修改员工计划
- (void)requestDataModifyDailyWork
{
    [LCProgressHUD showLoading:@"正在修改..."];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:self.model.sid forKey:@"daliyWorkId"];

    [params setValue:@(self.targetFlag) forKey:@"type"];
    [params setValue:self.footerView.topTextView.text forKey:@"content"];
    [params setValue:moneyStr forKey:@"money"];
    
    [HCTConnet getHomeModifyDailyWork:params success:^(id responseObject) {
        
        [LCProgressHUD showSuccess:@"修改成功"];
        [self.navigationController popViewControllerAnimated:YES];
        
    } successBackfailError:^(id responseObject) {
        [LCProgressHUD showFailure:@"修改失败"];
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}


- (void)textFieldAction:(UITextField *)textField{
    if (textField.tag == 10000){//金额
        moneyStr = textField.text;
    }
}

//提交
- (void)markButtonAction
{
    [self requestDataModifyDailyWork];
}

@end
