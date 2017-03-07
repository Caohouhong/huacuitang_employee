//
//  GuKeView1.m
//  华粹堂-员工端
//
//  Created by 唐硕 on 16/11/29.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import "GuKeView1.h"
#import "MyKaModel.h"
#import "MyKaXinModel.h"
#import "MyKaXinCell.h"
#import "MyKaXiangCell.h"
#import "MyKaXinController.h"

#define titleArray @[@"客户信息",@"气医档案",@"客户追踪",@"复诊追踪",@"回访信息",@"体检报告",@"月度总结",@"全年度总结",@"年度总结",@"卡项",@"消费明细"]
#define URLStr @[@"http://139.129.218.121:8081/CZ/applogin/appMain?tel=13665196755&cid=23&type=0",@"http://139.129.218.121:8081/CZ/applogin/appMain?tel=13665196755&cid=23&type=1",@"http://139.129.218.121:8081/CZ/applogin/appMain?tel=13665196755&cid=23&type=2",@"http://139.129.218.121:8081/CZ/applogin/appMain?tel=13665196755&cid=23&type=5",@"http://139.129.218.121:8081/CZ/applogin/appMain?tel=13665196755&cid=23&type=3",@"http://139.129.218.121:8081/CZ/applogin/appMain?tel=13665196755&cid=23&type=6",@"http://139.129.218.121:8081/CZ/applogin/appMain?tel=13665196755&cid=23&type=4",@"http://139.129.218.121:8081/CZ/applogin/appMain?tel=13665196755&cid=23&type=7",@"http://139.129.218.121:8081/CZ/applogin/appMain?tel=13665196755&cid=23&type=8",@"http://139.129.218.121:8081/CZ/applogin/appMain?tel=13665196755&cid=23&type=0",@"http://139.129.218.121:8081/CZ/applogin/appMain?tel=13665196755&cid=23&type=0"]


@interface GuKeView1()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UIImageView *iconImageView;
@property (nonatomic, weak) UILabel *shopNameLabel;
@property (nonatomic, weak) UILabel *orderNumLabel;
@property (nonatomic, weak) UILabel *sheJiShiNameLabel;
@property (nonatomic, weak) UILabel *yuYueDateLabel;
@property (nonatomic, weak) UILabel *stateLabel;
@property (nonatomic, weak) UIWebView *web;
@property (nonatomic, weak) UIView *lineView;
@property (nonatomic, weak) UIScrollView *headScro;

@property (nonatomic, strong ) NSMutableArray *dataArray;
@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, assign) int pageNo;

@end
@implementation GuKeView1



-(instancetype)initWithFrame:(CGRect)frame {
    if(self =[super initWithFrame:frame]) {
        
        self.pageNo = 1;
        
        
        [self initView];
    }
    return self;
}

-(void)tap
{
    NSLog(@"点了电话");
    if(self.block) {
        self.block();
    }
}



-(void)initView {
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 90)];
    [self addSubview:headerView];
    
    UIImageView *iconImageView = [[UIImageView alloc] init];
    //iconImageView.image = [UIImage imageNamed:@"default"];
    iconImageView.image = [UIImage imageNamed:@"touxiang"];
    [headerView addSubview:iconImageView];
    self.iconImageView = iconImageView;
    
    UILabel *shopNameLabel = [[UILabel alloc] init];
    shopNameLabel.font = [UIFont systemFontOfSize:14];
    shopNameLabel.textColor = HEXCOLOR(0x333333);
    shopNameLabel.text = @"大强哥";
    [headerView addSubview:shopNameLabel];
    self.shopNameLabel = shopNameLabel;
    
    UILabel *sheJiShiNameLabel = [[UILabel alloc] init];
    sheJiShiNameLabel.font = [UIFont systemFontOfSize:13];
    sheJiShiNameLabel.textColor = HEXCOLOR(0x333333);
    sheJiShiNameLabel.text = @"女 35岁";
    [headerView addSubview:sheJiShiNameLabel];
    self.sheJiShiNameLabel = sheJiShiNameLabel;
    
//    UIImageView *telImageView = [[UIImageView alloc] init];
//    telImageView.image = [UIImage imageNamed:@"telephone"];
//    telImageView.contentMode = UIViewContentModeScaleAspectFit;
//    telImageView.userInteractionEnabled = YES;
//    [headerView addSubview:telImageView];
//    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
//    [telImageView addGestureRecognizer:tap];
    
    UIButton *BQButton = [[UIButton alloc]init];
    [BQButton setTitle:@"标签" forState:UIControlStateNormal];
    [BQButton setTitleColor:HEXCOLOR(0xe44751) forState:UIControlStateNormal];
    BQButton.titleLabel.font = TFont(13.0);
    BQButton.layer.cornerRadius = 3.0;
    BQButton.layer.borderColor = HEXCOLOR(0xe44751).CGColor;
    BQButton.layer.borderWidth = 0.5;
    [BQButton addTarget:self action:@selector(tap) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:BQButton];
    
    UILabel *yuYueDateLabel = [[UILabel alloc] init];
    yuYueDateLabel.font = [UIFont systemFontOfSize:12];
    yuYueDateLabel.textColor = HEXCOLOR(0x333333);
    yuYueDateLabel.text = @"最近消费时间：2016年11月11日 10:12";
    [headerView addSubview:yuYueDateLabel];
    self.yuYueDateLabel = yuYueDateLabel;
    
    UIScrollView *headScro = [[UIScrollView alloc] init];
    headScro.contentSize = CGSizeMake(880, 0);
    headScro.showsHorizontalScrollIndicator = NO;
    [self addSubview:headScro];
    self.headScro = headScro;
    
    for (int i = 0; i <titleArray.count; i++)
    {
        UIButton *btn = [[UIButton alloc] init];
        [btn setTitle:titleArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:HEXCOLOR(0x333333) forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.backgroundColor = [UIColor clearColor];
        btn.tag = i + 1000;
        [btn addTarget:self action:@selector(didClickHeadBtn:) forControlEvents:UIControlEventTouchUpInside];
        [headScro addSubview:btn];
        
        if (i == 0)
        {
            btn.sd_layout
            .leftSpaceToView(headScro,0)
            .topSpaceToView(headScro,0)
            .bottomSpaceToView(headScro,0)
            .widthIs(80);
        }
        else
        {
            UIButton *lastBtn = [headScro viewWithTag:i + 1000 - 1];
            
            btn.sd_layout
            .leftSpaceToView(lastBtn,0)
            .topSpaceToView(headScro,0)
            .bottomSpaceToView(headScro,0)
            .widthIs(80);
        }
    }
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor redColor];
    [headScro addSubview:lineView];
    self.lineView = lineView;
    
    
    iconImageView.sd_layout
    .leftSpaceToView(headerView,20)
    .centerYEqualToView(headerView)
    .widthIs(70)
    .heightIs(70);
    iconImageView.sd_cornerRadiusFromWidthRatio = @(0.5);
    
    shopNameLabel.sd_layout
    .leftSpaceToView(iconImageView,15)
    .topEqualToView(iconImageView)
    .heightIs(20)
    .widthIs(70);
    
    yuYueDateLabel.sd_layout
    .leftEqualToView(shopNameLabel)
    .bottomEqualToView(iconImageView)
    //.rightSpaceToView(headerView,15)
    .heightIs(15);
    [yuYueDateLabel setSingleLineAutoResizeWithMaxWidth:250];
    
    
    sheJiShiNameLabel.sd_layout
    .leftEqualToView(yuYueDateLabel)
    .bottomSpaceToView(yuYueDateLabel,10)
    .heightIs(15);
    [sheJiShiNameLabel setSingleLineAutoResizeWithMaxWidth:250];
    
    BQButton.sd_layout
    .rightEqualToView(yuYueDateLabel)
    .centerYEqualToView(shopNameLabel)
    .widthIs(50).heightIs(18);
    
    headScro.sd_layout
    .topSpaceToView(headerView,0)
    .leftSpaceToView(self,0)
    .rightSpaceToView(self,0)
    .heightIs(45);
    
    UIButton *btn = [headScro viewWithTag:1000];
    lineView.sd_layout
    .bottomSpaceToView(headScro,0)
    .widthIs(70)
    .centerXEqualToView(btn)
    .heightIs(2);
    
    for (int i = 0; i < titleArray.count; i ++)
    {
        if ([titleArray[i] isEqualToString:@"卡项"])
        {
            [self drawKaXiangView];
        }
        else
        {
            UIWebView *web = [[UIWebView alloc] init];
            web.tag = 10000+i;
            web.hidden = YES;
            [self addSubview:web];
            
            web.sd_layout
            .leftSpaceToView(self,5)
            .topSpaceToView(headScro,5)
            .bottomSpaceToView(self,5)
            .rightSpaceToView(self,5);
            
            NSString *urlStr ;
            switch (i) {
                case 0:
                {
                    urlStr = [NSString stringWithFormat:@"http://139.129.218.121:8081/CZ/applogin/appMain?tel=%@&cid=%@&type=0",self.model.mobile_phone,self.model.sid];
                }
                    break;
                case 1:
                {
                    urlStr = [NSString stringWithFormat:@"http://139.129.218.121:8081/CZ/applogin/appMain?tel=%@&cid=%@&type=1",self.model.mobile_phone,self.model.sid];
                }
                    break;
                case 2:
                {
                    urlStr = [NSString stringWithFormat:@"http://139.129.218.121:8081/CZ/applogin/appMain?tel=%@&cid=%@&type=2",self.model.mobile_phone,self.model.sid];
                }
                    break;
                case 3:
                {
                    urlStr = [NSString stringWithFormat:@"http://139.129.218.121:8081/CZ/applogin/appMain?tel=%@&cid=%@&type=5",self.model.mobile_phone,self.model.sid];
                }
                    break;
                case 4:
                {
                    urlStr = [NSString stringWithFormat:@"http://139.129.218.121:8081/CZ/applogin/appMain?tel=%@&cid=%@&type=3",self.model.mobile_phone,self.model.sid];
                }
                    break;
                case 5:
                {
                    urlStr = [NSString stringWithFormat:@"http://139.129.218.121:8081/CZ/applogin/appMain?tel=%@&cid=%@&type=6",self.model.mobile_phone,self.model.sid];
                }
                    break;
                case 6:
                {
                    urlStr = [NSString stringWithFormat:@"http://139.129.218.121:8081/CZ/applogin/appMain?tel=%@&cid=%@&type=4",self.model.mobile_phone,self.model.sid];
                }
                    break;
                case 7:
                {
                    urlStr = [NSString stringWithFormat:@"http://139.129.218.121:8081/CZ/applogin/appMain?tel=%@&cid=%@&type=7",self.model.mobile_phone,self.model.sid];
                }
                    break;
                case 8:
                {
                    urlStr = [NSString stringWithFormat:@"http://139.129.218.121:8081/CZ/applogin/appMain?tel=%@&cid=%@&type=8",self.model.mobile_phone,self.model.sid];
                }
                    break;
                case 10:
                {
                    urlStr = [NSString stringWithFormat:@"http://139.129.218.121:8081/CZ/applogin/appMain?tel=%@&cid=%@&type=3",self.model.mobile_phone,self.model.sid];
                }
                    break;
                    
                default:
                    break;
            }
            
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URLStr[i]]];
            [web loadRequest:request];
        }
    }
    
    UIView *web = [self viewWithTag:10000];
    web.hidden = NO;
}

- (void)drawKaXiangView
{
    UIView *kaxiangView = [[UIView alloc] init];
    kaxiangView.tag = 10009;
    kaxiangView.hidden = YES;
    [self addSubview:kaxiangView];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    [kaxiangView addSubview:tableView];
    self.tableView = tableView;
    
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefersh)];
    tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefersh)];

    
    tableView.sd_layout
    .leftSpaceToView(kaxiangView,0)
    .rightSpaceToView(kaxiangView,0)
    .topSpaceToView(kaxiangView,0)
    .bottomSpaceToView(kaxiangView,0);
    
    
    kaxiangView.sd_layout
    .leftSpaceToView(self,5)
    .topSpaceToView(self.headScro,5)
    .bottomSpaceToView(self,5)
    .rightSpaceToView(self,5);
}

-(void)headerRefersh {
    self.pageNo = 1;
    [self initData];
}

-(void)footerRefersh {
    self.pageNo++;
    [self initData];
}

-(void)setModel:(ModelGuKe *)model {
    
    _model = model;
    [self initData];
    
    NSLog(@"----%@", model.sid);
    
    
    [self.iconImageView sd_setImageWithURL:IMAGE_URL(model.portrait) placeholderImage:[UIImage imageNamed:@"touxiang"]];
    self.shopNameLabel.text = model.name;
    self.yuYueDateLabel.text = [NSString stringWithFormat:@"最近消费时间: %@",model.last_consume_time];
    if([model.sex isEqualToString:@"1"]) {
        self.sheJiShiNameLabel.text = [NSString stringWithFormat:@"女 %@岁",model.customerAge];
    }else {
        self.sheJiShiNameLabel.text = [NSString stringWithFormat:@"男 %@岁",model.customerAge];
    }
}

- (void)setUrlStr:(NSString *)urlStr
{
    _urlStr = urlStr;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [self.web loadRequest:request];
}


- (void)didClickHeadBtn:(UIButton *)btn
{
    for (int i = 10000; i < 10011; i ++)
    {
        UIView *view = [self viewWithTag:i];
        view.hidden = YES;
    }
    
    if(btn.tag == 1000) {
        NSLog(@"1");
        UIView *view = [self viewWithTag:10000];
        view.hidden = NO;
    }else if (btn.tag == 1001) {
        NSLog(@"2");
        UIView *view = [self viewWithTag:10001];
        view.hidden = NO;
    }else if (btn.tag == 1002) {
        NSLog(@"3");
        UIView *view = [self viewWithTag:10002];
        view.hidden = NO;
    }else if (btn.tag == 1003) {
        NSLog(@"4");
        UIView *view = [self viewWithTag:10003];
        view.hidden = NO;
    }else if (btn.tag == 1004) {
        NSLog(@"5");
        UIView *view = [self viewWithTag:10004];
        view.hidden = NO;
    }else if (btn.tag == 1005) {
        NSLog(@"6");
        UIView *view = [self viewWithTag:10005];
        view.hidden = NO;
    }else if (btn.tag == 1006) {
        NSLog(@"7");
        UIView *view = [self viewWithTag:10006];
        view.hidden = NO;
    }else if (btn.tag == 1007) {
        NSLog(@"8");
        UIView *view = [self viewWithTag:10007];
        view.hidden = NO;
    }else if (btn.tag == 1008) {
        NSLog(@"9");
        UIView *view = [self viewWithTag:10008];
        view.hidden = NO;
    }else if (btn.tag == 1009) {
        NSLog(@"9");
        UIView *view = [self viewWithTag:10009];
        view.hidden = NO;
    }else if (btn.tag == 1010) {
        NSLog(@"9");
        UIView *view = [self viewWithTag:10010];
        view.hidden = NO;
    }
    
    self.lineView.sd_resetLayout
    .bottomSpaceToView(btn.superview,0)
    .widthIs(70)
    .centerXEqualToView(btn)
    .heightIs(2);
}

////数据请求
-(void)initData {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:self.model.sid forKey:@"c_id"];
    [params setValue:@(self.pageNo) forKey:@"pageNo"];
    [params setValue:@(20) forKey:@"pageSize"];
    
    [[LQHTTPSessionManager sharedManager] LQPost:@"customer/listVipCards" parameters:params showTips:@"加载中..." success:^(id responseObject) {
        
        self.dataArray = [NSMutableArray arrayWithArray:[MyKaModel mj_objectArrayWithKeyValuesArray:[responseObject valueForKey:@"data"]]];
        
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
        
        if (self.dataArray.count < 20)
        {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
        
    } successBackfailError:^(id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
    }];
    
}
#pragma mark -
#pragma mark ================= <UITableViewDelegate,UITableViewDataSource> =================
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyKaXiangCell *cell = [MyKaXiangCell cellWithTableView:tableView];
    cell.model = self.dataArray[indexPath.section];
    return cell;
    
    return [UITableViewCell new];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyKaModel *model = self.dataArray[indexPath.section];
    MyKaXinController *kaVC = [[MyKaXinController alloc]init];
    kaVC.model = model;
    [DCURLRouter pushViewController:kaVC animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}



@end
