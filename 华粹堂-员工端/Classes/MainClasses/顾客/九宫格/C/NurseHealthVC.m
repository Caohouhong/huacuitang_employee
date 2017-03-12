//
//  NurseHealthVC.m
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/28.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "NurseHealthVC.h"
#import "ChhYuYueTableViewCell.h"
#import "CheckDetailTableViewCell.h"
#import "HuaCuiTangHelper.h"
#import "NextAndLastDateView.h"
#import "TopSelectViewTwoBtnView.h"
#import "BackFourTableViewCell.h"
#import "AdviceTableViewCell.h"
#import "TopSelectView.h"
#import "BackFiveTableViewCell.h"
#import "BackFourTableViewCell.h"
#import "HCTConnet.h"
#import "JumpVC.h"
@interface NurseHealthVC ()<UITableViewDelegate, UITableViewDataSource,NextAndLastDateViewDelegate,TopSelectViewDelegate>
{
    int dayNum;
    NSString *mBookTime;
    NSArray *logArray;
    NSArray *lifeArray;
    NSArray *adviceArray;
    NSString *type;
    NSArray *basicInformationArr;
    NSArray *mianInformation;
    NSArray *indexInformation;
    NSString *str0;
    NSString *str1;
    NSString *str2;
    NSString *str3;
    NSString *str4;
    NSString *str5;
    NSString *str6;
    NSString *str7;
    NSString *str8;
    NSString *str9;
}
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NextAndLastDateView *topView;
@property (nonatomic, strong) TopSelectView *topSelectView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *totalArray;

@property (nonatomic, copy) NSString *statc;
@end

@implementation NurseHealthVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"调理备忘";
    type = @"1";
    self.view.backgroundColor = COLOR_BackgroundColor;
    logArray = @[@[@"调理方案"],@[@"调理项目"],@[@"到店理疗配合情况"],@[@"客户综合反馈"],@[@"院长审核意见",@"专家审核意见"]];
    lifeArray = @[@[@"家居养生方案"],@[@"1、药膳食疗"],@[@"2、睡眠作息"],@[@"3、家居理疗"],@[@"4、验方茶疗"],@[@"5、养元功法"],@[@"6、情志调理"],@[@"7、营养疗法"],@[@"8、配合用药建议"],@[@"总体评价"]];
    adviceArray = @[@[@"院长审核意见"],@[@"专家审核意见"]];
    
    self.dataArray = [[NSMutableArray alloc] initWithArray:logArray];
    self.viewType = NurseHealthViewTypeLog;
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
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
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
    
    _topSelectView = [[TopSelectView alloc] initWithFrame:CGRectMake(0, 45, ScreenWidth, 35)];
    [_topSelectView.leftButton setTitle:@"服务日志" forState:UIControlStateNormal];
    [self.topSelectView.leftButton setTitleColor:COLOR_Text_Blue forState:UIControlStateNormal];
    [_topSelectView.centerButton setTitle:@"家居养生" forState:UIControlStateNormal];
    [_topSelectView.rightButton setTitle:@"审核意见" forState:UIControlStateNormal];
    _topSelectView.markView.hidden = YES;
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
    if (self.viewType == NurseHealthViewTypeLog){
        
        if (indexPath.section == 0){
            
            ChhYuYueTableViewCell *cell = [ChhYuYueTableViewCell cellWithTableView:self.tableView];
            
            cell.leftLabel.text = self.dataArray[indexPath.section][indexPath.row];;
            cell.rightLabel.text = @"查看";
            cell.rightLabel.textColor = COLOR_Text_Blue;
            
            
            
            return cell;
        }else if (indexPath.section == 2){
            BackFiveTableViewCell *cell = [BackFiveTableViewCell cellWithTableView:self.tableView];
            
            NSString *s = [self judgeString:self.model.con_home_heal];
            s = [NSString stringWithFormat:@"得分：%@",s];
            cell.rightLabel.text = s;
            cell.titleLabel.text = self.dataArray[indexPath.section][indexPath.row];
            NSString *fuck = self.model.con_home_heal;
            if ([fuck isEqualToString:@"-100"]) {
                cell.adviceBtn1.layer.borderColor = COLOR_Text_Blue.CGColor;
                
                [cell.adviceBtn1 setTitleColor:COLOR_TEXT_DARK_BLUE forState:UIControlStateNormal];
                [cell.adviceBtn1 setBackgroundColor:COLOR_BG_DARK_BLUE];
            }
            if ([fuck isEqualToString:@"0"]) {
                cell.adviceBtn2.layer.borderColor = COLOR_Text_Blue.CGColor;
                
                [cell.adviceBtn2 setTitleColor:COLOR_TEXT_DARK_BLUE forState:UIControlStateNormal];
                [cell.adviceBtn2 setBackgroundColor:COLOR_BG_DARK_BLUE];
            }
            if ([fuck isEqualToString:@"60"]) {
                cell.adviceBtn3.layer.borderColor = COLOR_Text_Blue.CGColor;
                
                [cell.adviceBtn3 setTitleColor:COLOR_TEXT_DARK_BLUE forState:UIControlStateNormal];
                [cell.adviceBtn3 setBackgroundColor:COLOR_BG_DARK_BLUE];
            }
            if ([fuck isEqualToString:@"100"]) {
                cell.adviceBtn4.layer.borderColor = COLOR_Text_Blue.CGColor;
                [cell.adviceBtn4 setTitleColor:COLOR_TEXT_DARK_BLUE forState:UIControlStateNormal];
                [cell.adviceBtn4 setBackgroundColor:COLOR_BG_DARK_BLUE];
            }
//            if (fuck == nil) {
//                cell.adviceBtn0.layer.borderColor = COLOR_Text_Blue.CGColor;
//                
//                [cell.adviceBtn0 setTitleColor:COLOR_TEXT_DARK_BLUE forState:UIControlStateNormal];
//                [cell.adviceBtn0 setBackgroundColor:COLOR_BG_DARK_BLUE];
//            }
            return cell;
            
        }else if (indexPath.section == 3){
            BackFourTableViewCell *cell = [BackFourTableViewCell cellWithTableView:self.tableView];
            
            cell.titleLabel.text = self.dataArray[indexPath.section][indexPath.row];
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
        }else {
            
            AdviceTableViewCell *cell = [AdviceTableViewCell cellWithTableView:self.tableView];
            
            cell.titleLabel.text = self.dataArray[indexPath.section][indexPath.row];
            DLog(@"!!!!!!!!!!!!!!!!%@",cell.titleLabel.text);
            if ([cell.titleLabel.text isEqualToString:@"调理项目"]) {
                cell.topTextView.text = [self judgeString:self.model.dialectics_program];
                cell.timeLabel.text = [self judgeString:self.model.track_date];
                
            }
            
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
        
    }else if (self.viewType == NurseHealthViewTypeAdvice){
        
        AdviceTableViewCell *cell = [AdviceTableViewCell cellWithTableView:self.tableView];
        
        cell.titleLabel.text = self.dataArray[indexPath.section][indexPath.row];
        if ([cell.titleLabel.text isEqualToString:@"院长审核意见"]) {
            cell.topTextView.text = [self judgeString:self.model.dean_check_view];
            cell.timeLabel.text = [self judgeString:self.model.dean_check_date];
            cell.nameLabel.text = [self judgeString:self.model.dean_name];
        }
        if ([cell.titleLabel.text isEqualToString:@"专家审核意见"]) {
            cell.topTextView.text = [self judgeString:self.model.expert_check_view];
            cell.timeLabel.text = [self judgeString:self.model.expert_check_view];
            cell.nameLabel.text = [self judgeString:self.model.expert_name];
            
        }
        return cell;
    }else {
        
        if (indexPath.section == 0){
            ChhYuYueTableViewCell *cell = [ChhYuYueTableViewCell cellWithTableView:self.tableView];
            cell.leftLabel.text = self.dataArray[indexPath.section][indexPath.row];
            cell.rightLabel.text = @"查看";
            cell.rightLabel.textColor = COLOR_Text_Blue;
            //家居养生
            
            
            return cell;
        }else if (indexPath.section == self.dataArray.count - 1)
        {
            AdviceTableViewCell *cell = [AdviceTableViewCell cellWithTableView:self.tableView];
            
            cell.titleLabel.text = self.dataArray[indexPath.section][indexPath.row];
            cell.nameLabel.text = @"";
            cell.timeLabel.text = @"";
            
            return cell;
            
        }else {
            BackFiveTableViewCell *cell = [BackFiveTableViewCell cellWithTableView:self.tableView];
            cell.titleLabel.text = self.dataArray[indexPath.section][indexPath.row];
           // cell.rightLabel.text = @"得分：80";
            DLog(@"gkgkgkgkgkggkgkggkgkgkgkk%@",cell.titleLabel.text);
            if ([cell.titleLabel.text isEqualToString:@"1、药膳食疗"]) {
                cell.rightLabel.text = str0;
                if ([cell.rightLabel.text isEqualToString:@"无效"]) {
                    cell.adviceBtn0.layer.borderColor = COLOR_Text_Blue.CGColor;
                    [cell.adviceBtn0 setTitleColor:COLOR_TEXT_DARK_BLUE forState:UIControlStateNormal];
                    [cell.adviceBtn0 setBackgroundColor:COLOR_BG_DARK_BLUE];
                }
                if ([cell.rightLabel.text isEqualToString:@"-100"]) {
                    cell.adviceBtn1.layer.borderColor = COLOR_Text_Blue.CGColor;
                    [cell.adviceBtn1 setTitleColor:COLOR_TEXT_DARK_BLUE forState:UIControlStateNormal];
                    [cell.adviceBtn1 setBackgroundColor:COLOR_BG_DARK_BLUE];
                }
                if ([cell.rightLabel.text isEqualToString:@"0"]) {
                    cell.adviceBtn2.layer.borderColor = COLOR_Text_Blue.CGColor;
                    [cell.adviceBtn2 setTitleColor:COLOR_TEXT_DARK_BLUE forState:UIControlStateNormal];
                    [cell.adviceBtn2 setBackgroundColor:COLOR_BG_DARK_BLUE];
                }
                if ([cell.rightLabel.text isEqualToString:@"60"]) {
                    cell.adviceBtn3.layer.borderColor = COLOR_Text_Blue.CGColor;
                    [cell.adviceBtn3 setTitleColor:COLOR_TEXT_DARK_BLUE forState:UIControlStateNormal];
                    [cell.adviceBtn3 setBackgroundColor:COLOR_BG_DARK_BLUE];
                }
                if ([cell.rightLabel.text isEqualToString:@"100"]) {
                    cell.adviceBtn4.layer.borderColor = COLOR_Text_Blue.CGColor;
                    [cell.adviceBtn4 setTitleColor:COLOR_TEXT_DARK_BLUE forState:UIControlStateNormal];
                    [cell.adviceBtn4 setBackgroundColor:COLOR_BG_DARK_BLUE];
                }
            }
            if ([cell.titleLabel.text isEqualToString:@"2、睡眠作息"]) {
                cell.rightLabel.text = str1;
                if ([cell.rightLabel.text isEqualToString:@"无效"]) {
                    cell.adviceBtn0.layer.borderColor = COLOR_Text_Blue.CGColor;
                    [cell.adviceBtn0 setTitleColor:COLOR_TEXT_DARK_BLUE forState:UIControlStateNormal];
                    [cell.adviceBtn0 setBackgroundColor:COLOR_BG_DARK_BLUE];
                }
                if ([cell.rightLabel.text isEqualToString:@"-100"]) {
                    cell.adviceBtn1.layer.borderColor = COLOR_Text_Blue.CGColor;
                    [cell.adviceBtn1 setTitleColor:COLOR_TEXT_DARK_BLUE forState:UIControlStateNormal];
                    [cell.adviceBtn1 setBackgroundColor:COLOR_BG_DARK_BLUE];
                }
                if ([cell.rightLabel.text isEqualToString:@"0"]) {
                    cell.adviceBtn2.layer.borderColor = COLOR_Text_Blue.CGColor;
                    [cell.adviceBtn2 setTitleColor:COLOR_TEXT_DARK_BLUE forState:UIControlStateNormal];
                    [cell.adviceBtn2 setBackgroundColor:COLOR_BG_DARK_BLUE];
                }
                if ([cell.rightLabel.text isEqualToString:@"60"]) {
                    cell.adviceBtn3.layer.borderColor = COLOR_Text_Blue.CGColor;
                    [cell.adviceBtn3 setTitleColor:COLOR_TEXT_DARK_BLUE forState:UIControlStateNormal];
                    [cell.adviceBtn3 setBackgroundColor:COLOR_BG_DARK_BLUE];
                }
                if ([cell.rightLabel.text isEqualToString:@"100"]) {
                    cell.adviceBtn4.layer.borderColor = COLOR_Text_Blue.CGColor;
                    [cell.adviceBtn4 setTitleColor:COLOR_TEXT_DARK_BLUE forState:UIControlStateNormal];
                    [cell.adviceBtn4 setBackgroundColor:COLOR_BG_DARK_BLUE];
                }
            }
            if ([cell.titleLabel.text isEqualToString:@"3、家居理疗"]) {
                cell.rightLabel.text = str2;
                if ([cell.rightLabel.text isEqualToString:@"无效"]) {
                    cell.adviceBtn0.layer.borderColor = COLOR_Text_Blue.CGColor;
                    [cell.adviceBtn0 setTitleColor:COLOR_TEXT_DARK_BLUE forState:UIControlStateNormal];
                    [cell.adviceBtn0 setBackgroundColor:COLOR_BG_DARK_BLUE];
                }
                if ([cell.rightLabel.text isEqualToString:@"-100"]) {
                    cell.adviceBtn1.layer.borderColor = COLOR_Text_Blue.CGColor;
                    [cell.adviceBtn1 setTitleColor:COLOR_TEXT_DARK_BLUE forState:UIControlStateNormal];
                    [cell.adviceBtn1 setBackgroundColor:COLOR_BG_DARK_BLUE];
                }
                if ([cell.rightLabel.text isEqualToString:@"0"]) {
                    cell.adviceBtn2.layer.borderColor = COLOR_Text_Blue.CGColor;
                    [cell.adviceBtn2 setTitleColor:COLOR_TEXT_DARK_BLUE forState:UIControlStateNormal];
                    [cell.adviceBtn2 setBackgroundColor:COLOR_BG_DARK_BLUE];
                }
                if ([cell.rightLabel.text isEqualToString:@"60"]) {
                    cell.adviceBtn3.layer.borderColor = COLOR_Text_Blue.CGColor;
                    [cell.adviceBtn3 setTitleColor:COLOR_TEXT_DARK_BLUE forState:UIControlStateNormal];
                    [cell.adviceBtn3 setBackgroundColor:COLOR_BG_DARK_BLUE];
                }
                if ([cell.rightLabel.text isEqualToString:@"100"]) {
                    cell.adviceBtn4.layer.borderColor = COLOR_Text_Blue.CGColor;
                    [cell.adviceBtn4 setTitleColor:COLOR_TEXT_DARK_BLUE forState:UIControlStateNormal];
                    [cell.adviceBtn4 setBackgroundColor:COLOR_BG_DARK_BLUE];
                }
            }
            if ([cell.titleLabel.text isEqualToString:@"4、验方茶疗"]) {
                cell.rightLabel.text = str3;
                if ([cell.rightLabel.text isEqualToString:@"无效"]) {
                    cell.adviceBtn0.layer.borderColor = COLOR_Text_Blue.CGColor;
                    [cell.adviceBtn0 setTitleColor:COLOR_TEXT_DARK_BLUE forState:UIControlStateNormal];
                    [cell.adviceBtn0 setBackgroundColor:COLOR_BG_DARK_BLUE];
                }
                if ([cell.rightLabel.text isEqualToString:@"-100"]) {
                    cell.adviceBtn1.layer.borderColor = COLOR_Text_Blue.CGColor;
                    [cell.adviceBtn1 setTitleColor:COLOR_TEXT_DARK_BLUE forState:UIControlStateNormal];
                    [cell.adviceBtn1 setBackgroundColor:COLOR_BG_DARK_BLUE];
                }
                if ([cell.rightLabel.text isEqualToString:@"0"]) {
                    cell.adviceBtn2.layer.borderColor = COLOR_Text_Blue.CGColor;
                    [cell.adviceBtn2 setTitleColor:COLOR_TEXT_DARK_BLUE forState:UIControlStateNormal];
                    [cell.adviceBtn2 setBackgroundColor:COLOR_BG_DARK_BLUE];
                }
                if ([cell.rightLabel.text isEqualToString:@"60"]) {
                    cell.adviceBtn3.layer.borderColor = COLOR_Text_Blue.CGColor;
                    [cell.adviceBtn3 setTitleColor:COLOR_TEXT_DARK_BLUE forState:UIControlStateNormal];
                    [cell.adviceBtn3 setBackgroundColor:COLOR_BG_DARK_BLUE];
                }
                if ([cell.rightLabel.text isEqualToString:@"100"]) {
                    cell.adviceBtn4.layer.borderColor = COLOR_Text_Blue.CGColor;
                    [cell.adviceBtn4 setTitleColor:COLOR_TEXT_DARK_BLUE forState:UIControlStateNormal];
                    [cell.adviceBtn4 setBackgroundColor:COLOR_BG_DARK_BLUE];
                }
            }
            if ([cell.titleLabel.text isEqualToString:@"5、养元功法"]) {
                cell.rightLabel.text = str4;
                if ([cell.rightLabel.text isEqualToString:@"无效"]) {
                    cell.adviceBtn0.layer.borderColor = COLOR_Text_Blue.CGColor;
                    [cell.adviceBtn0 setTitleColor:COLOR_TEXT_DARK_BLUE forState:UIControlStateNormal];
                    [cell.adviceBtn0 setBackgroundColor:COLOR_BG_DARK_BLUE];
                }
                if ([cell.rightLabel.text isEqualToString:@"-100"]) {
                    cell.adviceBtn1.layer.borderColor = COLOR_Text_Blue.CGColor;
                    [cell.adviceBtn1 setTitleColor:COLOR_TEXT_DARK_BLUE forState:UIControlStateNormal];
                    [cell.adviceBtn1 setBackgroundColor:COLOR_BG_DARK_BLUE];
                }
                if ([cell.rightLabel.text isEqualToString:@"0"]) {
                    cell.adviceBtn2.layer.borderColor = COLOR_Text_Blue.CGColor;
                    [cell.adviceBtn2 setTitleColor:COLOR_TEXT_DARK_BLUE forState:UIControlStateNormal];
                    [cell.adviceBtn2 setBackgroundColor:COLOR_BG_DARK_BLUE];
                }
                if ([cell.rightLabel.text isEqualToString:@"60"]) {
                    cell.adviceBtn3.layer.borderColor = COLOR_Text_Blue.CGColor;
                    [cell.adviceBtn3 setTitleColor:COLOR_TEXT_DARK_BLUE forState:UIControlStateNormal];
                    [cell.adviceBtn3 setBackgroundColor:COLOR_BG_DARK_BLUE];
                }
                if ([cell.rightLabel.text isEqualToString:@"100"]) {
                    cell.adviceBtn4.layer.borderColor = COLOR_Text_Blue.CGColor;
                    [cell.adviceBtn4 setTitleColor:COLOR_TEXT_DARK_BLUE forState:UIControlStateNormal];
                    [cell.adviceBtn4 setBackgroundColor:COLOR_BG_DARK_BLUE];
                }
            }
            if ([cell.titleLabel.text isEqualToString:@"6、情志调理"]) {
                cell.rightLabel.text = str5;
                if ([cell.rightLabel.text isEqualToString:@"无效"]) {
                    cell.adviceBtn0.layer.borderColor = COLOR_Text_Blue.CGColor;
                    [cell.adviceBtn0 setTitleColor:COLOR_TEXT_DARK_BLUE forState:UIControlStateNormal];
                    [cell.adviceBtn0 setBackgroundColor:COLOR_BG_DARK_BLUE];
                }
                if ([cell.rightLabel.text isEqualToString:@"-100"]) {
                    cell.adviceBtn1.layer.borderColor = COLOR_Text_Blue.CGColor;
                    [cell.adviceBtn1 setTitleColor:COLOR_TEXT_DARK_BLUE forState:UIControlStateNormal];
                    [cell.adviceBtn1 setBackgroundColor:COLOR_BG_DARK_BLUE];
                }
                if ([cell.rightLabel.text isEqualToString:@"0"]) {
                    cell.adviceBtn2.layer.borderColor = COLOR_Text_Blue.CGColor;
                    [cell.adviceBtn2 setTitleColor:COLOR_TEXT_DARK_BLUE forState:UIControlStateNormal];
                    [cell.adviceBtn2 setBackgroundColor:COLOR_BG_DARK_BLUE];
                }
                if ([cell.rightLabel.text isEqualToString:@"60"]) {
                    cell.adviceBtn3.layer.borderColor = COLOR_Text_Blue.CGColor;
                    [cell.adviceBtn3 setTitleColor:COLOR_TEXT_DARK_BLUE forState:UIControlStateNormal];
                    [cell.adviceBtn3 setBackgroundColor:COLOR_BG_DARK_BLUE];
                }
                if ([cell.rightLabel.text isEqualToString:@"100"]) {
                    cell.adviceBtn4.layer.borderColor = COLOR_Text_Blue.CGColor;
                    [cell.adviceBtn4 setTitleColor:COLOR_TEXT_DARK_BLUE forState:UIControlStateNormal];
                    [cell.adviceBtn4 setBackgroundColor:COLOR_BG_DARK_BLUE];
                }
            }
            if ([cell.titleLabel.text isEqualToString:@"7、营养疗法"]) {
                cell.rightLabel.text = str6;
                if ([cell.rightLabel.text isEqualToString:@"无效"]) {
                    cell.adviceBtn0.layer.borderColor = COLOR_Text_Blue.CGColor;
                    [cell.adviceBtn0 setTitleColor:COLOR_TEXT_DARK_BLUE forState:UIControlStateNormal];
                    [cell.adviceBtn0 setBackgroundColor:COLOR_BG_DARK_BLUE];
                }
                if ([cell.rightLabel.text isEqualToString:@"-100"]) {
                    cell.adviceBtn1.layer.borderColor = COLOR_Text_Blue.CGColor;
                    [cell.adviceBtn1 setTitleColor:COLOR_TEXT_DARK_BLUE forState:UIControlStateNormal];
                    [cell.adviceBtn1 setBackgroundColor:COLOR_BG_DARK_BLUE];
                }
                if ([cell.rightLabel.text isEqualToString:@"0"]) {
                    cell.adviceBtn2.layer.borderColor = COLOR_Text_Blue.CGColor;
                    [cell.adviceBtn2 setTitleColor:COLOR_TEXT_DARK_BLUE forState:UIControlStateNormal];
                    [cell.adviceBtn2 setBackgroundColor:COLOR_BG_DARK_BLUE];
                }
                if ([cell.rightLabel.text isEqualToString:@"60"]) {
                    cell.adviceBtn3.layer.borderColor = COLOR_Text_Blue.CGColor;
                    [cell.adviceBtn3 setTitleColor:COLOR_TEXT_DARK_BLUE forState:UIControlStateNormal];
                    [cell.adviceBtn3 setBackgroundColor:COLOR_BG_DARK_BLUE];
                }
                if ([cell.rightLabel.text isEqualToString:@"100"]) {
                    cell.adviceBtn4.layer.borderColor = COLOR_Text_Blue.CGColor;
                    [cell.adviceBtn4 setTitleColor:COLOR_TEXT_DARK_BLUE forState:UIControlStateNormal];
                    [cell.adviceBtn4 setBackgroundColor:COLOR_BG_DARK_BLUE];
                }
            }
            if ([cell.titleLabel.text isEqualToString:@"8、配合用药建议"]) {
                cell.rightLabel.text = str7;
                if ([cell.rightLabel.text isEqualToString:@"无效"]) {
                    cell.adviceBtn0.layer.borderColor = COLOR_Text_Blue.CGColor;
                    [cell.adviceBtn0 setTitleColor:COLOR_TEXT_DARK_BLUE forState:UIControlStateNormal];
                    [cell.adviceBtn0 setBackgroundColor:COLOR_BG_DARK_BLUE];
                }
                if ([cell.rightLabel.text isEqualToString:@"-100"]) {
                    cell.adviceBtn1.layer.borderColor = COLOR_Text_Blue.CGColor;
                    [cell.adviceBtn1 setTitleColor:COLOR_TEXT_DARK_BLUE forState:UIControlStateNormal];
                    [cell.adviceBtn1 setBackgroundColor:COLOR_BG_DARK_BLUE];
                }
                if ([cell.rightLabel.text isEqualToString:@"0"]) {
                    cell.adviceBtn2.layer.borderColor = COLOR_Text_Blue.CGColor;
                    [cell.adviceBtn2 setTitleColor:COLOR_TEXT_DARK_BLUE forState:UIControlStateNormal];
                    [cell.adviceBtn2 setBackgroundColor:COLOR_BG_DARK_BLUE];
                }
                if ([cell.rightLabel.text isEqualToString:@"60"]) {
                    cell.adviceBtn3.layer.borderColor = COLOR_Text_Blue.CGColor;
                    [cell.adviceBtn3 setTitleColor:COLOR_TEXT_DARK_BLUE forState:UIControlStateNormal];
                    [cell.adviceBtn3 setBackgroundColor:COLOR_BG_DARK_BLUE];
                }
                if ([cell.rightLabel.text isEqualToString:@"100"]) {
                    cell.adviceBtn4.layer.borderColor = COLOR_Text_Blue.CGColor;
                    [cell.adviceBtn4 setTitleColor:COLOR_TEXT_DARK_BLUE forState:UIControlStateNormal];
                    [cell.adviceBtn4 setBackgroundColor:COLOR_BG_DARK_BLUE];
                }
            }
            return cell;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.viewType == NurseHealthViewTypeLog)
    {
        if (indexPath.section == 0){
           return 40;
        }else if(indexPath.section == 2 ||indexPath.section == 3) {
            return 80;
        }else {
            return 130;
        }
    }else if ((self.viewType == NurseHealthViewTypeAdvice)){
        return 130;
    }else {
        if (indexPath.section == 0) {
            return 40;
        }else if(indexPath.section == self.dataArray.count - 1){
            return 130;
        }else {
            return 80;
        }
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.viewType == NurseHealthViewTypeLife){
        if (section == 1){
            return 110;
        }
    }
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
     if (self.viewType == NurseHealthViewTypeLife)
     {
          if (section == 1){
              UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 110)];
              headerView.backgroundColor = [UIColor whiteColor];
              
              UIButton *totalBtn = [[UIButton alloc] init];
              [totalBtn setImage:[UIImage imageNamed:@"g_mark_15x14"] forState:UIControlStateNormal];
              [totalBtn setTitle:@"总评分：" forState:UIControlStateNormal];
              totalBtn.titleLabel.font = SYSTEM_FONT_(14);
              [totalBtn setTitleColor:COLOR_Black forState:UIControlStateNormal];
              [headerView addSubview:totalBtn];
              
              UILabel *totalScoreLabel = [[UILabel alloc] init];
              totalScoreLabel.text = str8;
              totalScoreLabel.font = SYSTEM_FONT_(15);
              totalScoreLabel.textAlignment = NSTextAlignmentRight;
              totalScoreLabel.textColor = COLOR_TEXT_ORANGE_RED;
              [headerView addSubview:totalScoreLabel];
              
              UIView *explainView = [[UIView alloc] init];
              explainView.backgroundColor = COLOR_BG_DARK_BLUE;
              [headerView addSubview:explainView];
              
              UILabel *explainLabel1 = [[UILabel alloc] init];
              explainLabel1.text = @"总评分由以下8项计算评价所得：";
              explainLabel1.font = SYSTEM_FONT_(15);
              explainLabel1.textColor = COLOR_TEXT_DARK_BLUE;
              [explainView addSubview:explainLabel1];
              
              UILabel *explainLabel2 = [[UILabel alloc] init];
              explainLabel2.text = @"不选：不参加计算平均分；差：－100；一般：0；\n较好：60；好：100。";
              explainLabel2.font = SYSTEM_FONT_(14);
              explainLabel2.numberOfLines = 2;
              explainLabel2.textColor = COLOR_TEXT_DARK_BLUE;
              [explainView addSubview:explainLabel2];
              
              UIView *dividerLine1 = [[UIView alloc] init];
              dividerLine1.backgroundColor = COLOR_LineViewColor;
              [headerView addSubview:dividerLine1];
              
              UIView *dividerLine2 = [[UIView alloc] init];
              dividerLine2.backgroundColor = COLOR_LineViewColor;
              [headerView addSubview:dividerLine2];
              
              UIView *dividerLine3 = [[UIView alloc] init];
              dividerLine3.backgroundColor = COLOR_LineViewColor;
              [explainView addSubview:dividerLine3];
              
              UIView *bottomView = [[UIView alloc] init];
              bottomView.backgroundColor = COLOR_BackgroundColor;
              [headerView addSubview:bottomView];
              
              dividerLine1.sd_layout
              .leftEqualToView(headerView)
              .topEqualToView(headerView)
              .widthIs(ScreenWidth)
              .heightIs(1);
              
              totalBtn.sd_layout
              .leftEqualToView(headerView).offset(15)
              .topEqualToView(headerView)
              .widthIs(85)
              .heightIs(35);
              
              totalScoreLabel.sd_layout
              .rightEqualToView(headerView).offset(-15)
              .centerYEqualToView(totalBtn)
              .widthIs(85)
              .heightRatioToView(totalBtn,1);
              
              explainView.sd_layout
              .leftEqualToView(headerView)
              .topEqualToView(headerView).offset(35)
              .widthRatioToView(headerView,1)
              .heightIs(65);
              
              explainLabel1.sd_layout
              .leftEqualToView(explainView).offset(15)
              .topEqualToView(explainView)
              .widthRatioToView(explainView,1)
              .heightIs(25);
              
              explainLabel2.sd_layout
              .leftEqualToView(explainView).offset(15)
              .topSpaceToView(explainLabel1,0)
              .widthIs(ScreenWidth - 30)
              .heightIs(35);
              
              dividerLine2.sd_layout
              .leftEqualToView(headerView)
              .bottomEqualToView(totalBtn)
              .widthIs(ScreenWidth)
              .heightIs(1);
              
              dividerLine3.sd_layout
              .leftEqualToView(explainView)
              .bottomEqualToView(explainView)
              .widthIs(ScreenWidth)
              .heightIs(1);
              
              bottomView.sd_layout
              .leftEqualToView(headerView)
              .bottomEqualToView(headerView)
              .widthIs(ScreenWidth)
              .heightIs(10);
              
              return headerView;
          }
     }
    
    return [[UIView alloc] init];
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
            type = @"2";
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
- (void)topButtonClickWithTag:(TopSelectViewType)tag
{
    [self.dataArray removeAllObjects];
    [self.totalArray removeAllObjects];
    [self.topSelectView.leftButton setTitleColor:COLOR_darkGray forState:UIControlStateNormal];
    [self.topSelectView.rightButton setTitleColor:COLOR_darkGray forState:UIControlStateNormal];
    [self.topSelectView.centerButton setTitleColor:COLOR_darkGray forState:UIControlStateNormal];
    
    switch (tag) {
        case TopSelectViewTypeLeft:
            [self.topSelectView.leftButton setTitleColor:COLOR_Text_Blue forState:UIControlStateNormal];
            [self.dataArray addObjectsFromArray:logArray];
            [self.totalArray addObjectsFromArray:basicInformationArr];
            self.viewType = NurseHealthViewTypeLog;
            self.statc = @"1";
            break;
        case TopSelectViewTypeCenter:
            [self.topSelectView.centerButton setTitleColor:COLOR_Text_Blue forState:UIControlStateNormal];
            [self.dataArray addObjectsFromArray:lifeArray];
            self.viewType = NurseHealthViewTypeLife;
            self.statc = @"2";

            break;
        case TopSelectViewTypeRight:
            [self.topSelectView.rightButton setTitleColor:COLOR_Text_Blue forState:UIControlStateNormal];
            [self.dataArray addObjectsFromArray:adviceArray];
            [self.totalArray addObjectsFromArray:mianInformation];
            self.viewType = NurseHealthViewTypeAdvice;
            self.statc = @"3";

            break;
        default:
            break;
    }
    
    [self.tableView reloadData];
}
#pragma mark - ====网络====
- (void)requestData
{
    [LCProgressHUD showLoading:@"正在加载..."];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:self.YongHuId forKey:@"c_id"];
    [params setValue:mBookTime forKey:@"dataTime"];
    [params setValue:type forKey:@"type"];
    
    [HCTConnet getNurseHealthVC:params success:^(id responseObject) {
     
        self.model = [NurseHealthModel mj_objectWithKeyValues:responseObject];
        basicInformationArr = @[@[[self judgeString:self.model.d_program_detail]],@[[self judgeString:self.model.dialectics_program]],@[[self judgeString:self.model.con_home_heal]],@[[self judgeString:self.model.con_eva]],@[[self judgeString:self.model.dean_check_view]],@[[self judgeString:self.model.expert_check_view]]];

        indexInformation = @[@[[self judgeString:self.model.dean_check_view]],@[[self judgeString:self.model.expert_check_view]]];
        
        
        self.totalArray = [[NSMutableArray alloc]initWithArray:basicInformationArr];
        
        str8 = self.model.con_home_heal_value_total;
        str9 = self.model.total_string;
        NSArray *totalArr = [str9 componentsSeparatedByString:@","];
        str0 = totalArr[0];
        str1 = totalArr[1];
        str2 = totalArr[2];
        str3 = totalArr[3];
        str4 = totalArr[4];
        str5 = totalArr[5];
        str6 = totalArr[6];
        str7 = totalArr[7];
       

        DLog(@")_____%@",totalArr);
        [self.tableView reloadData];
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.viewType == NurseHealthViewTypeLog){
        
        if (indexPath.section == 0){
            JumpVC *vc = [[JumpVC alloc] init];
            vc.titlel =@"调理方案";
            vc.content =[self judgeString:self.model.d_program_detail];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        
    }
    
    if (self.viewType == NurseHealthViewTypeLife){
        
        if (indexPath.section == 0){
            JumpVC *vc = [[JumpVC alloc] init];
            vc.titlel =@"家居养生方案";
            vc.content =[self judgeString:self.model.home_health_req];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        
    }
    
    
}

-(NSString *)jubstring:(id)str{
    if ([str isEqualToString:@"无效"]) {
        str = @"-1";
    }
    return str;
    
}
- (NSString *)judgeString:(id)str{
    NSString *result = str?str:@"";
    return result;
}
@end
