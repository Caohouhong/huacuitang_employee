//
//  ReturnVisitVC.m
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/28.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "ReturnVisitVC.h"
#import "NextAndLastDateView.h"
#import "HuaCuiTangHelper.h"

@interface ReturnVisitVC ()<NextAndLastDateViewDelegate>
{
    int dayNum;
    NSString *mBookTime;
    
    UITextView *textlabel;
}
@property (nonatomic, strong) NextAndLastDateView *topView;
@end

@implementation ReturnVisitVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"回访记录";
    self.view.backgroundColor = COLOR_BackgroundColor;
    [self drawView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)drawView{
    
    _topView = [[NextAndLastDateView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 35)];
    _topView.delegate = self;
    [_topView.nextBtn setTitle:@"下一条" forState:UIControlStateNormal];
    [_topView.lastBtn setTitle:@"上一条" forState:UIControlStateNormal];
    [self.view addSubview:self.topView];
    
    [self nowDateDay];
    
    UIView *holdView = [[UIView alloc] initWithFrame:CGRectMake(0, 45, ScreenWidth, ScreenHeight - 45)];
    holdView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:holdView];
    
    textlabel = [[UITextView alloc] init];
    textlabel.text = @"总结回访内容回访内容回访内容回访内容回访内容回访内容回访内容";
    textlabel.font = SYSTEM_FONT_(15);
    textlabel.textColor = COLOR_Black;
    textlabel.editable = NO;
    [holdView addSubview:textlabel];
    
    textlabel.sd_layout
    .leftEqualToView(holdView).offset(15)
    .topSpaceToView(holdView,10)
    .widthIs(ScreenWidth - 30)
    .bottomEqualToView(holdView).offset(-15);
}
//获取本月年月日
- (void)nowDateDay{
    dayNum = 0;
    NSString *dateString = [HuaCuiTangHelper getPriousorLaterDateFromNowWithDay:dayNum];
    self.topView.dataLabel.text = dateString;
    
    mBookTime = [self changeDateStringStyleWith:dateString];
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

#pragma mark NextAndLastDateViewDelegate 上一天下一天
- (void)nextAndLastDateBtnClickWithTag:(NextAndLastDateViewButtonType)tag
{
    switch (tag) {
        case NextAndLastDateViewButtonTypeLast:
        {
            dayNum--;
        }
            break;
        case NextAndLastDateViewButtonTypeNext:
        {
            dayNum++;
        }
            break;
    }
    
    NSString *dateString = [HuaCuiTangHelper getPriousorLaterDateFromNowWithDay:dayNum];
    self.topView.dataLabel.text = dateString;
    
    mBookTime = [self changeDateStringStyleWith:dateString];
    //show hud
    //    [LCProgressHUD showLoading:@"正在加载..."];
    //    [self requestData];
}

@end
