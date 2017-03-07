//
//  GuKeDetailVC.m
//  华粹堂-员工端
//
//  Created by liqiang on 2016/11/28.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import "GuKeDetailVC.h"
#import "PersonalView.h"
#import "TheLabelViewController.h"
#import "GuKeView1.h"
#import "ModelGuKe.h"
#import "EditorHuiFangViewController.h"

#import "global.h"
#import "BGTopSilderBar.h"
#import "HuiFangModel.h"

@interface GuKeDetailVC ()<UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,MFMessageComposeViewControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, weak) UIView *lineView;
@property (nonatomic, weak) UIScrollView *headScro;
@property (nonatomic, weak) GuKeView1 *view1;
@property (nonatomic, strong) ModelGuKe *GukeModel;
@end

@implementation GuKeDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"顾客详情";
    
    [self initData];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

-(void)initData {
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:self.model.sid forKey:@"customerId"];
    
    [[LQHTTPSessionManager sharedManager] LQPost:@"customer/getCustomer" parameters:params showTips:@"" success:^(id responseObject) {
        self.GukeModel = [ModelGuKe mj_objectWithKeyValues:responseObject];
        [self drawView];
        [self drawFooterView];
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)drawView
{
    GuKeView1 *view1 = [[GuKeView1 alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-60)];
    WEAK(weakSelf)
    view1.model = self.model;
    view1.block = ^() {
        TheLabelViewController *theVC = [[TheLabelViewController alloc]init];
        theVC.c_id = weakSelf.model.sid;
        [weakSelf.navigationController pushViewController:theVC animated:YES];
    };
    [self.view addSubview:view1];
}

- (void)drawFooterView
{
    NSArray *bottomArray = @[@"发送消息", @"发送信息", @"打电话", @"新建回访"];
    NSArray *imageArray = @[@"faxinxi", @"gukexihao", @"gukekaxiang", @"gukekaxiang"];
    for (int i = 0; i < bottomArray.count; i++) {
        CGRect frame = CGRectMake(i*ScreenWidth/4 , ScreenHeight-60, ScreenWidth/4, 60);
        PersonalView *btnView = [[PersonalView alloc]initWithFrame:frame title:bottomArray[i] imagestr:imageArray[i]];
        btnView.tag = 100+i;
        [self.view addSubview:btnView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(OneTapClick:)];
        [btnView addGestureRecognizer:tap];
    }

    UIView *topLineView = [self LineView];
    UIView *lineView1 = [self LineView];
    UIView *lineView2 = [self LineView];
    UIView *lineView3 = [self LineView];
    [self.view sd_addSubviews:@[topLineView, lineView1,lineView2,lineView3]];
    
    topLineView.sd_layout
    .leftSpaceToView(self.view,0).rightSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,60).heightIs(0.5);
    
    lineView1.sd_layout
    .leftSpaceToView(self.view,ScreenWidth/4).bottomSpaceToView(self.view,0)
    .widthIs(0.5).heightIs(60);
    
    lineView2.sd_layout
    .leftSpaceToView(lineView1,ScreenWidth/4).bottomSpaceToView(self.view,0)
    .widthIs(0.5).heightIs(60);
    
    lineView3.sd_layout
    .leftSpaceToView(lineView2,ScreenWidth/4).bottomSpaceToView(self.view,0)
    .widthIs(0.5).heightIs(60);
}

-(void)OneTapClick:(UITapGestureRecognizer *)tap {
    
    if(tap.view.tag == 100) {
        
        if (!self.model.imUserName.length) {
            
            [LCProgressHUD showFailure:@"当前客户不可聊天"];
            return;
        }
        
        EaseMessageViewController *vc = [[EaseMessageViewController alloc] initWithConversationChatter:self.model.imUserName conversationType:EMConversationTypeChat];
        vc.navigationItem.title = self.model.name;
        vc.receiverMemberId = self.model.sid;
        vc.receiverPortrait = self.model.portrait;
        vc.receiverName = self.model.name;
        vc.receiverPhone = self.model.telephone;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (tap.view.tag == 101) {
        
        if(self.GukeModel.mobile_phone.length)
        {
            AppDelegate *del = APPDELEGATE;
            [del sendMessageWithPhone:self.GukeModel.mobile_phone];
        }
    }
    
    
    if(tap.view.tag == 102) {

        NSLog(@"点了%@",self.GukeModel.mobile_phone);
        NSString *num = [[NSString alloc]initWithFormat:@"telprompt://%@",self.GukeModel.mobile_phone];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]];
    }
    if(tap.view.tag == 103) {
        
        HuiFangModel *model = [[HuiFangModel alloc]init];
        model.customerName = self.model.name;
        model.visit_time = self.model.last_consume_time;
        model.c_id = self.model.c_id;
        model.sid = self.model.sid;
        model.state = @"1";
        model.customerTel = self.model.mobile_phone;
        
        EditorHuiFangViewController *vc = [[EditorHuiFangViewController alloc]init];
        vc.model = model;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(UIView *)LineView {
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = HEXCOLOR(0x333333);
    return view;
}

@end
