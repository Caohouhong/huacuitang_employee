//
//  GuKeShaiXuanMenuView.h
//  华粹堂-员工端
//
//  Created by liqiang on 2016/11/28.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DidClickSureBlick)();


@protocol GuKeShaiXuanMenuViewDelegate <NSObject>

- (void)LeftMenuViewActionIndex:(NSString *)vType;

@end

@interface GuKeShaiXuanMenuView : UIView

@property (nonatomic, copy) DidClickSureBlick didClickSureBlick;

@property (nonatomic, assign) BOOL isRightViewHidden;

@property (nonatomic, weak) id<GuKeShaiXuanMenuViewDelegate> menuViewDelegate;
@property (nonatomic, weak) UITextField *nameSearchTextfield;

@property (nonatomic, copy) NSString *libieId;
@property (nonatomic, copy) NSString *employeeId;
@property (nonatomic, copy) NSString *shopId;

- (void)openLeftView;

- (void)closeLeftView;

@end
