//
//  TopSelectViewTwoBtnView.h
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/27.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, TopSelectViewTwoBtnViewType) {
    TopSelectViewTwoBtnViewTypeLeft      = 0,
    TopSelectViewTwoBtnViewTypeRight     = 1,
};

@protocol TopSelectViewTwoBtnViewDelegate <NSObject>
- (void)topButtonClickWithTag:(TopSelectViewTwoBtnViewType)tag;
@end

@interface TopSelectViewTwoBtnView : UIView

@property (nonatomic, weak) id<TopSelectViewTwoBtnViewDelegate> delegate;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;

@end
