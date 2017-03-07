//
//  AccountInfoDetailVC.m
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/28.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "AccountInfoDetailVC.h"
#import "ChhYuYueTableViewCell.h"
#import "HuaCuiTangHelper.h"

@interface AccountInfoDetailVC ()<UITableViewDelegate, UITableViewDataSource>
{
    NSArray *titleArray;
}
@property (nonatomic, weak) UITableView *tableView;

@end

@implementation AccountInfoDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"账户信息";
    titleArray = @[@"卡号：",@"项目：",@"余额：",@"剩余次数：",@"办卡时间：",@"最近一次销卡："];
    [self drawView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)drawView{
    
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
    .topSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,0);
    
    //    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefersh)];
    //    tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefersh)];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChhYuYueTableViewCell *cell = [ChhYuYueTableViewCell cellWithTableView:self.tableView];
    
    cell.leftLabel.attributedText = [HuaCuiTangHelper changeTextColorWithRestltStr:[NSString stringWithFormat:@"%@    %@",titleArray[indexPath.row],@"未知"] changeText:@"未知" andColor:COLOR_Gray];
                                
//    switch (indexPath.row) {
//        case 0: //卡号
//            cell.leftLabel.attributedText = [self changeTextColorWithRestltStr:[NSString stringWithFormat:@"%@:    %@",titleArray[indexPath.row],self.model.s_name] changeText:self.model.s_name];
//            break;
//        case 1: //项目
//            cell.leftLabel.attributedText = [self changeTextColorWithRestltStr:[NSString stringWithFormat:@"%@:    %@",titleArray[indexPath.row],@"现金"] changeText:@"现金"];
//            break;
//        case 2: //余额
//        {
//            cell.leftLabel.attributedText = [self changeTextColorWithRestltStr:[NSString stringWithFormat:@"%@:    %@",titleArray[indexPath.row],isExper] changeText:isExper];
//        }
//            break;
//        case 3: //剩余次数
//        {
//            NSString *time = [NSString stringWithFormat:@"%@~%@",self.model.book_start_time,self.model.book_end_time];
//            cell.leftLabel.attributedText = [self changeTextColorWithRestltStr:[NSString stringWithFormat:@"%@:    %@",titleArray[indexPath.row],time] changeText:time];
//        }
//            break;
//        case 4: //办卡时间
//            cell.leftLabel.attributedText = [self changeTextColorWithRestltStr:[NSString stringWithFormat:@"%@:    %@",titleArray[indexPath.row],self.model.book_program] changeText:self.model.book_program];
//            break;
//        case 5: //销卡时间
//            cell.leftLabel.attributedText = [self changeTextColorWithRestltStr:[NSString stringWithFormat:@"%@:    %@",titleArray[indexPath.row],self.model.aims?self.model.aims:@""] changeText:self.model.aims];
//            break;
//        default:
//            break;
//    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

@end
