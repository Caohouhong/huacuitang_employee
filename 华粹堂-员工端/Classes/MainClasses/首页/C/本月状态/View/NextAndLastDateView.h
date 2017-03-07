//
//  NextAndLastDateView.h
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/24.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, NextAndLastDateViewButtonType) {
    NextAndLastDateViewButtonTypeLast      = 0, //上一个
    NextAndLastDateViewButtonTypeNext      = 1,  //下一个
};

@protocol NextAndLastDateViewDelegate <NSObject>
- (void)nextAndLastDateBtnClickWithTag:(NextAndLastDateViewButtonType)tag;
@end

@interface NextAndLastDateView : UIView

@property (nonatomic, weak) id<NextAndLastDateViewDelegate> delegate;
@property (nonatomic, strong) UIButton *lastBtn; //上一个
@property (nonatomic, strong) UIButton *nextBtn; //下一个
@property (nonatomic, strong) UILabel *dataLabel; 
@end
