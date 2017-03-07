//
//  RiChengVC.m
//  华粹堂-员工端
//
//  Created by liqiang on 2016/11/28.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import "RiChengVC.h"

@interface RiChengVC ()

@property (nonatomic, weak) UITextField *textfield;
@property (nonatomic, strong) NSMutableArray *remarkArray;

@property (nonatomic, assign) int startBtnTag;
@property (nonatomic, assign) int endBtnTag;

@property (nonatomic, assign) int chooseDay;

@end

@implementation RiChengVC

- (NSMutableArray *)remarkArray
{
    if (!_remarkArray) {
        _remarkArray = [NSMutableArray array];
    }
    
    return _remarkArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"日程";
    
    self.startBtnTag = 0;
    self.endBtnTag = 0;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self drawView];
    [self initFootView];
    
    [self requestDataWithTime:(int)[[NSDate date] timeIntervalSince1970]];
    
    UIView *view = [self.view viewWithTag:1000];
    view.backgroundColor = [UIColor greenColor];
    self.chooseDay = [[NSDate date] timeIntervalSince1970];
}

-(void)drawView
{
    CGFloat LabelW = (ScreenWidth-40-2)/5;
    CGFloat LabelH = LabelW*0.8;
    CGFloat dayViewW = 80;
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(20, 0, ScreenWidth - 40, 100)];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.contentSize = CGSizeMake(dayViewW *7, 0);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    
    double time2 = [[NSDate date] timeIntervalSince1970] + 86400;
    double time3 = [[NSDate date] timeIntervalSince1970] + 86400 *2;
    double time4 = [[NSDate date] timeIntervalSince1970] + 86400 *3;
    double time5 = [[NSDate date] timeIntervalSince1970] + 86400 *4;
    double time6 = [[NSDate date] timeIntervalSince1970] + 86400 *5;
    double time7 = [[NSDate date] timeIntervalSince1970] + 86400 *6;
    
    NSDate *date2 = [NSDate dateWithTimeIntervalInMilliSecondSince1970:time2];
    NSDate *date3 = [NSDate dateWithTimeIntervalInMilliSecondSince1970:time3];
    NSDate *date4 = [NSDate dateWithTimeIntervalInMilliSecondSince1970:time4];
    NSDate *date5 = [NSDate dateWithTimeIntervalInMilliSecondSince1970:time5];
    NSDate *date6 = [NSDate dateWithTimeIntervalInMilliSecondSince1970:time6];
    NSDate *date7 = [NSDate dateWithTimeIntervalInMilliSecondSince1970:time7];
    
    UIView *dayView1 = [self creatDayViewWithDate:[NSDate date]];
    UIView *dayView2 = [self creatDayViewWithDate:date2];
    UIView *dayView3 = [self creatDayViewWithDate:date3];
    UIView *dayView4 = [self creatDayViewWithDate:date4];
    UIView *dayView5 = [self creatDayViewWithDate:date5];
    UIView *dayView6 = [self creatDayViewWithDate:date6];
    UIView *dayView7 = [self creatDayViewWithDate:date7];
    dayView1.tag = 1000;
    dayView2.tag = 1001;
    dayView3.tag = 1002;
    dayView4.tag = 1003;
    dayView5.tag = 1004;
    dayView6.tag = 1005;
    dayView7.tag = 1006;
    
    [scrollView sd_addSubviews:@[dayView1,dayView2,dayView3,dayView4,dayView5,dayView6,dayView7]];
    
    dayView1.sd_layout
    .leftSpaceToView(scrollView,0)
    .topSpaceToView(scrollView,0)
    .bottomSpaceToView(scrollView,0)
    .widthIs(dayViewW);
    
    dayView2.sd_layout
    .leftSpaceToView(dayView1,0)
    .topSpaceToView(scrollView,0)
    .bottomSpaceToView(scrollView,0)
    .widthIs(dayViewW);
    
    dayView3.sd_layout
    .leftSpaceToView(dayView2,0)
    .topSpaceToView(scrollView,0)
    .bottomSpaceToView(scrollView,0)
    .widthIs(dayViewW);
    
    dayView4.sd_layout
    .leftSpaceToView(dayView3,0)
    .topSpaceToView(scrollView,0)
    .bottomSpaceToView(scrollView,0)
    .widthIs(dayViewW);
    
    dayView5.sd_layout
    .leftSpaceToView(dayView4,0)
    .topSpaceToView(scrollView,0)
    .bottomSpaceToView(scrollView,0)
    .widthIs(dayViewW);
    
    dayView6.sd_layout
    .leftSpaceToView(dayView5,0)
    .topSpaceToView(scrollView,0)
    .bottomSpaceToView(scrollView,0)
    .widthIs(dayViewW);
    
    dayView7.sd_layout
    .leftSpaceToView(dayView6,0)
    .topSpaceToView(scrollView,0)
    .bottomSpaceToView(scrollView,0)
    .widthIs(dayViewW);
    
    
    UIView *LabelView = [[UIView alloc]init];
    LabelView.layer.borderWidth = 0.5;
    LabelView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.view addSubview:LabelView];
    
    UIView *view1 = [self createLineView];
    UIView *view2 = [self createLineView];
    UIView *view3 = [self createLineView];
    UIView *view4 = [self createLineView];
    UIView *view5 = [self createLineView];
    UIView *view6 = [self createLineView];
    UIView *view7 = [self createLineView];
    [LabelView sd_addSubviews:@[view1,view2,view3,view4,view5,view6,view7]];
    
    LabelView.sd_layout
    .leftSpaceToView(self.view,20).rightSpaceToView(self.view,20)
    .topSpaceToView(scrollView,10).heightIs(LabelH*4);
    
    view1.sd_layout.leftSpaceToView(LabelView,LabelW)
    .topSpaceToView(LabelView,0).bottomSpaceToView(LabelView,0).widthIs(0.5);
    
    view2.sd_layout.leftSpaceToView(view1,LabelW)
    .topSpaceToView(LabelView,0).bottomSpaceToView(LabelView,0).widthIs(0.5);
    
    view3.sd_layout.leftSpaceToView(view2,LabelW)
    .topSpaceToView(LabelView,0).bottomSpaceToView(LabelView,0).widthIs(0.5);
    
    view4.sd_layout.leftSpaceToView(view3,LabelW)
    .topSpaceToView(LabelView,0).bottomSpaceToView(LabelView,0).widthIs(0.5);
    
    view5.sd_layout.leftSpaceToView(LabelView,0)
    .topSpaceToView(LabelView,LabelH).rightSpaceToView(LabelView,0).heightIs(0.5);
    
    view6.sd_layout.leftSpaceToView(LabelView,0)
    .topSpaceToView(view5,LabelH).rightSpaceToView(LabelView,0).heightIs(0.5);
    
    view7.sd_layout.leftSpaceToView(LabelView,0)
    .topSpaceToView(view6,LabelH).rightSpaceToView(LabelView,0).heightIs(0.5);
    
    
    for(int i = 0; i< timeaArray.count; i++)
    {
        UIButton *timeBtn = [[UIButton alloc] init];
        [timeBtn setTitle:timeaArray[i] forState:UIControlStateNormal];
        [timeBtn setTitleColor:HEXCOLOR(0x333333) forState:UIControlStateNormal];
        timeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        timeBtn.backgroundColor = [UIColor clearColor];
        timeBtn.titleLabel.numberOfLines = 0;
        [timeBtn addTarget:self action:@selector(clickTap:) forControlEvents:UIControlEventTouchUpInside];
        timeBtn.tag = 100 + i;
        [LabelView addSubview:timeBtn];
        
        if(i<5) {
            timeBtn.frame = CGRectMake((LabelW + 0.5)*i, 0, LabelW, LabelH);
        }else if (i < 10){
            timeBtn.frame = CGRectMake((LabelW + 0.5)*(i-5), LabelH+0.5, LabelW, LabelH);
        }else if (i < 15) {
            timeBtn.frame = CGRectMake((LabelW + 0.5)*(i-10), (LabelH + 0.5)*2, LabelW, LabelH);
        }else {
            timeBtn.frame = CGRectMake((LabelW + 0.5)*(i-15), (LabelH + 0.5)*3, LabelW, LabelH);
        }
    }
    
    UILabel *beiLabel = [[UILabel alloc]init];
    beiLabel.textColor = HEXCOLOR(0x333333);
    beiLabel.font = TFont(13.0);
    beiLabel.text = @"备注:";
    
    UITextField *textfield = [[UITextField alloc]init];
    textfield.font = TFont(15);
    self.textfield = textfield;
    
    UIView *bottomView = [self createLineView];
    [self.view sd_addSubviews:@[beiLabel, textfield, bottomView]];
    
    beiLabel.sd_layout
    .topSpaceToView(LabelView,20)
    .leftSpaceToView(self.view,20)
    .widthIs(40).heightIs(20);
    
    textfield.sd_layout
    .topEqualToView(beiLabel)
    .leftSpaceToView(beiLabel,10)
    .rightSpaceToView(self.view,20)
    .heightIs(20);
    
    bottomView.sd_layout
    .topSpaceToView(beiLabel,2)
    .leftEqualToView(textfield)
    .rightEqualToView(textfield)
    .heightIs(0.5);
    
}

- (UIView *)creatDayViewWithDate:(NSDate *)date
{
    UIView *dayView = [[UIView alloc] init];
    
    UILabel *weekLabel = [[UILabel alloc] init];
    weekLabel.font = [UIFont systemFontOfSize:14];
    weekLabel.textColor = HEXCOLOR(0x333333);
    weekLabel.text = [NSDate getWeekdayWithDate:date];
    weekLabel.textAlignment = NSTextAlignmentCenter;
    [dayView addSubview:weekLabel];
    
    weekLabel.sd_layout
    .leftSpaceToView(dayView,0)
    .rightSpaceToView(dayView,0)
    .topSpaceToView(dayView,10)
    .autoHeightRatio(0);
    
    UILabel *dayLabel = [[UILabel alloc] init];
    dayLabel.font = [UIFont systemFontOfSize:20];
    dayLabel.textAlignment = NSTextAlignmentCenter;
    [dayView addSubview:dayLabel];
    
    dayLabel.sd_layout
    .centerXEqualToView(weekLabel)
    .bottomSpaceToView(dayView,10)
    .heightIs(40)
    .widthIs(40);
    
    
    if ([NSDate isSameDay:[NSDate date] date2:date])
    {
        dayLabel.text = @"今";
        dayLabel.textColor = COLOR_Orange;
        dayLabel.layer.borderWidth = 1;
        dayLabel.layer.borderColor = COLOR_Orange.CGColor;
        dayLabel.sd_cornerRadiusFromWidthRatio = @(0.5);
    }
    else
    {
        dayLabel.text = [NSDate getDayWithDate:date];
        dayLabel.textColor = HEXCOLOR(0x333333);
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickDay:)];
    [dayView addGestureRecognizer:tap];
    
    return dayView;
}

-(void)clickTap:(UIButton *)btn
{
    NSLog(@"--点了%ld",btn.tag);
    
    [self setTimeViewRed];
    
    btn.backgroundColor = [UIColor greenColor];
    [btn setTitleColor:HEXCOLOR(0x333333) forState:UIControlStateNormal];
    
    if (self.startBtnTag == 0)
    {
        self.startBtnTag = (int)btn.tag;
    }
    else if (self.endBtnTag == 0)
    {
        if (btn.tag < self.startBtnTag)
        {
            self.endBtnTag = self.startBtnTag;
            self.startBtnTag = (int)btn.tag;
        }
        else
        {
            self.endBtnTag = (int)btn.tag;
        }
    }
    else
    {
        self.startBtnTag = (int)btn.tag;
        self.endBtnTag = 0;
    }
    
    if (self.startBtnTag != 0)
    {
        UIButton *btnn = [self.view viewWithTag:self.startBtnTag];
        btnn.backgroundColor = [UIColor greenColor];
        [btnn setTitleColor:HEXCOLOR(0x333333) forState:UIControlStateNormal];
    }
    
    if (self.endBtnTag != 0)
    {
        UIButton *btnn = [self.view viewWithTag:self.endBtnTag];
        btnn.backgroundColor = [UIColor greenColor];
        [btnn setTitleColor:HEXCOLOR(0x333333) forState:UIControlStateNormal];
    }
    
    if (self.endBtnTag != 0 && self.startBtnTag != 0)
    {
        for (int i = self.startBtnTag + 1; i < self.endBtnTag; i ++)
        {
            UIButton *btnn = [self.view viewWithTag:i];
            btnn.backgroundColor = [UIColor greenColor];
            [btnn setTitleColor:HEXCOLOR(0x333333) forState:UIControlStateNormal];
        }
    }
}

- (void)clickDay:(UITapGestureRecognizer *)tap
{
    NSLog(@"--点了%ld",tap.view.tag);
    
    
    for (int i = 1000; i < 1007; i ++)
    {
        UIView *view = [self.view viewWithTag:i];
        view.backgroundColor = [UIColor clearColor];
    }
    
    UIView *view = [self.view viewWithTag:tap.view.tag];
    view.backgroundColor = [UIColor greenColor];
    
    double time = [[NSDate date] timeIntervalSince1970] + 86400 * (tap.view.tag - 1000);
    
    self.startBtnTag = 0;
    self.endBtnTag = 0;
    self.chooseDay = (int)time;
    
    [self requestDataWithTime:(int)time];
    
}

-(void)initFootView
{
    UIButton *button = [[UIButton alloc]init];
    button.backgroundColor = HEXCOLOR(0x1ba5d7);
    button.layer.cornerRadius = 5;
    [button setTitle:@"添加日程" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickSubmitButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    button.sd_layout
    .leftSpaceToView(self.view,20)
    .rightSpaceToView(self.view,20)
    .bottomSpaceToView(self.view, 70).heightIs(40);
}

-(void)clickSubmitButton {
    [self requestAddRiCheng];
}


-(UIView *)createLineView
{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor lightGrayColor];
    return view;
}

- (void)setTimeViewRed
{
    for (int i = 100; i < 120; i ++)
    {
        UIButton *btn = [self.view viewWithTag:i];
        btn.backgroundColor = [UIColor clearColor];
        [btn setTitleColor:HEXCOLOR(0x333333) forState:UIControlStateNormal];
    }
    
    for (NSString *str in self.remarkArray)
    {
        int tag = [str intValue] - 1 + 100;
        
        UIButton *btn = [self.view viewWithTag:tag];
        
        btn.backgroundColor = [UIColor redColor];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}

#pragma mark -
#pragma mark ================= 网络 =================
- (void)requestDataWithTime:(int)time
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@(time) forKey:@"time"];
    [params setValue:[ModelMember sharedMemberMySelf].memberId forKey:@"e_cd_id"];
    
    [[LQHTTPSessionManager sharedManager] LQPost:@"healthBooking/getHealthBookingForEmployeeSchedule" parameters:params showTips:@"正在加载..." success:^(id responseObject) {
        
        NSString *str = [responseObject valueForKey:@"remark"];
        
        self.remarkArray = [NSMutableArray array];
        if (str.length)
        {
            NSArray *array = [str componentsSeparatedByString:@","];
            [self.remarkArray addObjectsFromArray:array];
        }
        
        [self setTimeViewRed];
        
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)requestAddRiCheng
{
    if (self.startBtnTag == 0)
    {
        [LCProgressHUD showFailure:@"请选择时间段"];
        return;
    }
    else
    {
        if (self.endBtnTag == 0)
        {
            self.endBtnTag = self.startBtnTag;
        }
    }
    
    for (int i = self.startBtnTag ; i <= self.endBtnTag ; i ++)
    {
        for (NSString *str in self.remarkArray)
        {
            if ([str intValue]+100-1 == i)
            {
                [LCProgressHUD showMessage:@"你选择的时间段存在不可预约的时间,请重新选择"];
                return;
            }
        }
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@(self.chooseDay) forKey:@"dateTime"];
    [params setValue:@(self.startBtnTag - 100 + 1) forKey:@"startIndex"];
    [params setValue:@(self.endBtnTag - 100 + 1) forKey:@"endIndex"];
    [params setValue:[ModelMember sharedMemberMySelf].memberId forKey:@"e_id"];
    
    if (self.textfield.text.length) {
        [params setValue:self.textfield.text forKey:@"remark"];
    }
    
    [[LQHTTPSessionManager sharedManager] LQPost:@"employee/addHealthBookingForEmployee" parameters:params showTips:@"正在加载..." success:^(id responseObject) {
        
        self.textfield.text = @"";
        [self requestDataWithTime:self.chooseDay];
        
        [LCProgressHUD showSuccess:@"提交日程成功"];
        
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
}

@end
