//
//  WriteSecretVC.m
//  华粹堂-员工端
//
//  Created by caohouhong on 17/3/9.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "WriteSecretVC.h"
#import "TTGroupTagView.h"
#import "HCTConnet.h"
#import "SecretModel.h"

@interface WriteSecretVC ()<UITableViewDelegate, UITableViewDataSource,TTGroupTagViewDelegate>
{
    UITextField *textField;
}
@property (strong, nonatomic) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *heightArray;

@property (nonatomic, strong) NSString *searchText;

@property (nonatomic, strong) SecretModel *model;



@end

@implementation WriteSecretVC

-(NSMutableArray *)dataArray
{
    if (!_dataArray){
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)heightArray
{
    if (!_heightArray){
        _heightArray = [NSMutableArray array];
    }
    return _heightArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = (self.type == WriteSecretViewTypeLife) ? @"私密生活" : @"私密话题";
    
    [self initView];
    [self initBottomView];
    [self requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)initView {
    
    UIView *topHoldView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 35)];
    topHoldView.backgroundColor = COLOR_BG_DARK_BLUE;
    [self.view addSubview:topHoldView];
    
    UILabel *textlabel = [[UILabel alloc] init];
    textlabel.text = (self.type == WriteSecretViewTypeLife) ? @"体现消费能力，情感交流信息" : @"喜欢什么，爱好什么，讨厌什么等等";
    textlabel.font = SYSTEM_FONT_(14);
    textlabel.textColor = COLOR_TEXT_DARK_BLUE;
    [self.view addSubview:textlabel];

    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableview.backgroundColor = [UIColor whiteColor];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableview];
    self.tableView = tableview;
    
    textlabel.sd_layout
    .leftEqualToView(self.view).offset(15)
    .topSpaceToView(self.view,0)
    .widthRatioToView(self.view,1)
    .heightIs(35);
    
    tableview.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(textlabel,0)
    .bottomSpaceToView(self.view,50);
}

- (void)initBottomView{
    UIView *bottomHoldView = [[UIView alloc] init];
    bottomHoldView.backgroundColor = [UIColor whiteColor];
    bottomHoldView.layer.borderWidth = 1;
    bottomHoldView.layer.borderColor = COLOR_LineViewColor.CGColor;
    [self.view addSubview:bottomHoldView];
    
    textField = [[UITextField alloc] init];
    textField.placeholder = (self.type == WriteSecretViewTypeLife) ? @"请填写私密生活" : @"请填写私密话题";
    textField.layer.borderWidth = 1;
    textField.layer.cornerRadius = 4;
    textField.font = SYSTEM_FONT_(14);
    textField.layer.borderColor = COLOR_LineViewColor.CGColor;
    [self.view addSubview:textField];
    
    UIButton *commitButton = [[UIButton alloc] init];
    commitButton.titleLabel.font = SYSTEM_FONT_(14);
    commitButton.layer.cornerRadius = 4;
    [commitButton setTitle:@"提交" forState:UIControlStateNormal];
    [commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [commitButton setBackgroundColor:COLOR_Text_Blue];
    [commitButton addTarget:self action:@selector(commitButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commitButton];
    
    bottomHoldView.sd_layout
    .leftEqualToView(self.view)
    .bottomEqualToView(self.view)
    .widthRatioToView(self.view,1)
    .heightIs(50);
    
    textField.sd_layout
    .leftSpaceToView(self.view,15)
    .rightSpaceToView(self.view,80)
    .bottomSpaceToView(self.view,5)
    .heightIs(40);
    
    commitButton.sd_layout
    .rightSpaceToView(self.view,15)
    .bottomSpaceToView(self.view,5)
    .widthIs(50)
    .heightIs(40);
}

#pragma mark - tableView 代理和数据源
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelSelectedTag)];
//    [cell.contentView addGestureRecognizer:tap];
    [cell.contentView addSubview:[self addHistoryViewTagsWithCGRect:CGRectMake(0, 0, ScreenWidth, 44) andIndex:indexPath]];
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 && self.heightArray.count > 0){
        return [self.heightArray.firstObject floatValue];
    }else {
        return 0;
    }
}

#pragma mark - 添加标签列表视图
- (TTGroupTagView *)addHistoryViewTagsWithCGRect:(CGRect)rect andIndex:(NSIndexPath *)indexPath{
    
    TTGroupTagView *tagView = [[TTGroupTagView alloc] initWithFrame:rect];
    tagView.tag = indexPath.section + 1000;
    tagView.translatesAutoresizingMaskIntoConstraints = YES;
    tagView.delegate = self;
    tagView.backgroundColor = [UIColor clearColor];
    
    if (self.dataArray.count > 0) {
        [tagView addTags:self.dataArray withCornerScale:0.1];
        
        [self.heightArray removeAllObjects];
        [self.heightArray addObject:[NSString stringWithFormat:@"%f", tagView.changeHeight]];
    }
    
    return tagView;
}

#pragma mark － =========== 网络 =================
- (void)requestData
{
    [LCProgressHUD showLoading:@"正在加载..."];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setValue:self.employeeModel.c_id forKey:@"customerId"];//顾客Id;
    [params setValue:(self.type == WriteSecretViewTypeLife) ? @(2) : @(1) forKey:@"tagType"]; //1-私密话题 2-私密生活
    
    [HCTConnet getSecretTopicVC:params success:^(id responseObject)  {
        
        NSArray *arry = [NSMutableArray arrayWithArray:[SecretModel mj_objectArrayWithKeyValuesArray:responseObject]];
        
        [self.dataArray removeAllObjects];
        
        for (SecretModel *model in arry){
            NSString *resultStr = [NSString stringWithFormat:@"%@｜%@",model.tagName, model.tagNum];
            
            [self.dataArray addObject:resultStr];
        }
        
        [self.tableView reloadData];
        
    } successBackfailError:^(ModelFieldError *responseObject) {
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}


#pragma mark - TTGroupTagViewDelegate 标签的点击事件
- (void)buttonClick:(NSString *)string and:(BOOL)isDelete
{
    
    NSRange range = [string rangeOfString:@"｜"];
    string = [string substringToIndex:range.location];
    textField.text = string;
    [self commitButtonAction];
}


//提交
- (void)commitButtonAction{
    
    [self.view endEditing:YES];
    
    if (textField.text.length < 1){
        [LCProgressHUD showFailure:@"请输入要提交的内容"];
        return;
    }
    
    [LCProgressHUD showLoading:@"正在加载..."];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:[ModelMember sharedMemberMySelf].memberId forKey:@"employeeId"];
    [params setValue:[ModelMember sharedMemberMySelf].name forKey:@"emplyoeeName"];//
    [params setValue:textField.text forKey:@"tagName"];//标签名字
    [params setValue:self.employeeModel.c_id forKey:@"customerId"];//顾客Id
    
    [params setValue:self.employeeModel.e_id forKey:@"trackManageId"];//调理记录ID(标记完成传的预约id)
    
    [params setValue:(self.type == WriteSecretViewTypeLife) ? @(2) : @(1) forKey:@"tagType"]; //1-私密话题 2-私密生活
    
    [HCTConnet getHomeAddCustomerTagV2:params success:^(id responseObject)  {
        
        textField.text = @"";
        
        [LCProgressHUD showSuccess:@"提交成功"];
        [self requestData];
        
    } successBackfailError:^(ModelFieldError *responseObject) {
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];

}
@end
