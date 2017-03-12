//
//  HighTechDetailVC.m
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/28.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "HighTechDetailVC.h"
#import "ChhYuYueTableViewCell.h"
#import "CheckDetailTableViewCell.h"
#import "HuaCuiTangHelper.h"
#import "NextAndLastDateView.h"
#import "TopSelectViewTwoBtnView.h"
#import "BackFourTableViewCell.h"
#import "AdviceTableViewCell.h"
#import "HCTConnet.h"
#import "JumpVC.h"
@interface HighTechDetailVC ()<UITableViewDelegate, UITableViewDataSource,NextAndLastDateViewDelegate,TopSelectViewTwoBtnViewDelegate>
{
    int dayNum;
    NSString *mBookTime;
    NSArray *logArray;
    NSArray *adviceArray;
    

    NSArray *baseArray;
    NSArray *mainArray;
    NSString *type;
    NSString *stac;
}
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NextAndLastDateView *topView;
@property (nonatomic, strong) TopSelectViewTwoBtnView *topSelectView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *totalArray;

@end

@implementation HighTechDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    type = @"1";
    stac = @"1";
    self.navigationItem.title = @"高科技跟踪";
    self.view.backgroundColor = COLOR_BackgroundColor;
    logArray = @[@[@"门店名称",@"顾客姓名"],@[@"调理方案"],@[@"调理项目"],@[@"调理说明"],@[@"客户综合反馈"]];
    adviceArray = @[@[@"院长审核意见"],@[@"专家审核意见"]];
   

    self.dataArray = [[NSMutableArray alloc] initWithArray:logArray];
    self.viewType = HighTechViewTypeLog;
    [self drawView];
    [self requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)drawView{
    
    [self initHeaderView];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    headerView.backgroundColor = COLOR_BackgroundColor;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = COLOR_BackgroundColor;
    tableView.tableHeaderView = headerView;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    tableView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,80)
    .bottomSpaceToView(self.view,0);
}

- (void)initHeaderView
{
    _topView = [[NextAndLastDateView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 35)];
    _topView.delegate = self;
    [_topView.nextBtn setTitle:@"下一条" forState:UIControlStateNormal];
    [_topView.lastBtn setTitle:@"上一条" forState:UIControlStateNormal];
    [self.view addSubview:self.topView];
    
    [self nowDateDay];
    
    UIView *dividerLine1 = [[UIView alloc] init];
    dividerLine1.backgroundColor = COLOR_LineViewColor;
    [self.view addSubview:dividerLine1];
    
    _topSelectView = [[TopSelectViewTwoBtnView alloc] initWithFrame:CGRectMake(0, 45, ScreenWidth, 35)];
    [_topSelectView.leftButton setTitle:@"服务日志" forState:UIControlStateNormal];
    [self.topSelectView.leftButton setTitleColor:COLOR_Text_Blue forState:UIControlStateNormal];
    [_topSelectView.rightButton setTitle:@"审核意见" forState:UIControlStateNormal];
    _topSelectView.delegate = self;
    [self.view addSubview:self.topSelectView];
    
    dividerLine1.sd_layout
    .leftSpaceToView(self.view,0)
    .topEqualToView(_topSelectView)
    .widthIs(ScreenWidth)
    .heightIs(1);
}

//获取本月年月日
- (void)nowDateDay{
    dayNum = 0;
    NSString *dateString = [HuaCuiTangHelper getPriousorLaterDateFromNowWithDay:dayNum];
    self.topView.dataLabel.text = dateString;
    
    mBookTime = [self changeDateStringStyleWith:dateString];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = self.dataArray[section];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.viewType == HighTechViewTypeLog){
        if (indexPath.section == 1 || indexPath.section == 2 || indexPath.section == 3 ){
            
            CheckDetailTableViewCell *cell = [CheckDetailTableViewCell cellWithTableView:self.tableView];
            
            cell.leftLabel.text = self.dataArray[indexPath.section][indexPath.row];
            DLog(@"11111111111111111%@",cell.leftLabel.text);
            if ([cell.leftLabel.text isEqualToString:@"调理方案"]) {
                cell.bottomLabel.text = [self judgeString:self.model.d_program_detail];
            }
            if ([cell.leftLabel.text isEqualToString:@"调理项目"]) {
                cell.bottomLabel.text = [self judgeString:self.model.dialectics_program];
            }
            if ([cell.leftLabel.text isEqualToString:@"调理说明"]) {
                cell.bottomLabel.text = [self judgeString:self.model.other_description];
            }
            
            return cell;
        }else  if (indexPath.section == 0){
            ChhYuYueTableViewCell *cell = [ChhYuYueTableViewCell cellWithTableView:self.tableView];
           
            
//            cell.leftLabel.attributedText = [HuaCuiTangHelper changeTextColorWithRestltStr:[NSString stringWithFormat:@"%@:  %@",self.dataArray[indexPath.section][indexPath.row],self.totalArray[indexPath.section][indexPath.row]] changeText:self.totalArray[indexPath.section][indexPath.row] andColor:COLOR_Gray];
            if (indexPath.row == 0) {
                NSString *str = @"门店名称";
                cell.leftLabel.attributedText = [HuaCuiTangHelper changeTextColorWithRestltStr:[NSString stringWithFormat:@"%@:  %@",str,self.model.shopName] changeText:self.model.shopName andColor:COLOR_Gray];
            }else{
                NSString *str = @"顾客姓名";
                cell.leftLabel.attributedText = [HuaCuiTangHelper changeTextColorWithRestltStr:[NSString stringWithFormat:@"%@:  %@",str,self.model.customerName] changeText:self.model.customerName andColor:COLOR_Gray];
            }
            DLog(@"2222222222222222%@",cell.leftLabel.text);
            return cell;
        }else {
            BackFourTableViewCell *cell = [BackFourTableViewCell cellWithTableView:self.tableView];
            
            cell.titleLabel.text = self.dataArray[indexPath.section][indexPath.row];
            DLog(@"3333333333333%@",cell.titleLabel.text);
            NSString *fuck = self.model.con_eva;
            if ([fuck isEqualToString:@"不太满意"]) {
                cell.adviceBtn0.layer.borderColor = COLOR_Text_Blue.CGColor;
                [cell.adviceBtn0 setTitleColor:COLOR_TEXT_DARK_BLUE forState:UIControlStateNormal];
                [cell.adviceBtn0 setBackgroundColor:COLOR_BG_DARK_BLUE];
            }
            
            if ([fuck isEqualToString:@"一般"]) {
                cell.adviceBtn1.layer.borderColor = COLOR_Text_Blue.CGColor;
                
                [cell.adviceBtn1 setTitleColor:COLOR_TEXT_DARK_BLUE forState:UIControlStateNormal];
                [cell.adviceBtn1 setBackgroundColor:COLOR_BG_DARK_BLUE];
            }
            if ([fuck isEqualToString:@"较满意"]) {
                cell.adviceBtn2.layer.borderColor = COLOR_Text_Blue.CGColor;
                
                [cell.adviceBtn2 setTitleColor:COLOR_TEXT_DARK_BLUE forState:UIControlStateNormal];
                [cell.adviceBtn2 setBackgroundColor:COLOR_BG_DARK_BLUE];
            }
            if ([fuck isEqualToString:@"很满意"]) {
                cell.adviceBtn3.layer.borderColor = COLOR_Text_Blue.CGColor;
                
                [cell.adviceBtn3 setTitleColor:COLOR_TEXT_DARK_BLUE forState:UIControlStateNormal];
                [cell.adviceBtn3 setBackgroundColor:COLOR_BG_DARK_BLUE];
            }
            return cell;
        }

    }else{
        AdviceTableViewCell *cell = [AdviceTableViewCell cellWithTableView:self.tableView];
        
        cell.titleLabel.text = self.dataArray[indexPath.section][indexPath.row];
        DLog(@"4444444444444444%@",cell.titleLabel.text);
        if ([cell.titleLabel.text isEqualToString:@"院长审核意见"]) {
            cell.topTextView.text = [self judgeString:self.model.dean_check_view];
            cell.timeLabel.text = [self judgeString:self.model.dean_check_date];
            cell.nameLabel.text = [self judgeString:self.model.dean_name];
        }
        if ([cell.titleLabel.text isEqualToString:@"专家审核意见"]) {
            cell.topTextView.text = [self judgeString:self.model.expert_check_view];
            cell.timeLabel.text = [self judgeString:self.model.expert_check_date];
            cell.nameLabel.text = [self judgeString:self.model.expert_name];
            
        }

        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.viewType == HighTechViewTypeLog)
    {
       if (indexPath.section == 1 || indexPath.section == 2 || indexPath.section == 3 ){
        return 90;
       }else if (indexPath.section == 0){
        return 40;
       }else {
        return 80;
       }
    }else {
        return 130;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    footerView.backgroundColor = COLOR_BackgroundColor;
    
    return footerView;
}

#pragma mark NextAndLastDateViewDelegate 上一天下一天
- (void)nextAndLastDateBtnClickWithTag:(NextAndLastDateViewButtonType)tag
{
    switch (tag) {
        case NextAndLastDateViewButtonTypeLast:
        {
            dayNum--;
             type = @"1";
        }
            break;
        case NextAndLastDateViewButtonTypeNext:
        {
            dayNum++;
             type = @"0";
        }
            break;
    }
    
    NSString *dateString = [HuaCuiTangHelper getPriousorLaterDateFromNowWithDay:dayNum];
    self.topView.dataLabel.text = dateString;
    
    mBookTime = [self changeDateStringStyleWith:dateString];
    //show hud
        [LCProgressHUD showLoading:@"正在加载..."];
        [self requestData];
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

#pragma mark - TopSelectViewDelegate 顶部按钮代理
- (void)topButtonClickWithTag:(TopSelectViewTwoBtnViewType)tag
{
    [self.dataArray removeAllObjects];
    [self.totalArray removeAllObjects];
    [self.topSelectView.leftButton setTitleColor:COLOR_darkGray forState:UIControlStateNormal];
    [self.topSelectView.rightButton setTitleColor:COLOR_darkGray forState:UIControlStateNormal];
    
    switch (tag) {
        case TopSelectViewTwoBtnViewTypeLeft:
        {
            stac = @"1";
            [self.topSelectView.leftButton setTitleColor:COLOR_Text_Blue forState:UIControlStateNormal];
            [self.dataArray addObjectsFromArray:logArray];
            [self.totalArray addObject:baseArray];
            self.viewType = HighTechViewTypeLog;
        }
            break;
            
        case TopSelectViewTwoBtnViewTypeRight:
        {
            stac = @"2";
            
            [self.topSelectView.rightButton setTitleColor:COLOR_Text_Blue forState:UIControlStateNormal];
            [self.dataArray addObjectsFromArray:adviceArray];
            [self.totalArray addObject:mainArray];
            self.viewType = HighTechViewTypeAdvice;
        }
            break;
        default:
            break;
    }
    //刷新
    [self.tableView reloadData];
}

#pragma mark - ====网络====
- (void)requestData
{
    [LCProgressHUD showLoading:@"正在加载..."];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:self.YongHuId forKey:@"c_id"];
    [params setValue:type forKey:@"type"];
    [params setValue:@"4" forKey:@"trackTyp"];
    [params setValue:mBookTime forKey:@"dataTime"];
    DLog(@"$$$$$$$$$$$$$$$$$$$%@",params);
    [HCTConnet getHighTechD2:params success:^(id responseObject) {
        self.model = [HighTechDetailModel mj_objectWithKeyValues:responseObject];
         baseArray = @[@[[self judgeString:self.model.shopName],[self judgeString:self.model.customerName]],@[[self judgeString:self.model.d_program_detail]],@[[self judgeString:self.model.dialectics_program]],@[[self judgeString:self.model.other_description]],@[[self judgeString:self.model.con_eva]]];
        
        baseArray = @[@[[self judgeString:self.model.shopName],[self judgeString:self.model.customerName]],@[[self judgeString:self.model.d_program_detail]],@[[self judgeString:self.model.dialectics_program]],@[[self judgeString:self.model.other_description]],@[[self judgeString:self.model.con_eva]]];
        mainArray = @[@[[self judgeString:self.model.dean_check_view]],@[[self judgeString:self.model.expert_check_view]]];
        
        self.totalArray = [[NSMutableArray alloc]initWithArray:baseArray];
        DLog(@"%@",_totalArray);
        [self.tableView reloadData];
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     if (self.viewType == HighTechViewTypeLog){
         if (indexPath.section == 1) {
             JumpVC *vc = [[JumpVC alloc]init];
             vc.titlel = @"调理方案";
             vc.content = self.model.d_program_detail;
             vc.hidesBottomBarWhenPushed = YES;
             [self.navigationController pushViewController:vc animated:YES];
         }
         if (indexPath.section == 2) {
             JumpVC *vc = [[JumpVC alloc]init];
             vc.titlel = @"调理项目";
             vc.content = self.model.dialectics_program;
             vc.hidesBottomBarWhenPushed = YES;
             [self.navigationController pushViewController:vc animated:YES];
         }
         if (indexPath.section == 3) {
             JumpVC *vc = [[JumpVC alloc]init];
             vc.titlel = @"调理说明";
             vc.content = self.model.other_description;
             vc.hidesBottomBarWhenPushed = YES;
             [self.navigationController pushViewController:vc animated:YES];
         }
     }
    
    
}

- (NSString *)judgeString:(id)str{
    NSString *result = str?str:@"无";
    return result;
}
@end
