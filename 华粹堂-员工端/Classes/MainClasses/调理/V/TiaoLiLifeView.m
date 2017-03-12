//
//  TiaoLiLifeView.m
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/27.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "TiaoLiLifeView.h"
#import "TiaoliOnceCellView.h"
#import "TiaoLiLiftTableViewCell.h"
#import "TiaoLiDetailView1.h"

@interface TiaoLiLifeView () <UITableViewDelegate, UITableViewDataSource>
{
    NSArray *titleArray;
    NSString *scoreStr;
    int totalScore;
    int aveScore;
    int num;
    
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) TiaoLiDetailView1 *footerView;
@property (nonatomic, strong) NSMutableArray *scoreArray;
@property (nonatomic, strong) UILabel *totalScoreLabel;
@end

@implementation TiaoLiLifeView
- (NSMutableArray *)scoreArray
{
    if (!_scoreArray){
        _scoreArray = [NSMutableArray arrayWithObjects:@"无效",@"无效",@"无效",@"无效",@"无效",@"无效",@"无效",@"无效",nil];
    }
    return _scoreArray;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){
        self.backgroundColor = COLOR_BackgroundColor;
        titleArray = @[@"1.药膳食疗：",@"2.睡眠休息：",@"3.家居理疗：",@"4.验方茶疗：",@"5.养元功法：",@"6.情志调理：",@"7.营养疗法：",@"8.配合用药建议："];
        [self initView];
        
    }
    return self;
}

- (void)initView
{
    [self initHeaderView];
    
    _footerView = [[TiaoLiDetailView1 alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 110)];
    _footerView.titleLabel.text = @"总体评价";
    _footerView.topTextView.placeholder = @"请填写总体评价";
    WEAK(weakSelf)
    _footerView.textBlock = ^(NSString *text){
        weakSelf.pingJiaStr = text;
        if (weakSelf.pingJiaBlock){
            weakSelf.pingJiaBlock(weakSelf.pingJiaStr);
        }
    };
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = HEXCOLOR(0xeeeeee);
    tableView.tableHeaderView = self.headerView;
    tableView.tableFooterView = self.footerView;
    [self addSubview:tableView];
    self.tableView = tableView;
    
    tableView.sd_layout
    .leftSpaceToView(self,0)
    .rightSpaceToView(self,0)
    .topSpaceToView(self,0)
    .bottomSpaceToView(self,0);
}

- (void)initHeaderView
{
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 160)];
    _headerView.backgroundColor = COLOR_BackgroundColor;
    
    TiaoliOnceCellView *planCell = [[TiaoliOnceCellView alloc] init];
    planCell.leftNameLabel.text = @"家居养生方案";
    [planCell.rightButton setTitle:@"查看" forState:UIControlStateNormal];
    [planCell.rightButton setTitleColor:COLOR_Text_Blue forState:UIControlStateNormal];
    [planCell.rightButton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:planCell];
    
    UIView *totalScoreView = [[UIView alloc] init];
    totalScoreView.backgroundColor = [UIColor whiteColor];
    [self.headerView addSubview:totalScoreView];
    
    UIButton *totalBtn = [[UIButton alloc] init];
    [totalBtn setImage:[UIImage imageNamed:@"g_mark_15x14"] forState:UIControlStateNormal];
    [totalBtn setTitle:@"总评分：" forState:UIControlStateNormal];
    totalBtn.titleLabel.font = SYSTEM_FONT_(14);
    [totalBtn setTitleColor:COLOR_Black forState:UIControlStateNormal];
    [totalScoreView addSubview:totalBtn];
    
    _totalScoreLabel = [[UILabel alloc] init];
    _totalScoreLabel.font = SYSTEM_FONT_(15);
    _totalScoreLabel.textAlignment = NSTextAlignmentRight;
    _totalScoreLabel.textColor = COLOR_TEXT_ORANGE_RED;
    [totalScoreView addSubview:_totalScoreLabel];
    
    UIView *explainView = [[UIView alloc] init];
    explainView.backgroundColor = COLOR_BG_DARK_BLUE;
    [self.headerView addSubview:explainView];
    
    UILabel *explainLabel1 = [[UILabel alloc] init];
    explainLabel1.text = @"总评分由以下8项计算评价所得：";
    explainLabel1.font = SYSTEM_FONT_(15);
    explainLabel1.textColor = COLOR_TEXT_DARK_BLUE;
    [explainView addSubview:explainLabel1];
    
    UILabel *explainLabel2 = [[UILabel alloc] init];
    explainLabel2.text = @"不选：不参加计算平均分；差：－100；一般：0；\n较好：60；好：100。";
    explainLabel2.font = SYSTEM_FONT_(14);
    explainLabel2.numberOfLines = 2;
    explainLabel2.textColor = COLOR_TEXT_DARK_BLUE;
    [explainView addSubview:explainLabel2];
    
    UIView *dividerLine1 = [[UIView alloc] init];
    dividerLine1.backgroundColor = COLOR_LineViewColor;
    [totalScoreView addSubview:dividerLine1];
    
    UIView *dividerLine2 = [[UIView alloc] init];
    dividerLine2.backgroundColor = COLOR_LineViewColor;
    [totalScoreView addSubview:dividerLine2];
    
    UIView *dividerLine3 = [[UIView alloc] init];
    dividerLine3.backgroundColor = COLOR_LineViewColor;
    [explainView addSubview:dividerLine3];
    
    planCell.sd_layout
    .leftEqualToView(self.headerView)
    .topSpaceToView(self.headerView,10)
    .widthRatioToView(self.headerView,1)
    .heightIs(37);
    
    totalScoreView.sd_layout
    .leftEqualToView(self.headerView)
    .topSpaceToView(planCell,10)
    .widthRatioToView(self.headerView,1)
    .heightIs(37);
    
    dividerLine1.sd_layout
    .leftEqualToView(totalScoreView)
    .topEqualToView(totalScoreView)
    .widthIs(ScreenWidth)
    .heightIs(1);
    
    dividerLine2.sd_layout
    .leftEqualToView(totalScoreView)
    .bottomEqualToView(totalScoreView)
    .widthIs(ScreenWidth)
    .heightIs(1);
    
    totalBtn.sd_layout
    .leftEqualToView(totalScoreView).offset(15)
    .centerYEqualToView(totalScoreView)
    .widthIs(85)
    .heightRatioToView(totalScoreView,1);
    
    _totalScoreLabel.sd_layout
    .rightEqualToView(totalScoreView).offset(-15)
    .centerYEqualToView(totalScoreView)
    .widthIs(85)
    .heightRatioToView(totalScoreView,1);
    
    explainView.sd_layout
    .leftEqualToView(self.headerView)
    .topSpaceToView(totalScoreView,0)
    .widthRatioToView(self.headerView,1)
    .heightIs(65);
    
    explainLabel1.sd_layout
    .leftEqualToView(explainView).offset(15)
    .topEqualToView(explainView)
    .widthRatioToView(explainView,1)
    .heightIs(25);
    
    explainLabel2.sd_layout
    .leftEqualToView(explainView).offset(15)
    .topSpaceToView(explainLabel1,0)
    .widthIs(ScreenWidth - 30)
    .heightIs(35);
    
    dividerLine3.sd_layout
    .leftEqualToView(explainView)
    .bottomEqualToView(explainView)
    .widthIs(ScreenWidth)
    .heightIs(1);
}

#pragma mark - ==== UITableViewDelegate,UITableViewDataSource ====
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TiaoLiLiftTableViewCell *cell = [TiaoLiLiftTableViewCell cellWithTableView:self.tableView];
    cell.tag = indexPath.row;
    cell.topPlanCell.leftNameLabel.text = titleArray[indexPath.row];
    WEAK(weakSelf);
    cell.cellBlock = ^(NSString *textStr, int row){
        [weakSelf.scoreArray replaceObjectAtIndex:row withObject:textStr];
        
        scoreStr = @"";
        totalScore = 0;
        num = 0;
        for (NSString *str in weakSelf.scoreArray){
           scoreStr =  [scoreStr stringByAppendingString:[NSString stringWithFormat:@"%@,",str]];
            
            if (![str isEqualToString:@"无效"]){
                int score = [str intValue];
                totalScore = score + totalScore;
                num++;
                aveScore = totalScore/num;
                self.totalScoreLabel.text = [NSString stringWithFormat:@"%i",aveScore];
            }
        };
        
        if(weakSelf.pingfenBlock){
            weakSelf.pingfenBlock([scoreStr copy]);
        };
    };
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}


//查看按钮
- (void)buttonClick{
    if(self.block){
        self.block();
    }
}
@end
