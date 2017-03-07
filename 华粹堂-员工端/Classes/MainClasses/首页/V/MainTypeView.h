//
//  MainTypeView.h
//  华粹堂-员工端
//
//  Created by 唐硕 on 16/11/24.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^clickOne)(NSInteger tag);
typedef void(^clickTwo)();
typedef void(^clickThree)();

@interface MainTypeView : UIView


//+(instancetype)shareInstance;

@property (nonatomic, copy) clickOne oneBlock;
@property (nonatomic, copy) clickTwo twoBlock;
@property (nonatomic, copy) clickThree threeBlock;

@end
