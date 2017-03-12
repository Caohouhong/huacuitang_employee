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
#import "ModelGuKe.h"


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
    [btn addTarget:self action:@selector(finishAction) forControlEvents:UIControlEventTouchUpInside];
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
    [params setValue:self.healthbookingId forKey:@"healthbookingId"];

    [HCTConnet getHomeGetHealthBookingDetailV2:params success:^(id responseObject) {
        
        self.model = [ModelHealthBooking mj_objectWithKeyValues:responseObject];
        self.headerView.yuyueModel = self.model;
        [self.tableView reloadData];
    
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}


/**
 标记完成
 */
- (void)requestBookingToFinish
{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:self.healthbookingId forKey:@"healthBookingId"];
    [params setValue:@(0) forKey:@"state"];
    [params setValue:self.model.name forKey:@"customerName"];
    [params setValue:self.model.book_start_time forKey:@"track_date"];
    [params setValue:self.model.book_start_time forKey:@"visit_time"];
    [params setValue:self.model.sid forKey:@"e_id"];
    [params setValue:self.model.s_name forKey:@"shopName"];
    [params setValue:self.model.mobile_phone forKey:@"customerTel"];
    [params setValue:self.model.mobile_phone forKey:@"customerMobilePhone"];
    
    
    [[LQHTTPSessionManager sharedManager] LQPost:@"healthBooking/bookingToFinish" parameters:params showTips:@"正在加载..." success:^(id responseObject) {
        
        ModelHealthBooking *bookModel = self.model;
        bookModel.state = @"1";
        bookModel.customerName = bookModel.name;
        bookModel.track_date = bookModel.book_start_time;
        bookModel.visit_time = bookModel.book_start_time;
        bookModel.e_id = bookModel.sid;
        bookModel.shopName = bookModel.s_name; //门店
        bookModel.customerTel = bookModel.mobile_phone;
        bookModel.customerMobilePhone = bookModel.mobile_phone;
        
        NSMutableArray *tiaoliArr = [[NSMutableArray array]init];
        [tiaoliArr addObject:bookModel];
        [[DataManage sharedMemberMySelf] saveTiaoLiDataWithModelArray:tiaoliArr];
        [[DataManage sharedMemberMySelf] saveHuiFangDataWithModelArray:tiaoliArr];
        
        [LCProgressHUD showSuccess:@"标记成功"];
        
        [self.navigationController popViewControllerAnimated:YES];
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - 日历按钮
//- (void)didClickRightBar
//{
//    
//}

#pragma ChhYuYueDetailBottomViewDelegate 底部按钮点击代理
- (void)bottomBtnClickWithTag:(ChhYuYueDetailBotViewType)tag
{
    switch (tag) {
        case ChhYuYueDetailBotViewTypeCall:
        {
            NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",self.model.mobile_phone];//回访手机号
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }
            break;
        case ChhYuYueDetailBotViewTypeMessage:{
            NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"sms://%@",self.model.mobile_phone];//回访手机号
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }
           
            break;
        case ChhYuYueDetailBotViewTypeChat:
        {
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
        }
                break;
        default:
            break;
    }
}


- (NSMutableAttributedString *)changeTextColorWithRestltStr:(NSString *)result changeText:(NSString *)text {
    
    
    NSMutableAttributedString *attributuStr = [[NSMutableAttributedString alloc] initWithString:result];

    if (text.length > 0){
        NSRange textRange = NSMakeRange([[attributuStr string] rangeOfString:text].location, [[attributuStr string] rangeOfString:text].length);
        [attributuStr addAttribute:NSForegroundColorAttributeName value:COLOR_Gray range:textRange];
    }
     return attributuStr;
}

//标记完成
- (void)finishAction{
    [self requestBookingToFinish];
}

@end
