//
//  SecretTopicVC.m
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/28.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "SecretTopicVC.h"
#import "PWContentView.h"
#import "HCTConnet.h"
#import "SecretLiftModel.h"
@interface SecretTopicVC ()
@property(nonatomic,strong)SecretLiftModel *model;
@property(nonatomic,strong)NSMutableArray *dataArr;
@end

@implementation SecretTopicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!self.dataArr){
        _dataArr = [NSMutableArray array];
    }
    self.navigationItem.title = @"私密话题";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)drawView{
    UIView *topHoldView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 35)];
    topHoldView.backgroundColor = COLOR_BG_DARK_BLUE;
    [self.view addSubview:topHoldView];
    
    UILabel *textlabel = [[UILabel alloc] init];
    textlabel.text = @"喜欢什么，爱好什么，讨厌什么等等";
    textlabel.font = SYSTEM_FONT_(14);
    textlabel.textColor = COLOR_TEXT_DARK_BLUE;
    [self.view addSubview:textlabel];
    
    textlabel.sd_layout
    .leftEqualToView(self.view).offset(15)
    .topSpaceToView(self.view,0)
    .widthRatioToView(self.view,1)
    .heightIs(35);
    
   
    
    
    PWContentView *pwView = [[PWContentView alloc]initWithFrame:CGRectMake(10, 50, self.view.frame.size.width - 20,450) dataArr:self.dataArr];
    pwView.backgroundColor = [UIColor whiteColor];
    [pwView btnClickBlock:^(NSInteger index) {
        
        NSLog(@"%ld",(long)index);
        
    }];
    [self.view addSubview:pwView];

}
- (void)requestData
{
   
        [LCProgressHUD showLoading:@"正在加载..."];
        NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
        [params setValue:self.YongHuId forKey:@"customerId"];
        [params setValue:@"1" forKey:@"tagType"];
        [HCTConnet getSecretTopicVC:params success:^(id responseObject) {
            NSArray *arr = responseObject;
            for (NSDictionary *dic in arr) {
                DLog(@"%@",dic);
                SecretLiftModel *model = [[SecretLiftModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                NSString *str = [NSString stringWithFormat:@"%@|%@",model.tagName,model.tagNum];
                [self.dataArr addObject:str];
            }
            DLog(@"%lu",(unsigned long)self.dataArr.count);
            [self drawView];
        } successBackfailError:^(id responseObject) {
            
        } failure:^(NSURLSessionDataTask *operation, NSError *error) {
            
        }];
    }


@end
