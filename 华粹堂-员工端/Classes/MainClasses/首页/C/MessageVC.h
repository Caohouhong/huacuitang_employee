//
//  MessageVC.h
//  ZhouMo
//
//  Created by liqiang on 16/9/20.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import "ChildBaseViewController.h"

@interface MessageVC : ChildBaseViewController
-(void)newsUpdate:(void (^)(UIBackgroundFetchResult))completionHandler;
-(void)requestData;
@end
