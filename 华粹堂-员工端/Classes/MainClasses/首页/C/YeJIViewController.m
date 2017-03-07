//
//  YeJIViewController.m
//  华粹堂-员工端
//
//  Created by 唐硕 on 16/11/24.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import "YeJIViewController.h"
#import "YeJiTableViewCell.h"

@interface YeJIViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) UITableView  *tableView;
@end

@implementation YeJIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"计划";
    [self drawView];
}

- (void)drawView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = HEXCOLOR(0xeeeeee);
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    tableView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,0);
}


#pragma mark - tableView 代理和数据源
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YeJiTableViewCell *cell = [YeJiTableViewCell cellWithTableview:tableView];
    if(indexPath.row == 0) {
        cell.numLabel.text = [NSString stringWithFormat:@"%@",[UserDefaults valueForKey:@"serve_count"]];
    }else if (indexPath.row == 1) {
        cell.numLabel.text = [NSString stringWithFormat:@"%@",[UserDefaults valueForKey:@"money_in_sum"]];
    }else {
       cell.numLabel.text = [NSString stringWithFormat:@"%@",[UserDefaults valueForKey:@"money_out_sum"]];
    }
    return cell;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    return <#expression#>
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return <#expression#>
//}
//
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
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
