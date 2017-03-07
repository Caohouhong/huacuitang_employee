//
//  ToViewViewController.m
//  华粹堂-员工端
//
//  Created by 唐硕 on 16/11/25.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import "ToViewViewController.h"

@interface ToViewViewController ()
@property (nonatomic, weak) UILabel *tiaoLabel;
@property (nonatomic, weak) UILabel *homeLabel;
@end

@implementation ToViewViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self initData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"调理方案";

    [self initViews];
}


-(void)initData {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:self.M_id forKey:@"customerId"];
    [[LQHTTPSessionManager sharedManager] LQPost:@"trackManage/getProgramDetailAndHomeHealth" parameters:params showTips:@"加载中..." success:^(id responseObject) {
       
        self.tiaoLabel.text = [NSString stringWithFormat:@"调理方案:\n%@", responseObject[@"d_program_detail"]];
        self.homeLabel.text = [NSString stringWithFormat:@"家居养生方案:\n%@", responseObject[@"home_health_req"]];
        
    } successBackfailError:^(ModelFieldError *responseObject) {
        if(responseObject.field == -6) {
            self.tiaoLabel.text = [NSString stringWithFormat:@"调理方案:\n无数据"];
            self.homeLabel.text = [NSString stringWithFormat:@"家居养生方案:\n无数据"];
        }else {
            self.tiaoLabel.text = [NSString stringWithFormat:@"调理方案:\n无数据"];
            self.homeLabel.text = [NSString stringWithFormat:@"家居养生方案:\n无数据"];
        }
    } failure:^(NSError *error) {

    }];
    
}

-(void)initViews {
   
    UILabel *tiaoLabel = [[UILabel alloc]init];
    tiaoLabel.text = @"调理方案:\n请我去和我还抢我发货去死吧，是巴萨卡斯，发顺丰撒浪费巴斯夫";
    tiaoLabel.font = TFont(13.0);
    tiaoLabel.textColor = HEXCOLOR(0x333333);
    self.tiaoLabel = tiaoLabel;
    
    UILabel *jiaLabel = [[UILabel alloc]init];
    jiaLabel.text = @"家居养生方案:\n欠费了那女那；进球数分片区内拉手闹事；那绿女安排；女爱徐娟旅行笔记";
    jiaLabel.font = TFont(13.0);
    jiaLabel.textColor = HEXCOLOR(0x333333);
    self.homeLabel = jiaLabel;
    
    [self.view sd_addSubviews:@[tiaoLabel, jiaLabel]];
    
    tiaoLabel.sd_layout
    .leftSpaceToView(self.view,10)
    .topSpaceToView(self.view,10)
    .rightSpaceToView(self.view,10)
    .heightIs(20).autoHeightRatio(0);
    
    jiaLabel.sd_layout
    .leftSpaceToView(self.view,10)
    .topSpaceToView(tiaoLabel,10)
    .rightSpaceToView(self.view,10)
    .heightIs(20).autoHeightRatio(0);
    
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
