//
//  TSyuyueController.m
//  华粹堂-员工端
//
//  Created by 唐硕 on 16/11/24.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import "TSyuyueController.h"

@interface TSyuyueController ()

@end

@implementation TSyuyueController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"预约记录";
    
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"calendar"] style:UIBarButtonItemStylePlain target:self action:@selector(didClickRightBar)];
    self.navigationItem.rightBarButtonItem = rightBar;

}

-(void)didClickRightBar {
    
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
