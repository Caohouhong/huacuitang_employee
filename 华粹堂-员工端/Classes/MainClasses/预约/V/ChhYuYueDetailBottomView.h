//
//  ChhYuYueDetailBottomView.h
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/24.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, ChhYuYueDetailBotViewType) {
    ChhYuYueDetailBotViewTypeCall      = 0,
    ChhYuYueDetailBotViewTypeMessage   = 1,
    ChhYuYueDetailBotViewTypeChat      = 2,
};

@protocol ChhYuYueDetailBottomViewDelegate <NSObject>
- (void)bottomBtnClickWithTag:(ChhYuYueDetailBotViewType)tag;
@end


@interface ChhYuYueDetailBottomView : UIView

@property (nonatomic, strong) UIButton *callBtn;
@property (nonatomic, strong) UIButton *messageBtn;
@property (nonatomic, strong) UIButton *chatBtn;
@property (nonatomic, weak) id<ChhYuYueDetailBottomViewDelegate> delegate;

@end
