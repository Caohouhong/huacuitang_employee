//
//  YuYueDateChooseVC.m
//  华粹堂-员工端
//
//  Created by liqiang on 2016/11/16.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import "YuYueDateChooseVC.h"
#import "LGCalendarView.h"

@interface YuYueDateChooseVC ()<LGCalendarViewDelegate>

@property (nonatomic, weak) LGCalendarView *calendarView;
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;


@end

@implementation YuYueDateChooseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"预约日期";
    
    [self drawView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)drawView
{
    LGCalendarView *calendarView = [[LGCalendarView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 100)];
    calendarView.opaque = NO;
    calendarView.backgroundColor = [UIColor clearColor];
    calendarView.delegate = self;
    calendarView.firstDate = [NSDate date];
    [calendarView loadDatas];
    [self.view addSubview:calendarView];
    self.calendarView = calendarView;
    
    UIButton *sureBtn = [[UIButton alloc] init];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    sureBtn.backgroundColor = HEXCOLOR(0x1ba5d7);
    [sureBtn addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    sureBtn.layer.cornerRadius = 5;
    [self.view addSubview:sureBtn];
    
    sureBtn.sd_layout
    .leftSpaceToView(self.view,20)
    .topSpaceToView(self.calendarView,30)
    .rightSpaceToView(self.view,20)
    .heightIs(40);
}

- (void)sure
{
    
    if (!self.startDate && !self.endDate)
    {
        [LCProgressHUD showFailure:@"请选择日期"];
        return;
    }
    
    if (self.didClickDateBlock)
    {
        self.didClickDateBlock(self.startDate,self.endDate);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark -
#pragma mark ================= LGCalendarViewDelegate =================
- (void)selectedDate:(NSDate *)firstDate and:(NSDate *)lastDate
{
    NSLog(@"firstDate = %@  lastDate = %@ ",firstDate,lastDate);
    
    self.startDate = firstDate;
    
    if (lastDate) {
        self.endDate = lastDate;
    }else{
        self.endDate = firstDate;
    }
}

@end
