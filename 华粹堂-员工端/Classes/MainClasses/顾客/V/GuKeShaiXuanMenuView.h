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
@property (nonatomic, weak) UITextField *customSearchTextfield;
@property (nonatomic, weak) UITextField *xiaoFeiMin;
@property (nonatomic, weak) UITextField *xiaoFeiMax;

@property (nonatomic, copy) NSString *level;//540-普通会员,541-A类会员,542-AA类会员,543-AAA类会员,544-AAAA类会员'

- (void)openLeftView;

- (void)closeLeftView;

@end
