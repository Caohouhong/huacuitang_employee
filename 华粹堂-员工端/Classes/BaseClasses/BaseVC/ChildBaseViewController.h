//
//  ChildBaseViewController.h
//  lingdaozhe
//
//  Created by liqiang on 16/5/5.
//  Copyright © 2016年 bckj. All rights reserved.
//

#import "MainBaseViewController.h"

@interface ChildBaseViewController : MainBaseViewController

@property (nonatomic, weak) UIButton * navBackButton;

-(void)back;
-(UIBarButtonItem *)backButtonItem;

@end
