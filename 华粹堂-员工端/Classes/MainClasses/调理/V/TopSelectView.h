//
//  TopSelectView.h
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/26.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, TopSelectViewType) {
    TopSelectViewTypeLeft      = 0,
    TopSelectViewTypeCenter    = 1,
    TopSelectViewTypeRight     = 2,
};

@protocol TopSelectViewDelegate <NSObject>
- (void)topButtonClickWithTag:(TopSelectViewType)tag;
@end

@interface TopSelectView : UIView

@property (nonatomic, weak) id<TopSelectViewDelegate> delegate;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *centerButton;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UIView *markView;
@end
