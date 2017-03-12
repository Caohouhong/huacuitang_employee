//
//  JumpVC.m
//  华粹堂-员工端
//
//  Created by baichun on 17/3/7.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "JumpVC.h"

@interface JumpVC ()
@property (nonatomic, strong) UITextView *topTextView;

@end

@implementation JumpVC

- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationItem.title = self.titlel;
    
    _topTextView = [[UITextView alloc] init];
    _topTextView.font = SYSTEM_FONT_(14);
    _topTextView.textColor = COLOR_Gray;
    _topTextView.editable = NO;
    _topTextView.frame = CGRectMake(0, 0, self.view.width, self.view.height);
    _topTextView.text = self.content;
    [self.view addSubview:_topTextView];
    
    // Do any additional setup after loading the view.
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
