//
//  CommitTiaoLiSuccessVC.m
//  华粹堂-员工端
//
//  Created by liqiang on 2016/11/17.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import "CommitTiaoLiSuccessVC.h"

@interface CommitTiaoLiSuccessVC ()
@property (weak, nonatomic) IBOutlet UIButton *backBtn;

@end

@implementation CommitTiaoLiSuccessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = HEXCOLOR(0xeeeeee);
    
    self.backBtn.layer.cornerRadius = 5;
    
}

- (IBAction)backTiaoLi:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
