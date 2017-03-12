//
//  ShowPlanViewController.m
//  华粹堂-员工端
//
//  Created by caohouhong on 17/3/7.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "ShowPlanViewController.h"

@interface ShowPlanViewController ()

@end

@implementation ShowPlanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.viewTitle;
    self.view.backgroundColor = [UIColor whiteColor];
    [self drawView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)drawView{
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(15, 15, ScreenWidth - 30, ScreenHeight)];
    textView.backgroundColor = [UIColor whiteColor];
    textView.textColor = COLOR_Black;
    textView.font = SYSTEM_FONT_(15);
    textView.text = self.viewContent ? self.viewContent : @"暂无方案";
    textView.editable = NO;
    [self.view addSubview:textView];
}
@end
