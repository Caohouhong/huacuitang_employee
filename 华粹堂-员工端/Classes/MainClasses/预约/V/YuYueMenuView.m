//
//  YuYueMenuView.m
//  华粹堂-员工端
//
//  Created by liqiang on 2016/11/25.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import "YuYueMenuView.h"
#import "YuYueDateChooseVC.h"

@interface YuYueMenuView()
//required

@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIView *showView;
@property (nonatomic, weak) UILabel *dateLabel;

@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;

@end

@implementation YuYueMenuView

NSInteger menuViewWith = 200;

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self drawView];
    }
    
    return self;
}

- (void)drawView
{
    self.isRightViewHidden = YES;
    
    _maskView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _maskView.backgroundColor = [UIColor blackColor];
    _maskView.alpha = 0;
    [self addSubview:_maskView];
    
    _maskView.sd_layout
    .leftSpaceToView(self,0)
    .topSpaceToView(self,0)
    .bottomSpaceToView(self,0)
    .rightSpaceToView(self,0);
    
    UIView *showView = [[UIView alloc] init];
    showView.backgroundColor = [UIColor whiteColor];
    [self addSubview:showView];
    self.showView = showView;
    
    showView.sd_layout
    .rightSpaceToView(self,0)
    .topSpaceToView(self,0)
    .bottomSpaceToView(self,0)
    .widthIs(menuViewWith);
    
    [self addRecognizer];
    [self drawShowView];
}

- (void)drawShowView
{
    UILabel *shaXuanLabel = [[UILabel alloc] init];
    shaXuanLabel.font = [UIFont systemFontOfSize:14];
    shaXuanLabel.textColor = HEXCOLOR(0x333333);
    shaXuanLabel.text = @"筛选";
    shaXuanLabel.textAlignment = NSTextAlignmentCenter;
    [self.showView addSubview:shaXuanLabel];
    
    shaXuanLabel.sd_layout
    .leftSpaceToView(self.showView,0)
    .rightSpaceToView(self.showView,0)
    .topSpaceToView(self.showView,20)
    .heightIs(45);
    
    UIView *lineView1 = [[UIView alloc] init];
    lineView1.backgroundColor = HEXCOLOR(0xeeeeee);
    [self.showView addSubview:lineView1];
    
    lineView1.sd_layout
    .leftSpaceToView(self.showView,0)
    .rightSpaceToView(self.showView,0)
    .topSpaceToView(shaXuanLabel,0)
    .heightIs(0.5);
    
    UITextField *nameSearchTextfield = [[UITextField alloc] init];
    nameSearchTextfield.placeholder = @"搜索人名";
    nameSearchTextfield.font = [UIFont systemFontOfSize:14];
    nameSearchTextfield.borderStyle = UITextBorderStyleRoundedRect;
    [self.showView addSubview:nameSearchTextfield];
    self.nameSearchTextfield = nameSearchTextfield;
    
    nameSearchTextfield.sd_layout
    .leftSpaceToView(self.showView,15)
    .rightSpaceToView(self.showView,15)
    .topSpaceToView(lineView1,15)
    .heightIs(35);
    
    UILabel *dateLabel = [[UILabel alloc] init];
    dateLabel.font = [UIFont systemFontOfSize:14];
    dateLabel.textColor = HEXCOLOR(0x333333);
    dateLabel.text = @"选择的日期：";
    [self.showView addSubview:dateLabel];
    self.dateLabel = dateLabel;
    
    dateLabel.sd_layout
    .leftEqualToView(nameSearchTextfield)
    .rightEqualToView(nameSearchTextfield)
    .topSpaceToView(nameSearchTextfield,10)
    .autoHeightRatio(0);
    
    for (int i = 0; i<9; i++)
    {
        UIButton *dateBtn = [[UIButton alloc] init];
        [dateBtn setTitleColor:HEXCOLOR(0x333333) forState:UIControlStateNormal];
        dateBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [dateBtn setBackgroundColor:[UIColor clearColor]];
        dateBtn.tag = i + 100;
        [dateBtn addTarget:self action:@selector(didClickDateBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.showView addSubview:dateBtn];
        
        if (i == 0)
        {
            dateBtn.sd_layout
            .leftSpaceToView(self.showView,15)
            .topSpaceToView(dateLabel,15)
            .widthIs((menuViewWith - 50)/3)
            .heightEqualToWidth();
        }else{
            if (i%3 == 0)
            {
                UIButton *btn = [self.showView viewWithTag:i + 100 - 3];
                
                dateBtn.sd_layout
                .leftEqualToView(btn)
                .topSpaceToView(btn,10)
                .widthRatioToView(btn,1)
                .heightRatioToView(btn,1);
            }
            else
            {
                UIButton *btn = [self.showView viewWithTag:i + 100 - 1];
                
                dateBtn.sd_layout
                .leftSpaceToView(btn,10)
                .topEqualToView(btn)
                .widthRatioToView(btn,1)
                .heightRatioToView(btn,1);
            }
        }
        
        if (i == 0)
        {
            long time = [[NSDate date] timeIntervalSince1970] - 86400;
            NSString *dateStr = [NSDate dateWithTimeStamp:time dateFormat:@"MM-dd"];
            [dateBtn setTitle:dateStr forState:UIControlStateNormal];
        }
        else
        {
            long time = [[NSDate date] timeIntervalSince1970] - 86400 + 86400*i;
            NSString *dateStr = [NSDate dateWithTimeStamp:time dateFormat:@"MM-dd"];
            [dateBtn setTitle:dateStr forState:UIControlStateNormal];
        }
    }
    
    UIButton *moreBtn = [[UIButton alloc] init];
    [moreBtn setTitle:@"更多" forState:UIControlStateNormal];
    [moreBtn setTitleColor:HEXCOLOR(0x333333) forState:UIControlStateNormal];
    moreBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    moreBtn.backgroundColor = [UIColor clearColor];
    [moreBtn addTarget:self action:@selector(didClickMore) forControlEvents:UIControlEventTouchUpInside];
    [self.showView addSubview:moreBtn];
    
    UIImageView *arrowImageView = [[UIImageView alloc] init];
    arrowImageView.image = [UIImage imageNamed:@"advance"];
    [self.showView addSubview:arrowImageView];
    
    UIButton *cancelBtn = [[UIButton alloc] init];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:HEXCOLOR(0x333333) forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    cancelBtn.backgroundColor = [UIColor clearColor];
    [cancelBtn addTarget:self action:@selector(didClickCancle) forControlEvents:UIControlEventTouchUpInside];
    [self.showView addSubview:cancelBtn];
    
    UIButton *sureBtn = [[UIButton alloc] init];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    sureBtn.backgroundColor = [UIColor redColor];
    [sureBtn addTarget:self action:@selector(didClickSure) forControlEvents:UIControlEventTouchUpInside];
    [self.showView addSubview:sureBtn];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = HEXCOLOR(0xeeeeee);
    [self.showView addSubview:lineView];
    
    UIButton *btn = [self.showView viewWithTag:6+ 100];
    arrowImageView.sd_layout
    .rightSpaceToView(self.showView,15)
    .topSpaceToView(btn,15)
    .widthIs(8)
    .heightIs(16);
    
    moreBtn.sd_layout
    .rightSpaceToView(arrowImageView,0)
    .centerYEqualToView(arrowImageView)
    .widthIs(80)
    .heightIs(40);
    
    cancelBtn.sd_layout
    .leftSpaceToView(self.showView,0)
    .bottomSpaceToView(self.showView,0)
    .widthIs(menuViewWith/2)
    .heightIs(45);
    
    sureBtn.sd_layout
    .leftSpaceToView(cancelBtn,0)
    .bottomSpaceToView(self.showView,0)
    .widthIs(menuViewWith/2)
    .heightIs(45);
    
    lineView.sd_layout
    .leftSpaceToView(self.showView,0)
    .bottomSpaceToView(cancelBtn,0)
    .rightSpaceToView(self.showView,0)
    .heightIs(0.5);
}

- (void)didClickDateBtn:(UIButton *)btn
{
    for (int i = 100; i < 109 ; i++) {
        UIButton *btn = [self.showView viewWithTag:i];
        btn.backgroundColor = [UIColor clearColor];
    }
    
    btn.backgroundColor = [UIColor greenColor];
    
    long time = [[NSDate date] timeIntervalSince1970] - 86400 + 86400*(btn.tag - 100);
    NSString *dateStr = [NSDate dateWithTimeStamp:time dateFormat:@"MM-dd"];
    self.dateLabel.text = [NSString stringWithFormat:@"选择的日期：%@",dateStr];
    
    NSDate *date = [NSDate dateWithTimeIntervalInMilliSecondSince1970:time];
    self.startDate = date;
    self.endDate = date;
}

- (void)didClickMore
{
    YuYueDateChooseVC *vc = [[YuYueDateChooseVC alloc] init];
    [DCURLRouter pushViewController:vc animated:YES];
    
    @weakify(self);
    vc.didClickDateBlock = ^(NSDate *startDate,NSDate*endDate){
        @strongify(self);
        self.startDate = startDate;
//        self.endDate = endDate;
        
        NSString *dateStr1 = [NSDate dateStringWithTimeDate:startDate dateFormat:@"yyyy-MM-dd"];
////        NSString *dateStr2 = [NSDate dateStringWithTimeDate:endDate dateFormat:@"yyyy-MM-dd"];
//        
//        self.dateLabel.text = [NSString stringWithFormat:@"选择的日期：%@~%@",dateStr1,dateStr2];
        
        self.dateLabel.text = [NSString stringWithFormat:@"选择的日期：%@",dateStr1];
        
        for (int i = 100; i < 109 ; i++) {
            UIButton *btn = [self.showView viewWithTag:i];
            btn.backgroundColor = [UIColor clearColor];
        }
    };
}

- (void)didClickCancle
{
    [self closeLeftView];
}

- (void)didClickSure
{
    if (self.didClickDateBlick) {
        self.didClickDateBlick(self.startDate,self.endDate);
    }
    
    [self closeLeftView];
}

#pragma mark - UIPanGestureRecognizer
-(void)addRecognizer
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeLeftViewEvent:)];
    [_maskView addGestureRecognizer:tap];
    
}

-(void)closeLeftViewEvent:(UITapGestureRecognizer *)recognizer
{
    [self closeLeftView];
}

/**
 *  关闭左视图
 */
- (void)closeLeftView{
    
    NSLog(@"closeLeftView");
    [UIView animateWithDuration:0.3 animations:^{
        
        self.frame = CGRectMake(ScreenWidth, 0, ScreenWidth, ScreenHeight2);
        self.isRightViewHidden = YES;
        _maskView.alpha = 0;
    }];
    
}

- (void)openLeftView
{
    NSLog(@"openLeftView");
    [UIView animateWithDuration:0.3 animations:^{
        
        self.frame = CGRectMake(0 , 0, ScreenWidth, ScreenHeight2);
        self.isRightViewHidden = NO;
        _maskView.alpha = 0.5;
    } completion:^(BOOL finished) {
    }];
}

- (void)UpdateUserData:(NSNotification *)notify{
    
    NSLog(@"UpdateUserData");
}

- (void)changeHeaderImage{
    
    NSLog(@"changeHeaderImage");
}

- (void)AddAction{
    
    NSLog(@"AddAction");
    if (_menuViewDelegate) {
        [_menuViewDelegate LeftMenuViewActionIndex:@"AddAction"];
    }
}

@end
