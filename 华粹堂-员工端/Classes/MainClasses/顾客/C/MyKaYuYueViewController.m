//
//  MyKaYuYueViewController.m
//  华粹堂-客户端
//
//  Created by 唐硕 on 16/12/2.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import "MyKaYuYueViewController.h"
#import "LGCalendarView.h"

@interface MyKaYuYueViewController ()<LGCalendarViewDelegate>

@property (nonatomic, weak) LGCalendarView *calendarView;
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;

@end

@implementation MyKaYuYueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
