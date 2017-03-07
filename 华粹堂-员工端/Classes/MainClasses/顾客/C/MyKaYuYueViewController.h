//
//  MyKaYuYueViewController.h
//  华粹堂-客户端
//
//  Created by 唐硕 on 16/12/2.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import "ChildBaseViewController.h"

//typedef void(^DidClickDateBlock)(NSDate *startDate,NSDate * endDate);


typedef void(^DidClickDateBlock)(NSDate *startDa1te,NSDate *endD1ate);


@interface MyKaYuYueViewController : ChildBaseViewController

@property (nonatomic, copy) DidClickDateBlock didClickDateBlock;

@end
