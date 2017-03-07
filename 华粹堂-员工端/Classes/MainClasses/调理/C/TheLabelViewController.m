//
//  TheLabelViewController.m
//  华粹堂-员工端
//
//  Created by 唐硕 on 16/11/25.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import "TheLabelViewController.h"
#import "JCTagListView.h"
#import "TheLabelModel.h"

@interface TheLabelViewController ()
@property (nonatomic, weak) JCTagListView *tagListView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, weak) UITextField *textfield;
@end

@implementation TheLabelViewController

-(NSMutableArray *)dataArray {
    if(_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self initData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"标签";
    
    //[self initData];
    [self initViews];
    [self footerViews];
}

-(void)initData {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:self.c_id forKey:@"customerId"];
    
    [[LQHTTPSessionManager sharedManager]LQPost:@"customer/listCustomerTags" parameters:params showTips:@"加载中..." success:^(id responseObject) {
        
        [self.dataArray removeAllObjects];
        
        self.textfield.text = @"";
        
        NSArray *Array = [TheLabelModel mj_objectArrayWithKeyValuesArray:responseObject];
        for(TheLabelModel *model in Array) {
            NSString *str = [NSString stringWithFormat:@"%@   %@", model.tagName,model.tagNum];
            [self.dataArray addObject:str];
        }
        [self.tagListView.tags removeAllObjects];
        [self.tagListView.tags addObjectsFromArray:self.dataArray];
        [self.tagListView.collectionView reloadData];
        
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
}

-(void)setNav {
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"删除" target:self action:@selector(remove)];
}

-(void)initViews {
    
    JCTagListView *tagVC = [[JCTagListView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-45)];
    [self.view addSubview:tagVC];
    self.tagListView = tagVC;
    
    //tagVC.canSelectTags = YES;
    tagVC.tagCornerRadius = 5.0f;
    
    //    NSArray *arr = @[@"美少女战士", @"百搭型", @"厉害了,我的哥", @"承认了,我的弟", @"UITapGestureRecognizer"];
    
    [tagVC.tags addObjectsFromArray:self.dataArray];
     [self.tagListView.collectionView reloadData];
    
    //    [tagVC setCompletionBlockWithSelected:^(NSInteger index) {
    //        NSLog(@"______%ld______", (long)index);
    //    }];
}

-(void)footerViews {
    UIView *footView = [[UIView alloc]init];
    footView.backgroundColor = backviewColor;
    [self.view addSubview:footView];
    
    footView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,0).heightIs(45);
    
    UIButton *button = [[UIButton alloc]init];
    button.backgroundColor = [UIColor redColor];
    button.titleLabel.font = TFont(14);
    button.layer.cornerRadius = 5;
    [button setTitle:@"提交" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:button];
    
    UITextField *textfield = [[UITextField alloc]init];
    textfield.placeholder = @"请输入标签";
    textfield.font = TFont(14);
    textfield.layer.cornerRadius = 5.0;
    textfield.layer.borderColor = [UIColor lightGrayColor].CGColor;
    textfield.layer.borderWidth = 1.0;
    [footView addSubview:textfield];
    self.textfield = textfield;
    
    button.sd_layout
    .rightSpaceToView(footView,10)
    .centerYEqualToView(footView)
    .widthIs(70).heightIs(30);
    
    textfield.sd_layout
    .leftSpaceToView(footView,10)
    .centerYEqualToView(footView)
    .rightSpaceToView(button,10)
    .heightIs(30);
    
}

-(void)clickButton {
    if(!self.textfield.text.length) {
        [LCProgressHUD showFailure:@"请输入标签"];
        return;
    }
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:[ModelMember sharedMemberMySelf].memberId forKey:@"employeeId"];
    [params setValue:[ModelMember sharedMemberMySelf].name forKey:@"emplyoeeName"];
    [params setValue:self.c_id forKey:@"customerId"];
    [params setValue:self.textfield.text forKey:@"tagName"];
    
    [[LQHTTPSessionManager sharedManager] LQPost:@"customer/addCustomerTag" parameters:params showTips:@"" success:^(id responseObject) {
        
        [self.view endEditing:YES];
        
        [self initData];
        
//        [self.navigationController popViewControllerAnimated:YES];
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSError *error) {

    }];
}

-(void)remove {
    
    if(!self.tagListView.selectedTags.count) {
        [LCProgressHUD showFailure:@"请选择要删除的标签"];
        return;
    }
    
    [self.tagListView.tags removeObjectsInArray:self.tagListView.selectedTags];
    [self.tagListView.selectedTags removeAllObjects];
    
    [self.tagListView.collectionView reloadData];
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
