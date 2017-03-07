//
//  GuKeChooseView.m
//  华粹堂-员工端
//
//  Created by 李强 on 2017/2/16.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "GuKeChooseView.h"
#import "GuKeChooseTableViewCell.h"

@interface GuKeChooseView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;

@end

@implementation GuKeChooseView

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self =[super initWithFrame:frame])
    {
        [self drawView];
    }
    return self;
}

- (void)drawView
{
    
    self.dataArray = [NSMutableArray array];
    
    UIView *coverView = [[UIView alloc] init];
    coverView.backgroundColor = [UIColor blackColor];
    coverView.alpha = 0.5;
    [self addSubview:coverView];
    
    coverView.sd_layout
    .leftSpaceToView(self,0)
    .rightSpaceToView(self,0)
    .topSpaceToView(self,104)
    .bottomSpaceToView(self,0);
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = HEXCOLOR(0xeeeeee);
    [self addSubview:tableView];
    self.tableView = tableView;
    
    
    if (self.dataArray.count > 10) {
        tableView.sd_layout
        .leftSpaceToView(self,0)
        .rightSpaceToView(self,0)
        .topSpaceToView(self,104)
        .bottomSpaceToView(self,30);
    }else{
        tableView.sd_layout
        .leftSpaceToView(self,0)
        .rightSpaceToView(self,0)
        .topSpaceToView(self,104)
        .heightIs(30*self.dataArray.count);
    }
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [coverView addGestureRecognizer:tap];
}

- (void)setDataArray:(NSMutableArray *)dataArray
{
    _dataArray = dataArray;
    
    if (self.tableView)
    {
        if (dataArray.count > 10)
        {
            self.tableView.sd_resetLayout
            .leftSpaceToView(self,0)
            .rightSpaceToView(self,0)
            .topSpaceToView(self,104)
            .bottomSpaceToView(self,30);
        }
        else
        {
            self.tableView.sd_resetLayout
            .leftSpaceToView(self,0)
            .rightSpaceToView(self,0)
            .topSpaceToView(self,104)
            .heightIs(30*dataArray.count);
        }
        
        [self.tableView reloadData];
    }
}

- (void)tap
{
    self.hidden = YES;
}

#pragma mark -
#pragma mark ================= <UITableViewDelegate,UITableViewDataSource> =================
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GuKeChooseTableViewCell *cell = [GuKeChooseTableViewCell cellWithTableView:tableView];
    cell.titleLabel.text = self.dataArray[indexPath.row];
    return cell;
    
    return [UITableViewCell new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
