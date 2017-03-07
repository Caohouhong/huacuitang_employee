//
//  MainTypeView.m
//  华粹堂-员工端
//
//  Created by 唐硕 on 16/11/24.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import "MainTypeView.h"
#import "MainTypeViewCell.h"
#import "MainTypeListViewCell.h"
#import "WoDeOneTypeCell.h"

#define Frame_Width       self.frame.size.width


@interface MainTypeView()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, weak) UIView *mainV;
@property (nonatomic, weak) UITableView *tableView;
@end
@implementation MainTypeView


//+(instancetype)shareInstance {
//    static MainTypeView *shareInstance = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        shareInstance = [[MainTypeView alloc]init];
//    });
//    [shareInstance showLeftView];
//    return shareInstance;
//    
//}

-(instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        //self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(clcikModel:) name:@"gaibian" object:nil];
        
        
        [self initViews];
        [self drawView];
    }
    return self;
}

-(void)clcikModel:(NSNotification *)not {
    NSLog(@"--%@", not.object);
    [self.tableView reloadData];
}


-(void)drawView {
    
    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableview.backgroundColor = backviewColor;
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.mainV addSubview:tableview];
    self.tableView = tableview;
    
    tableview.sd_layout.leftSpaceToView(self.mainV,0).rightSpaceToView(self.mainV,0)
    .topSpaceToView(self.mainV,0).bottomSpaceToView(self.mainV,0);
    
}

-(void)initViews {
    
    //筛选view
    UIView *mainV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Frame_Width, self.frame.size.height)];
    mainV.backgroundColor = backviewColor;
    [self addSubview:mainV];
    self.mainV = mainV;
}

-(void)clcikLeftView {
    
}

//-(void)hiddenLeftView {
//    [UIView animateWithDuration:0.2 animations:^{
//        self.mainV.x = -(ScreenWidth-80);
//        [self removeFromSuperview];
//    } completion:^(BOOL finished) {
//        [self removeFromSuperview];
//        if(self.oneBlock) {
//            self.oneBlock();
//        }
//    }];
//}

//-(void)showLeftView {
//    [UIView animateWithDuration:0.3 animations:^{
//        self.mainV.x = 0;
//    } completion:^(BOOL finished) {
//    }];
//}

#pragma mark - tableView 代理和数据源
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0) {
        WoDeOneTypeCell *cell = [WoDeOneTypeCell cellWithTableView:tableView];
        cell.model = [ModelMember sharedMemberMySelf];
        return cell;
    }
    MainTypeListViewCell *cell = [MainTypeListViewCell cellWithTableview:tableView];
    cell.nameLabel.text = titleArray[indexPath.row -1];
    cell.iconimageView.image = [UIImage imageNamed:titleArray[indexPath.row - 1]];
    if(indexPath.row == 2) {
        cell.arrowimageView.hidden = YES;
        cell.phoneLabel.text = @"0510-888888";
    }
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(self.oneBlock) {
        self.oneBlock(indexPath.row);
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0) {
        return 100;
    }
    return 55;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}


@end
