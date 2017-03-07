//
//  SecretTopicVC.m
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/28.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "SecretTopicVC.h"

@interface SecretTopicVC ()

@end

@implementation SecretTopicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"私密话题";
    self.view.backgroundColor = COLOR_BackgroundColor;
    [self drawView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)drawView{
    UIView *topHoldView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 35)];
    topHoldView.backgroundColor = COLOR_BG_DARK_BLUE;
    [self.view addSubview:topHoldView];
    
    UILabel *textlabel = [[UILabel alloc] init];
    textlabel.text = @"喜欢什么，爱好什么，讨厌什么等等";
    textlabel.font = SYSTEM_FONT_(14);
    textlabel.textColor = COLOR_TEXT_DARK_BLUE;
    [self.view addSubview:textlabel];
    
    textlabel.sd_layout
    .leftEqualToView(self.view).offset(15)
    .topSpaceToView(self.view,0)
    .widthRatioToView(self.view,1)
    .heightIs(35);
    
    
}
@end
