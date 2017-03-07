//
//  ChhYuYueDetailVC.m
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/24.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "ChhYuYueDetailVC.h"
#import "ModelHealthBooking.h"
#import "HCTConnet.h"
#import "ChhYuYueTableViewCell.h"
#import "ChhYuYueDetailBottomView.h"
#import "ChhYuYueDetailHeaderView.h"


@interface ChhYuYueDetailVC ()<UITableViewDelegate, UITableViewDataSource,ChhYuYueDetailBottomViewDelegate>
{
    NSArray *titleArray;
}
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) ChhYuYueDetailHeaderView *headerView;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) ChhYuYueDetailBottomView *bottomView;
@property (nonatomic, strong) ModelHealthBooking *model;
@end

@implementation ChhYuYueDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"预约记录";
    self.view.backgroundColor = COLOR_BackgroundColor;
    
    titleArray = @[@"门店",@"调理师",@"专家看诊",@"时间",@"预约项目",@"目标",@"目标项目／切入点",@"状态",@"备注"];
    
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"calendar"] style:UIBarButtonItemStylePlain target:self action:@selector(didClickRightBar)];
    self.navigationItem.rightBarButtonItem = rightBar;
    
    [self drawView];
    
    //show hud
    [LCProgressHUD showLoading:@"正在加载..."];
    [self requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)drawView{
    
    [self initFooterView];
    [self.view addSubview:self.bottomView];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = COLOR_BackgroundColor;
    tableView.tableHeaderView = self.headerView;
    tableView.tableFooterView = self.footerView;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    tableView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,45);
    
    _bottomView.sd_layout
    .leftEqualToView(self.view)
    .bottomEqualToView(self.view)
    .widthRatioToView(self.view,1)
    .heightIs(45);
    
}

- (ChhYuYueDetailHeaderView *)headerView
{
    if (_headerView == nil)
    {
        _headerView = [[ChhYuYueDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 90)];
    }
    return _headerView;
}

- (void)initFooterView
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 60)];
    footerView.backgroundColor = COLOR_BackgroundColor;
    self.footerView = footerView;
    
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:@"标记完成" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    btn.backgroundColor = COLOR_ButtonBackGround_Blue;
    btn.layer.cornerRadius = 5;
    [footerView addSubview:btn];
    
    btn.sd_layout
    .leftSpaceToView(footerView,20)
    .rightSpaceToView(footerView,20)
    .centerYEqualToView(footerView)
    .heightIs(40);
}

- (ChhYuYueDetailBottomView *)bottomView
{
    if (_bottomView == nil)
    {
        _bottomView = [[ChhYuYueDetailBottomView alloc] initWithFrame:CGRectZero];
        _bottomView.delegate = self;
    }
    return _bottomView;
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

    switch (indexPath.row) {
        case 0: //门店
            cell.leftLabel.attributedText = [self changeTextColorWithRestltStr:[NSString stringWithFormat:@"%@:    %@",titleArray[indexPath.row],self.model.s_name] changeText:self.model.s_name];
            break;
        case 1: //调理师
            cell.leftLabel.attributedText = [self changeTextColorWithRestltStr:[NSString stringWithFormat:@"%@:    %@",titleArray[indexPath.row],self.model.name] changeText:self.model.name];
            break;
        case 2: //专家看诊
        {
            //1-专家 0 非
            NSString *isExper = ([@"1" isEqualToString:self.model.book_type]) ? @"是" : @"非";
            cell.leftLabel.attributedText = [self changeTextColorWithRestltStr:[NSString stringWithFormat:@"%@:    %@",titleArray[indexPath.row],isExper] changeText:isExper];
        }
            break;
        case 3: //时间
        {
            NSString *time = [NSString stringWithFormat:@"%@~%@",self.model.book_start_time,self.model.book_end_time];
            cell.leftLabel.attributedText = [self changeTextColorWithRestltStr:[NSString stringWithFormat:@"%@:    %@",titleArray[indexPath.row],time] changeText:time];
        }
            break;
        case 4: //预约项目
            cell.leftLabel.attributedText = [self changeTextColorWithRestltStr:[NSString stringWithFormat:@"%@:    %@",titleArray[indexPath.row],self.model.book_program] changeText:self.model.book_program];
            break;
        case 5: //目标
            cell.leftLabel.attributedText = [self changeTextColorWithRestltStr:[NSString stringWithFormat:@"%@:    %@",titleArray[indexPath.row],self.model.aims?self.model.aims:@""] changeText:self.model.aims];
            break;
        case 6: //目标项目／切入点
            cell.leftLabel.attributedText = [self changeTextColorWithRestltStr:[NSString stringWithFormat:@"%@:    %@",titleArray[indexPath.row],self.model.aimContent?self.model.aimContent:@""] changeText:self.model.aimContent];
            break;
        case 7: //状态
        {
            //1-已 0-非
            NSString *state = ([@"1" isEqualToString:self.model.book_type]) ? @"已服务" : @"待服务";;
            cell.leftLabel.attributedText = [self changeTextColorWithRestltStr:[NSString stringWithFormat:@"%@:    %@",titleArray[indexPath.row],state] changeText:state];
        }
            break;
        case 8: //备注
            cell.leftLabel.attributedText = [self changeTextColorWithRestltStr:[NSString stringWithFormat:@"%@:    %@",titleArray[indexPath.row],self.model.remark] changeText:self.model.s_name];
            break;
            
        default:
            break;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

#pragma mark ============= 网络 =================
- (void)requestData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//     [params setValue:self.healthbookingId forKey:@"healthbookingId"];
// H 测试
    [params setValue:@(146) forKey:@"healthbookingId"];

    [HCTConnet getHomeGetHealthBookingDetailV2:params success:^(id responseObject) {
        
        self.model = [ModelHealthBooking mj_objectWithKeyValues:responseObject];
        [self refreshHeaderUI];
        [self.tableView reloadData];
    
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}

- (void)refreshHeaderUI
{
    //H 测试
    _headerView.nameTextlabel.text = self.model.employeeName;
    _headerView.phoneTextlabel.text = self.model.mobile_phone;
    _headerView.addressTextlabel.text = self.model.s_name;
    
//    _headerView.yearTextlabel.text = self.model.birthday;
    _headerView.sexImageView.image = ([@"1" isEqualToString:self.model.self.sex]) ? [UIImage imageNamed:@"icon_girl"] : [UIImage imageNamed:@"icon_boy"];
//    _headerView.iconImageView.image =  //头像地址
}

#pragma mark - 日历按钮
- (void)didClickRightBar
{
    
}

#pragma ChhYuYueDetailBottomViewDelegate 底部按钮点击代理
- (void)bottomBtnClickWithTag:(ChhYuYueDetailBotViewType)tag
{
    
}


- (NSMutableAttributedString *)changeTextColorWithRestltStr:(NSString *)result changeText:(NSString *)text {
    
    
    NSMutableAttributedString *attributuStr = [[NSMutableAttributedString alloc] initWithString:result];

    if (text.length > 0){
        NSRange textRange = NSMakeRange([[attributuStr string] rangeOfString:text].location, [[attributuStr string] rangeOfString:text].length);
        [attributuStr addAttribute:NSForegroundColorAttributeName value:COLOR_Gray range:textRange];
    }
     return attributuStr;
}


@end
