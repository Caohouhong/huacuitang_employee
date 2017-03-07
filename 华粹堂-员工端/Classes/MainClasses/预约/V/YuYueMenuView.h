//
//  YuYueMenuView.h
//  华粹堂-员工端
//
//  Created by liqiang on 2016/11/25.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DidClickDateBlick)(NSDate *startDate,NSDate*endDate);

@protocol YuYueMenuViewDelegate <NSObject>

- (void)LeftMenuViewActionIndex:(NSString *)vType;

@end

@interface YuYueMenuView : UIView

@property (nonatomic, assign) BOOL isRightViewHidden;

@property (nonatomic, weak) id<YuYueMenuViewDelegate> menuViewDelegate;
@property (nonatomic, weak) UITextField *nameSearchTextfield;
@property (nonatomic, copy) DidClickDateBlick didClickDateBlick;

- (instancetype)initWithContainerViewController:(UIViewController *)containerVC;

- (void)openLeftView;

- (void)closeLeftView;

@end
